---
title:  "Dataset Deployments with pbi-tools, 2nd Preview"
published: true
last_updated: 12-Jul-2022
author: Mathias Thierbach
tags: [devops, xmla]
summary: "Announcing the 2nd Preview of the Datasets Deployment pbi-tools release (RC.2). This preview adds support for XMLA refresh tracing, enhanced parameters handling, and the ability to convert \"thick\" reports into dataset and \"thin\" report during deployment."
---

## Dowload the Preview

{% include callout.html content="- [CLI: 1.0.0-rc.2+20220703](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.2%2B20220703)<br/><br/>- [Docker: 1.0.0-rc.2_20220703](https://github.com/pbi-tools/pbi-tools/pkgs/container/pbi-tools-core/27490365?tag=1.0.0-rc.2_20220703)" type="info" %}

{% include tip.html content="A recording demonstrating the new features in this preview is [available on YouTube](https://videos.pbi.tools/dataset-cicd-preview2), courtesy of [Artur König](https://twitter.com/datakoenigartur)." %}

## New Features

- [#147](https://github.com/pbi-tools/pbi-tools/issues/147) [Refresh logs and Refresh summary stats]({% post_url 2022-07-05-dataset-deployment-preview-2 %}#refresh-tracing)
- [#141](https://github.com/pbi-tools/pbi-tools/issues/141) [Deploy dataset report]({% post_url 2022-07-05-dataset-deployment-preview-2 %}#thick-reports)
- [#145](https://github.com/pbi-tools/pbi-tools/issues/145) [Non-string PQ parameters]({% post_url 2022-07-05-dataset-deployment-preview-2 %}#pq-params)
- [#157](https://github.com/pbi-tools/pbi-tools/issues/157) [System parameter replacement in manifest params]({% post_url 2022-07-05-dataset-deployment-preview-2 %}#pq-params)

## Enhancements

- [#153](https://github.com/pbi-tools/pbi-tools/issues/153) `CreateOrOverwrite` now default mode for Report/PBIX deployments

For import deployments (thin reports and PBIX files), the default import mode is now `CreateOrOverwrite` which simplifies the `.pbixproj.json` deployment manifest.

Before:

```json
      "mode": "Report",
      "source": {
        "type": "Folder",
        "path": "./*"
      },
      "authentication": { ... },
      "options": {
        "import": {
          "nameConflict": "CreateOrOverwrite"
        }
      },
      "environments": { ... }
```

After:


```json
      "mode": "Report",
      "source": {
        "type": "Folder",
        "path": "./*"
      },
      "authentication": { ... },
      "environments": { ... }
```

_In this case, the entire `options` section can be omitted._

For reference, any of the valid values [list here](https://docs.microsoft.com/rest/api/power-bi/imports/post-import-in-group#importconflicthandlermode) canbe specified instead of the default `CreateOrOverwrite`.

## Bugfixes

- [#109](https://github.com/pbi-tools/pbi-tools/issues/109) `pbi-tools info` no longer fails when another instance of SSAS rund on the same machine
- [#111](https://github.com/pbi-tools/pbi-tools/issues/111) Model-only import fails due to logging
- [#127](https://github.com/pbi-tools/pbi-tools/issues/127) Folder or File sources containing spaces aren't matched _(Desktop edition only)_
- [#102](https://github.com/pbi-tools/pbi-tools/issues/102) Cross-platfom conform resolution of default TEMP path

## Refresh Tracing {#refresh-tracing}

Do you know what exactly is going on during your dataset refreshes and where most time is spent? SSAS is providing very rich and granular trace events as part of any refresh operation, and those are available to Power BI Premium users via the XMLA endpoint.

However, Power BI Service exposes none of that data, and there is limited tooling available. The tool known to most people today is [SQL Server Profiler](https://docs.microsoft.com/analysis-services/instances/use-sql-server-profiler-to-monitor-analysis-services) which ships with SSMS. With SQL Server Profiler, one manually defines a trace session, connects to an XMLA endpoint, and effectively hits _Start_ and _Stop_ to record events for offline analysis. This is what the _Events Selection_ page looks like:

![SQL Profiler Events Selection](/images/14fig12.jpg)

Whilst this approach is very powerful, it is also quite involved - a user with sufficient privileges explicitly "runs a trace session". This is likely done only as a one-off or in order to troubleshoot production issues.

`pbi-tools` now helps to operationalize that same process and make it part of each Production refresh. Refresh tracing can be enabled as part of a `pbi-tools deploy` refresh. With the feature enabled, **trace event logs** can be emitted to the console (and hence become part of the CI/CD pipline logs). Furthermore, **refresh summary metrics** can be generated and written to a CSV file for external processing.

Analyzing refresh behavior and timings alongside using [VertiPaq Analyzer](https://www.sqlbi.com/tools/vertipaq-analyzer/) should be the two key tools deployed by anyone maintaining a production Power BI dataset. This release of `pbi-tools` makes accessing the former significantly easier and available to a wider audience.

### Setup

As all deployment related settings, _Refresh Tracing_ is configured in a `.pbiproj.json` file, inside the **options/refresh/tracing** section of a deployment manifest. See an example file here with an explanation of the various new settings following below:

<script src="https://gist.github.com/mthierba/fd7b3dc7310ff97aa36946f53b5f646a.js"></script>

| **tracing.enabled** | Use to turn the _Refresh Tracing_ feature on or off. Default: _False_ |
| **tracing.logEvents** | Controls live output of trace events to the console (hence, CI/CD log). |
| **tracing.logEvents.filter** | Filters the events logged to the console. An array of expressions using the format `{EventClass}|{EventSubclass}|{ObjectType}`. Wildcards are supported. See below for further details. |
| **tracing.summary** | Controls the generation of summary stats by monitoring `ProgressReportEnd` events and collecting their _IntegerData_, _Duration_, and _CpuTime_ metrics. |
| **tracing.summary.events** | A string array specifying the _EventSubclass_ names to collect summary stats for. A full list of available values is [available here](https://docs.microsoft.com/analysis-services/trace-events/progress-reports-data-columns#progress-report-enddata-columns). |
| **tracing.summary.objectTypes** | A string array specifying the object types to collect summary stats for. Values must match the object names [listed here](https://docs.microsoft.com/analysis-services/trace-events/analysis-services-object-type-codes-used-in-traces#tabular-object-types). |
| **tracing.summary.outpath** | Generates a CSV file containing summary stats at the specified (relative) file path. Skips if no path is provided. (Do ensure the location is writable!) |
| **tracing.summary.console** | Determines whether or not to print summary stats to the console (in addition to or instead of the CSV file output). |

#### The LogEvents Filter

`pbi-tools` _Refresh Tracing_ currently subscribes to all four [**Progress Reports Event Categories**](https://docs.microsoft.com/analysis-services/trace-events/progress-reports-event-category):

- ProgressReportBegin
- ProgressReportCurrent
- ProgressReportError
- ProgressReportEnd

_Each Progress Report Begin event begins with a stream of progress events and is terminated with a Progress Report End event. The stream may contain any number of Progress Report Current and Progress Report Error events._ (Quoted from the above page.)

In order to limit emitted events to a reasonable selection, each incoming event will have a key generated that concatenates the Event Class, Subclass, and Object type. For instance: `ProgressReportBegin|ReadData|Partition`.

The filter expressions provided at **tracing.logEvents.filter** are used to determine whether or not to log an event. Note that those filters do NOT impact summary stats (those have their independent selection mechanism).

Wildcards (`*`, `?`) are allowed, hence the above example would be matched by any of those filter expressions:

- `*|ReadData|Partition`
- `*|Partition`
- `*`
- `ProgressReportBegin|*|*`
- `ProgressReport*|ReadData|Partition`

This is an example log output generated for the [Contoso Sales Model](https://github.com/pbi-tools/contoso-sales-model) with the settings file above:

```txt
|00:00:01.4394826| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Partition</pii>' of table '<pii>Time Intelligence</pii>'." Rows:null (Partition: Partition)
|00:00:01.4416719| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Partition</pii>' of table '<pii>Metric</pii>'." Rows:null (Partition: Partition)
|00:00:01.4419043| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Info-f44d74ec-0372-4982-8ace-63656474683c</pii>' of table '<pii>Info</pii>'." Rows:null (Partition: Info-f44d74ec-0372-4982-8ace-63656474683c)
|00:00:01.4421741| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Product</pii>' of table '<pii>Product</pii>'." Rows:null (Partition: Product)
|00:00:01.4423584| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Date</pii>' of table '<pii>Date</pii>'." Rows:null (Partition: Date)
|00:00:01.4426052| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Promotion</pii>' of table '<pii>Promotion</pii>'." Rows:null (Partition: Promotion)
|00:00:01.4429962| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Customer</pii>' of table '<pii>Customer</pii>'." Rows:null (Partition: Customer)
|00:00:01.4431927| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Time Intelligence</pii>' table started." Rows:null (Partition: Partition)
|00:00:01.4433958| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Time Intelligence</pii>' table." Rows:4 (Partition: Partition)
|00:00:01.4454190| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Partition</pii>' of table '<pii>Time Intelligence</pii>'." Rows:0 (Partition: Partition)
|00:00:01.4460480| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Sales</pii>' of table '<pii>Sales</pii>'." Rows:null (Partition: Sales)
|00:00:01.4525113| [ProgressReportBegin|TabularRefresh] "Started processing partition '<pii>Store</pii>' of table '<pii>Store</pii>'." Rows:null (Partition: Store)
|00:00:01.4527182| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Metric</pii>' table started." Rows:null (Partition: Partition)
|00:00:01.4528967| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Metric</pii>' table." Rows:4 (Partition: Partition)
|00:00:01.7086326| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Partition</pii>' of table '<pii>Metric</pii>'." Rows:0 (Partition: Partition)
|00:00:03.4487734| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Product</pii>' table started." Rows:null (Partition: Product)
|00:00:03.4491366| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Product</pii>' table." Rows:2517 (Partition: Product)
|00:00:03.4492869| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Info</pii>' table started." Rows:null (Partition: Info-f44d74ec-0372-4982-8ace-63656474683c)
|00:00:03.4495241| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Info</pii>' table." Rows:7 (Partition: Info-f44d74ec-0372-4982-8ace-63656474683c)
|00:00:03.5966709| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Info-f44d74ec-0372-4982-8ace-63656474683c</pii>' of table '<pii>Info</pii>'." Rows:0 (Partition: Info-f44d74ec-0372-4982-8ace-63656474683c)
|00:00:03.5968676| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Product</pii>' of table '<pii>Product</pii>'." Rows:0 (Partition: Product)
|00:00:03.5980443| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Store</pii>' table started." Rows:null (Partition: Store)
|00:00:03.5988739| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Date</pii>' table started." Rows:null (Partition: Date)
|00:00:03.5996038| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Store</pii>' table." Rows:306 (Partition: Store)
|00:00:03.7410000| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Store</pii>' of table '<pii>Store</pii>'." Rows:0 (Partition: Store)
|00:00:03.7412612| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Promotion</pii>' table started." Rows:null (Partition: Promotion)
|00:00:03.7414874| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Promotion</pii>' table." Rows:28 (Partition: Promotion)
|00:00:03.7422141| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Promotion</pii>' of table '<pii>Promotion</pii>'." Rows:0 (Partition: Promotion)
|00:00:03.7423440| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Customer</pii>' table started." Rows:null (Partition: Customer)
|00:00:03.7425389| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Date</pii>' table." Rows:2556 (Partition: Date)
|00:00:03.8863450| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Date</pii>' of table '<pii>Date</pii>'." Rows:0 (Partition: Date)
|00:00:03.8866039| [ProgressReportBegin|ReadData] "Reading data for the '<pii>Sales</pii>' table started." Rows:null (Partition: Sales)
|00:00:03.8888622| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Customer</pii>' table." Rows:10000 (Partition: Customer)
|00:00:03.8890133| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:10000 (Partition: Sales)
|00:00:03.8891499| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Customer</pii>' table." Rows:18863 (Partition: Customer)
|00:00:04.0294533| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Customer</pii>' of table '<pii>Customer</pii>'." Rows:0 (Partition: Customer)
|00:00:04.0305165| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:20000 (Partition: Sales)
|00:00:04.0313302| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:30000 (Partition: Sales)
|00:00:04.0315326| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:40000 (Partition: Sales)
|00:00:04.0316618| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:50000 (Partition: Sales)
|00:00:05.8142209| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:60000 (Partition: Sales)
|00:00:05.8144364| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:70000 (Partition: Sales)
|00:00:05.8145502| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:80000 (Partition: Sales)
|00:00:05.8146863| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:90000 (Partition: Sales)
|00:00:05.8148028| [ProgressReportCurrent|ReadData] "Reading data for the '<pii>Sales</pii>' table." Rows:100000 (Partition: Sales)
|00:00:05.8149232| [ProgressReportEnd|ReadData] "Finished reading data for the '<pii>Sales</pii>' table." Rows:100231 (Partition: Sales)
|00:00:05.8160732| [ProgressReportEnd|TabularRefresh] "Finished processing partition '<pii>Sales</pii>' of table '<pii>Sales</pii>'." Rows:0 (Partition: Sales)
```

Running `pbi-tools deploy` locally first allows to find the appropriate tracing settings. A recommended configuration can be found in [this file](https://github.com/pbi-tools/dataset-devops-demo/blob/311615/.pbixproj.json).

### Analysis

The summary CSV file is particularly useful for further analysis, potentially even trend reporting.

![Summary CSV Excel](/images/2022-07-05-dataset-deployment-preview-2-172951.png)

Pivoting that dataset by Table/Partition and Event allows for a convenient visualization of the various metrics. Note that the timings of each sub type for any given object are not additive since some of those processes run in parallel. The `TabularRefresh` subclass provides the overall timing for a given object's refresh.

![Refresh Summary Pivot](/images/2022-07-05-dataset-deployment-preview-2-161359.png)

### External Tracing Resources

- By far the most comprehensive coverage of the topic (unsurprizingly) is [Marco Russo's](https://twitter.com/marcorus) and [Alberto Ferrari's](https://twitter.com/FerrariAlberto) book [Tabular Modeling in Microsoft SQL Server Analysis Services, Second Edition](https://www.oreilly.com/library/view/tabular-modeling-in/9781509302895/). Chapter 14 ***Monitoring And Tuning A Tabular Service***, section ***Monitoring data refresh*** explains the various trace events and their subclasses and how they are relevant for monitoring refreshes.
- [Chris Webb](https://twitter.com/cwebb_bi) has written about the subject several times over the years:
  - [Analysing Dataset Refresh In Power BI Premium Using SQL Server Profiler](https://blog.crossjoin.co.uk/2020/03/30/analysing-dataset-refresh-in-power-bi-premium-using-sql-server-profiler/)
  - [Finding Power Query Query Execution Times In Power BI And Excel Using SQL Server Profiler](https://blog.crossjoin.co.uk/2019/02/09/power-query-execution-times-using-sql-server-profiler/)
  - [Measuring Power Query CPU Usage During Power BI Dataset Refresh](https://blog.crossjoin.co.uk/2022/07/03/measuring-power-query-cpu-usage-during-power-bi-dataset-refresh/)
- [Phil Seamark](https://twitter.com/PhilSeamark) has provided a very interesting vizualization solution involving a custom C#/TOM application and a Power BI push dataset on [dax.tips](https://dax.tips/2021/05/11/visualise-your-power-bi-refresh-in-real-time/)
  
## Deploying "thick" reports {#thick-reports}

This release adds support for "thick" report deployments - Power BI Desktop projects containing both a dataset and an associated report. This works as an extension to the `Dataset` deployment mode. Unlike the tradional publishing of thick reports from Power BI Desktop, the `pbi-tools` approach converts the report into a thin report and deploys the dataset and the related report as separate artifacts. Which has the added benefit that the report can be downloaded from Power BI Service as a thin report, with no danger of the entire dataset being embedded in the exported file.

The feature is enabled using a single setting inside `options/dataset` and only works if the deployment source is PbixProj folder:

```json
      "options": {
        "dataset": {
          "deployEmbeddedReport": true
        }
      }
```

A _live connection_ file is generated automatically as part of the deployment and is injected into the PBIX file compiled from sources.

By default, the report name and destination workspace match those of the dataset. However, either setting can be customized for each environment:

```json
        "UAT": {
          "workspace": "Datasets [PROD]",
          "displayName": "{{PBIXPROJ_FOLDER}} [UAT]",
          "refresh": true,
          "report": {
            "skip": false,
            "workspace": "Name-or-ID",
            "displayName": "Report Name.pbix"
          }
        }
```

Parameter replacement is supported, and report deployment can be disabled in selected environments (`"skip": true`).

## PowerQuery Parameter Enhancements {#pq-params}

Deployment manifest parameters previously always had to have `string` values. When used for dataset PQ expression replacement, that limited the application to "text" parameters, and also prevented the assignment of the M `null` value (as a language keyword it must not be enclosed in quotes).

This release extends the manifest schema to allow non-string parameters. A _parameters_ object could now look like this:

```json
{
    "Number": 1,
    "Number2": 0.4,
    "Null": null,
    "String": "foo",
    "Bool": true,
    "Date": "#date(2022, 6, 1)",
    "Duration": "#duration(5, 0, 0, 0)"
}
```

Numeric and Boolean parameters are supported, as well as the `null` value.

Any parameter values starting with `#` are considered a literal M expression and are injected verbatim, without any quotation characters, for instance `#duration(5, 0, 0, 0)`.

Furthermore, this release enables correct escaping of literal double-quote characters inside text values. For example, the value `abc"DEF` will be converted to M as `"abc""DEF"`. Previously, those cases would have emitted invalid M code.

An alternative _complex parameter format_ is also supported, allowing for additional metadata attributes to be added to parameters in a future release. In this case, the parameter payload must be a json object with a `value` property (the property name is case insensitive) containing the parameter value. For example:

```json
{
    "Number": { "value": 1},
    "Number2": { "Value": 0.4 },
    "Null": { "VALUE": null },
    "String": { "value": "foo" },
    "Bool": { "value": true },
    "Date": { "Value": "#date(2022, 6, 1)" },
    "Duration": { "value": "#duration(5, 0, 0, 0)" }
}
```

Note that the deployment process does NOT perform type validation. For instance, if a PQ parameter is declared as a `number` in the model, however, a `bool` value is assigned to it via the deployment manifest, it will most likely fail the data refresh. The dataset/manifest author needs to ensure that value types are compatible.

Another enhancement relating to deployment parameters is the ability to reference _system parameters_ within explicit manifest parameters (in addition to environment variables). The standard parameter syntax applies: `{%raw%}{{PARAM_NAME}}{%endraw%}`.

System parameters currently supported are:

| `ENVIRONMENT` | Contains the effective deployment environment name, for instance "Development". |
| `PBITOOLS_VERSION` | Contains the `pbi-tools` version number, for instance "1.0.0-rc.2+20220703". |
| `PBIXPROJ_FOLDER` | _Folder sources only_: Contains the source folder name, for instance "Contoso Sales". |
| `FILE_NAME` | _File sources only_: Contains the source file name, for instance "Contoso Sales.bim". |
| `FILE_NAME_WITHOUT_EXT` | _Always available_: Either the source folder name or the source file name without the extension, whichever applies. |

The example `.pbixproj.json` file listed above demonstrates some of the new parameters features.

## What's Next {#whats-next}

This preview is part of the RC.2 release which will complete the [Datasets Deploy Milestone](https://github.com/pbi-tools/pbi-tools/milestone/3).

{% include callout.html content="**The overall objective is to allow service principals to own Power BI datasets throughout their entire lifetime, i.e. allow for fully automated dataset creation, updates, credentials setting, refreshing, and monitoring.**" type="info" %}

| Done |
| --- |
| [#97](https://github.com/pbi-tools/pbi-tools/issues/97) Create Dataset |
| [#97](https://github.com/pbi-tools/pbi-tools/issues/97) Update Dataset Schema from BIM/PbixProj sources |
| [#97](https://github.com/pbi-tools/pbi-tools/issues/97) Update and freeze dataset parameters during deployment |
| [#97](https://github.com/pbi-tools/pbi-tools/issues/97) Refresh Dataset |
| [#147](https://github.com/pbi-tools/pbi-tools/issues/147) Gather and report refresh statistics |

| To Do |
| --- |
| [#36](https://github.com/pbi-tools/pbi-tools/issues/36) Update Dataset schema from Tabular Editor sources |
| [#146](https://github.com/pbi-tools/pbi-tools/issues/146) Set parameters specific to environment |
| [#129](https://github.com/pbi-tools/pbi-tools/issues/129) Refresh individual tables/partitions |
| [#140](https://github.com/pbi-tools/pbi-tools/issues/140) Set dataset users |
| [#135](https://github.com/pbi-tools/pbi-tools/issues/135) Bind dataset to gateway |
| [#139](https://github.com/pbi-tools/pbi-tools/issues/139) Set Power BI refresh schedule |
| [#141](https://github.com/pbi-tools/pbi-tools/issues/141) Export model dependencies from thin report |
| Set (cloud) credentials (excl OAuth) |
| Apply refresh policy |
| Take Ownership of Dataset |
| Export dataset sources from XMLA endpoint |

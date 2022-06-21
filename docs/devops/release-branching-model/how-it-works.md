---
---

## General

1. Use Issue Tracker to plan [versioned releases](#versioned-releases).
2. Maintain Power BI projects in [source control](#source-control) using [`pbi-tools`](/).
3. Set up different [environments](#environments).
4. Follow the [branching model](#branches).
5. Create a [CI/CD Pipeline](#ci-cd) using [`pbi-tools deploy`](/cli/usage-core.md#deploy).

### Versioned Releases {#versioned-releases}

Each release has a unique version. The version number is immutable and the latest release commit is tagged with the version number.
A proven and recommended versioning scheme is _Semantic Versioning 2.0.0_, see [semver.org](https://semver.org).

- A MAJOR version change indicates breaking changes, for instance v1 -> v2.
- A MINOR version change indicates added functionality, but no breaking changes, for instance v1.1 -> v1.2
- A PATCH version indicates internal bug fix, with no feature changes, for instance v1.1.0 -> v1.1.1

This model is very common in software projects, and applies well to Power BI projects, too.

- "Features" in a Power BI dataset are all the tables, columns, hierarchies, measures, relationships, queries etc. Adding new columns or measures, for example, constitutes a minor version change. Removing or renaming tables would be major version change.

### Power BI Source Control {#source-control}

Source control for Power BI is not officially supported by Microsoft, although it is required for enterprise-grade development. [`pbi-tools`](/) provides an open-source solution. It is a complete solution for both reports and datasets, i.e. allows to go back-and-forth between a PBIX file and a source code representation. _Support for Dataflows is under development._

`pbi-tools` introduces the "PbixProj" format which is an extraction format for PBIX and PBIT files optimized for source control:

![PbixProj Folder](/images/how-it-works-pbixproj-folder.png)

### Environments

#### Example 1

| Environment | Source Branch | Trigger | Target |
| --- | --- | --- | --- |
| Development | Any **Feature Branch** (`Issue/xx`) | PR into `Release/*` created, updated | DEV workspace in PPU |
| Staging/UAT | `Release/*` | PR merged | Staging workspace in Pro/Premium _(for datasets only Premium supported) |
| Production | `main` | PR merged | Production workspace in Pro/Premium |

#### Example 2

| Environment | Source Branch | Trigger | Target |
| --- | --- | --- | --- |
| Development | Any **Feature Branch** (`Issue/xx`) | PR into `Release/*` created, updated | DEV workspace in PPU |
| Integration | `Release/*` | PR merged | Staging workspace PPU |
| UAT | `preview` | PR merged | UAT workspace in Pro/Premium _(for datasets only Premium supported) |
| Production | `main` | **Schedule (aligns schema changes with refresh)** | Production workspace in Pro/Premium |

## Power BI Datasets

### Injecting build/deploy metadata into the model

For end-to-end visibility between the DevOps system and the various Power BI environments, `pbi-tools deploy` supports PQ parameter replacement, allowing to inject information only known at the time of deployment into the model.

An example use case defines a model table called "Info" which is used to hold metadata information about the dataset, exposed via model measures. All table columns are hidden which displays it as a measure-table in Power BI:

![Info table](/images/2022-05-29-dataset-deployment-preview-090429.png)

The PowerQuery source for the table references various PQ parameters in addition to a timestamp that's resolved at the point of refresh:

```powerquery
let
    Source = #table(type table
    [
        #"Label"             = text, 
        #"Timestamp"         = datetime,
        #"Text"              = text
    ], 
    {
        { "Data Updated", DateTimeZone.RemoveZone(DateTimeZone.UtcNow()), null },
        { "Version",      null,   #"Version" },
        { "GitHub SHA",   null,   #"GH-SHA" },
        { "GitHub RunID", null,   #"GH-RunId" },
        { "Branch",       null,   #"GH-Branch" },
        { "Environment",  null,   #"Environment"}
    }
)
in
    Source
````

Secondly, the `pbi-tools` deployment manifest declares various parameters that match those PQ parameters. With the `dataset/replaceParameters` option enabled, those PQ parameters will have new values injected, generally ones which are only available at the time of deployment (for instance, the source branch). _The replacement will also convert the PQ parameters to simple scalar values which has the added benefit that those will no longer show up in the Power BI dataset settings (where values are editable to authorized users)._

Lastly, each of the info values has a corresponding DAX measure defined allowing to expose the injected values in any report connected to the dataset. For instance, the "Branch" measure has this DAX formula:

    LOOKUPVALUE(Info[Text], Info[Label], "Branch")

This is a multi-row card visual displaying all Info parameters from the sample project:

![Info table visual](/images/2022-05-29-dataset-deployment-preview-133637.png)

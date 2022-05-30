---
title:  "Introducing Dataset Deployments with pbi-tools (Preview)"
published: true
author: Mathias Thierbach
tags: []
summary: "Continuing the pbi-tools DevOps story, a new preview of the upcoming 1.0.0-RC.2 release introduces Deployments for (XMLA) Datasets (in addition to the Report deployment mode released with Beta.7). Learn here how it works and what is supported. The new feature will improve further by the time of the RC.2 release based on feedback from this preview."
---

## Overview: Features available in the preview

- Use the new `Dataset` mode in a deployment manifest to deploy a tabular dataset to a XMLA endpoint (only Power BI Premium/PPU supported at this point).
- **Folder** (PbixProj) and **File** (.bim) sources are allowed.
- **Dataset refresh** can be enabled to run as part of the deployment. All refresh types [listed here](https://docs.microsoft.com/rest/api/power-bi/datasets/refresh-dataset-in-group#datasetrefreshtype) are supported. Refresh can be enabled/disabled in each environment individually.
- **PowerQuery parameters** declared in the model can be replaced as part of the deployment. Only `text` parameters are supported.
- Only Power BI service principals are supported to authenticate with.
- Any number of environments can be declared in the manifest. The environment is specified as part of the `pbi-tools deploy` command.
- Each environment supports the `workspace`, `displayName` and `refresh` properties.
  - `workspace` can be the Name or the ID and is required.
  - `displayName` determines the name of the target Power BI dataset. If omitted, this defaults to the source folder/file name.
  - `workspace` and `displayName` support parameter replacement. System parameters provided automatically are: `ENVIRONMENT`, `FILE_NAME_WITHOUT_EXT`, `PBIXPROJ_FOLDER` (_Folder source only_), `FILE_NAME` (_File source only_). In addition, all User parameters (declared in the same deployment manifest) are available.
- Use the `WhatIf` deployment option to verify the setup, validate credentials, and provide a detailed view of runtime parameters.
- The `deploy` command is supported in all flavors of `pbi-tools`: The Desktop CLI, the Core CLI, and the (Linux) Docker container. For CI/CD pipelines, use of the Docker container is highly recommended.
- An end-to-end example using GitHub Actions is available at: <https://github.com/pbi-tools/dataset-devops-demo> ([All workflow runs](https://github.com/pbi-tools/dataset-devops-demo/actions)).

## Dowload the Preview

{% include callout.html content="- [CLI: 1.0.0-rc.2+20220525](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.2%2B20220525) <br/><br/>- [Docker: 1.0.0-rc.2_20220525](https://github.com/pbi-tools/pbi-tools/pkgs/container/pbi-tools-core/23184088?tag=1.0.0-rc.2_20220525)" type="info" %}

## The Deployment Manifest

The Deployment Manifest is a json file named `.pbixproj.json` which should be placed in the root of the repository. The same file can be used to describe multiple deployments to perform against sources inside the same repository. An example manifest can be found here: <https://github.com/pbi-tools/dataset-devops-demo/blob/main/.pbixproj.json>.

<script src="https://gist.github.com/mthierba/ea386e4c73ec1c0f06ccab2fe3bcc411.js"></script>

- This manifest contains a single deployment profile called "Contoso".
- SOURCE
  - The **"Contoso Sales" folder** is declared as the deployment source. This is a PbixProj folder generated from a PBIX dataset via [`pbi-tools extract`](https://pbi.tools/#extract). Alternatively, a `File` source could be declared with the _Path_ pointing to a BIM/TMSL file (for instance, from a Tabular Editor project).
- AUTHENTICATION
  - A service principal in the `pbitools.org` tenant is declared. The secret is provided via the `PBI_CLIENT_SECRET` environment variable.
  - Define it as a [GitHub Actions Secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) and ensure the workflow file references the secret at the `pbi-tools deploy` step, see below.
  - Ensure the service principal is authorized at the Power BI Tenant level and has at least _Contributor_ permissions in the destination workspaces.
- OPTIONS
  - `refresh/skipNewDataset`: Since credentials for XMLA-deployed datasets need to be set explicitly in Power BI Service ([see here](https://docs.microsoft.com/power-bi/enterprise/service-premium-connect-tools#setting-data-source-credentials)), this setting skips refresh for any newly created datasets (the refresh would fail). Only datasets already existing before the deployment will be refreshed automatically.
  - `refresh/method`: "XMLA" is the only supported method during the preview. An altenative "API" refresh method will be added later.
  - `refresh/type`: Supports any of the refresh types [listed here](https://docs.microsoft.com/rest/api/power-bi/datasets/refresh-dataset-in-group#datasetrefreshtype).
  - `dataset/replaceParameters`: Enables PQ parameter replacement inside the model, see below.
- PARAMETERS
  - Parameters declared here can be used within environment properties and as part of PQ parameter replacement.
  - Only string values are allowed.
  - Values can contain references to environment variables, using the `%VARIABLE_NAME%` syntax.
  - The example uses three [default GitHub Actions environment variables](https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables) to inject the GitHub branch name, run ID, and commit SHA into the model.
- ENVIRONMENTS
  - _Development_
    - Deploys into the "Datasets [DEV]" workspace. The dataset name receives a "[DEV]" suffix, i.e. resolves to "Contoso Sales [DEV]" in this case.
    - _Development_ is the default environment and can be omitted when invoking `pbi-tools deploy`.
  - _UAT_
    - Deploys into the "Datasets [PROD]" workspace. The dataset name receives a "[UAT]" suffix, i.e. resolves to "Contoso Sales [UAT]" in this case.
  - _Production_
    - Deploys into the "Datasets [PROD]" workspace.
    - Since `displayName` is not declared, the name is derived from the source, "Contoso Sales" in the example.
  - All environments have refresh enabled (defaults to `false` if omitted).

## Example: Integrate into GitHub Actions

An example GitHub workflow definition is available here: <https://github.com/pbi-tools/dataset-devops-demo/blob/main/.github/workflows/deploy-uat.yml>.

<script src="https://gist.github.com/mthierba/9fb927470616c82a630452b00cf07487.js"></script>

- Triggers
  - The _UAT_ workflow shown above is triggered when changes are pushed to any of the `Release/*` branches.
  - Alternatively, the workflow can be invoked manually. In that case, it is possible to run `pbi-tools deploy` in _WhatIf_ mode.
- _Deployment_ job
  - The job runs on the standard Ubuntu runner and uses the `pbi-tools-core` Docker container, which has all dependencies pre-installed. This is the recommended configuration as it keeps the workflow definition simple and improves execution times.
  - `pbi-tools info` is executed first. This is not required and merely serves informational and diagnostics purposes.
  - `pbi-tools deploy` runs next, conditionally in _WhatIf_ mode.
  - The `PBI_CLIENT_SECRET` environment variable required by the deployment manifest is injected from GitHub Actions secrets. Secrets are not made available as environment variables automatically, and need to be declared explicitly.

## WhatIf

Very useful when creating the deployment manifest for the first time, and to debug issues in different environments, is the `pbi-tools deploy` _WhatIf_ mode. It runs through all relevant aspects of the deployment ___without modifying any remote assets___. Furthermore, additional diagnostic log messages are emitted.

Deployment steps checked via _WhatIf_:

- Authentication settings are correct and an access token can be retrieved.
- The sources can be accessed and a valid model definition can be generated.
- The destination workspace can be resolved and accessed.
- Would the deployment create a new dataset or overwrite an existing one?
- All parameters are fully resolved and matching PQ parameters are listed.

Invoke _WhatIf_ mode as `pbi-tools deploy {src-folder} {profile-name} {environment} -whatif`.

This is an example output from a _WhatIf_ run of the sample project:

```txt
Reading PBIXPROJ settings from: /__w/dataset-devops-demo/dataset-devops-demo/.pbixproj.json
=== Deployment WhatIf mode enabled ===
Starting deployment 'Contoso' into environment: Development ...
Determining dataset from Folder source: "./Contoso Sales"
Base folder: /__w/dataset-devops-demo/dataset-devops-demo
Reading PBIXPROJ settings from: /__w/dataset-devops-demo/dataset-devops-demo/Contoso Sales/.pbixproj.json
Acquiring access token...
Token Endpoint: https://login.microsoftonline.com/pbitools.org/oauth2/v2.0/token
Access token received. Expires On: 05/30/2022 07:55:16 +00:00
---
Resolved workspace ID '356c7e5e-12e3-4866-8641-2170156befd9' for workspace: 'Datasets [DEV]'
Dataset: /__w/dataset-devops-demo/dataset-devops-demo/Contoso Sales
  DisplayName: Contoso Sales [DEV]
  Parameters:
  * Version = "1.1.0"
  * GH-Branch = "Release/1.1"
  * GH-RunId = "2407292584"
  * GH-SHA = "2f18ee44542cb35ef08236ca25ce9a98224f7d04"
  * ENVIRONMENT = "Development"
  * PBIXPROJ_FOLDER = "Contoso Sales"
  * FILE_NAME_WITHOUT_EXT = "Contoso Sales"
  Workspace: Datasets [DEV] (356c7e5e-12e3-4866-8641-2170156befd9)
---
Connecting to XMLA endpoint: powerbi://api.powerbi.com/v1.0/myorg/Datasets [DEV]
Server Properties:
* CompatibilityMode           : PowerBI
* ConnectionString            : Data Source='powerbi://api.powerbi.com/v1.0/myorg/Datasets [DEV]';
* DefaultCompatibilityLevel   : 1500
* Edition                     : Enterprise64
* ID                          : autopremiumhostuksouth000-058
* Name                        : Datasets [DEV]
* SupportedCompatibilityLevels: 1100,1103,1200,1400,1450,1455,1460,1465,1470,1475,1480,1500,1510,1520,1530,1535,1540,1545,1550,1560,1561,1562,1563,1564,1565,1566,1567,1568,1569,1570,1000000
* Version                     : 16.0.30.25
Deserializing tabular model from sources...
Setting model expression [Version]
	Old value: "VERSION" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]
	New value: "1.1.0"
Setting model expression [GH-SHA]
	Old value: "GH-SHA" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]
	New value: "2f18ee44542cb35ef08236ca25ce9a98224f7d04"
Setting model expression [GH-RunId]
	Old value: "GH-RunId" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]
	New value: "2407292584"
Setting model expression [Environment]
	Old value: "ENVIRONMENT" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]
	New value: "Development"
Setting model expression [GH-Branch]
	Old value: "GH-Branch" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]
	New value: "Release/1.1"
Checking for existing database with matching name...
Matching dataset found.
TOM Database Properties:
* ID                    : 456ee36c-c19e-4aca-ac58-7c1468f80ce4
* Name                  : Contoso Sales [DEV]
* Description           : 
* CompatibilityLevel    : 1550
* CreatedTimestamp      : 05/26/2022 12:09:46
* StructureModifiedTime : 05/26/2022 12:09:54
* EstimatedSize         : 9742372
Deployment completed successfully.
````

## Injecting build/deploy metadata into the model

The example project demonstrates an advanced use case for PQ parameter replacement, a feature very unique to `pbi-tools`! Firstly, the model contains a table called "Info" which is used to hold metadata information about the dataset, exposed via model measures. All table columns are hidden which displays it as a measure-table in Power BI:

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

Find the full setup of this feature in the sample repository [here](https://github.com/pbi-tools/dataset-devops-demo/tree/main/Contoso%20Sales/Model).

## Additional features planned/Not in scope

- Support TOM refresh policies <span class="label label-primary">Planned</span>
- Support selective refresh types (for instance, `Full` for some tables/partitions, and `Automatic` for all others) <span class="label label-primary">Planned</span>
- Support conditional refresh: Evaluate the update impact report and determine whether changes committed require a refresh (measure-only updates, for instance, do not) <span class="label label-default">Requires votes</span>
- Implement "API" refresh mode <span class="label label-primary">Planned</span>
- Deploy to Azure Analysis Services <span class="label label-default">Requires votes</span>
- Set Power BI refresh schedule as part of deployment <span class="label label-primary">Planned</span>
- Set Power BI datset users <span class="label label-primary">Planned</span>
- Bind dataset to gateway <span class="label label-primary">Planned</span>
- Allow deploying a report committed as part of the same PbixProj as a separate thin report <span class="label label-primary">Planned</span>
- The Tabular Editor Save-to-folder format is not currently supported as the PbixProj model format has some differences. Achieving parity with Tabular Editor and being able to support existing Tabular Editor projects directly is planned and tracked in [GitHub Issue #36](https://github.com/pbi-tools/pbi-tools/issues/36). <span class="label label-danger">Important</span>

## Feedback Requested

The Dataset deployment mode is provided as a preview now to allow the implementation to stabilize for the RC.2 release.

Please do try out the new features and provide your feedback! Use the [existing GitHub issue](https://github.com/pbi-tools/pbi-tools/issues/97) or [create a new one](https://github.com/pbi-tools/pbi-tools/issues/new).

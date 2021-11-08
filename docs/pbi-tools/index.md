---
title: pbi-tools CLI
summary: "'pbi-tools' is a command-line tool bringing source-control features to Power BI. It works alongside Power BI Desktop and enables mature enterprise workflows for Power BI projects."
permalink: /pbi-tools/
---
An example project is available here: <https://github.com/action-bi-toolkit/adventureworksdw2020-pbix>

## User Notes

### Installation

Download the tool as a ZIP file (no installer required) from [Releases](https://github.com/action-bi-toolkit/pbi-tools/releases/latest) (under _Assets_). Extract and run from a command prompt.

Make sure to [unblock the ZIP file before extracting](https://singularlabs.com/tips/how-to-unblock-a-zip-file-on-windows-10/).

### Tool Actions

* **[extract](./usage.md#extract)** • _Extracts the contents of a PBIX/PBIT file into a folder structure optimized for source control_
* **[compile-pbix](./usage.md#compile-pbix)** • _Generates a PBIX/PBIT file from sources. PBIX is supported for report-only files, PBIT for files containing models_
* **[deploy](./usage.md#deploy)** • <span class="label label-primary">NEW in 1.0.0-beta.7</span> _Executes a deployment manifest provided in a PbixProj folder. The initial release limited to Report-only PBIX deployments from a PbixProj folder using service principal authentication. Additional functionality is being added in the next releases_
* **[export-bim](./usage.md#export-bim)** • _Generates a BIM file deployable to an XMLA endpoint from sources. Supports both Power BI Premium and Azure Analysis Services_
* **[extract-data](./usage.md#extract-data)** • _Exports all tables into CSV files from either an offline PBIX file or a running Power BI Desktop session_
* **[info](./usage.md#info)** • _Prints diagnostics info about the local Power BI environments. Optionally checks for the latest Power BI Desktop release available from Microsoft Downloads_
* **[launch-pbi](./usage.md#launch-pbi)** • _Launch a new Power BI Desktop instance with a given PBIX/PBIT file. Does not support Windows Store version_

### Detailed Usage Notes

See [detailed CLI docs here](./usage.md).

Running `pbi-tools.exe` with no actions specified prints all available options.

Running `pbi-tools {action} -?` prints usage details for that specific action.

![Extract Usage Screenshot](/images/pbi-tools--extract-usage-screenshot.png)

### Prerequisites - Desktop Version

* Windows 64-bit
* Power BI Desktop 64-bit. Installer version (default location) and/or Windows Store version supported. Optionally, `pbi-tools` works with Power BI Desktop in a custom location, provided the path is specified in the `PBITOOLS_PbiInstallDir` environment variable.
* .Net Framework Runtime 4.7.2 (Comes with Power BI Desktop)

### Prerequisites - Core Version

* Any 64-Bit OS [supported by .Net 5](https://github.com/dotnet/core/blob/main/release-notes/5.0/5.0-supported-os.md)
* [.Net 5 Runtime](https://dotnet.microsoft.com/download/dotnet/5.0/runtime) pre-installed

### Command-line Syntax

    -argumentName argumentValue
    /argumentName:argumentValue
    -argumentName                   - If the argument is a boolean it will be true in this case.

### Diagnostics

* Log output can be controlled using the environment variable `PBITOOLS_LogLevel`.
* Allowed values are:
  - Verbose
  - Debug
  - Information
  - Warning
  - Error
  - Fatal
* The default is ***Information***, which is also effective when an unknown/invalid option has been specified.

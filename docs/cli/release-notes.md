---
title: pbi-tools Release Notes
permalink: /cli/release-notes.html
---

## [1.0.0-rc.3](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.3) - 2023-04-11 "TMDL Preview-1"

### [#262](https://github.com/pbi-tools/pbi-tools/issues/262) TMDL Serialization Support

This release adds support for the [newly announced](https://powerbi.microsoft.com/blog/announcing-public-preview-of-the-tabular-model-definition-language-tmdl/) Tabular Model Definition Language (TMDL).

- New model serialization modes: `Tmdl` (default), `Legacy` (PbixProj)
- New (optional) environment variable: `PBITOOLS_DefaultModelSerialization`

### New CLI action: extract-pbidesktop

- Extracts binaries from a PBIDesktopSetup.exe\|.msi installer bundle (silent/x-copy install). (Implemented using an embedded tool: wix-extract.exe)
- Arguments:
  - `<installerPath>` - The path to an existing PBIDesktopSetup.exe\|PBIDesktopSetup.msi file.
  - `<targetFolder>` - The destination folder. '-overwrite' must be specified if folder is not empty.
  - `<overwrite>` - Overwrite any contents in the destination folder. Default: false

### [#195](https://github.com/pbi-tools/pbi-tools/issues/195) Deployments - Setting dataset credentials

- Added support for Anonymous and OAuth2 (cloud) credentials
- Case-insensitive matching of data sources
- Manifest Schema Changes
  - manifest.credentials[].updateMode: { NotSpecified, Always, Never, BeforeRefresh }
  - manifest.credentials[].type: { Basic, Anonymous, OAuth2 }
  - manifest.credentials[].authority
  - manifest.credentials[].validateAuthority
  - manifest.credentials[].tenantId
  - manifest.credentials[].clientId
  - manifest.credentials[].clientSecret
  - manifest.credentials[].scopes
  - manifest.credentials[].useDeploymentToken

### Other Changes

- Change to 'launch-pbi' CLI action: `<pbixPath>` argument is now optional. If not specified, a new PBIDesktop instance is started without opening an existing file.
- New build target: "BuildTools" - Builds all csproj inside ./tools and bundles each tool output as a .zip archive in ./.build/out/*.zip

## [1.0.0-rc.2](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.2) - 2023-01-09

- **[#97](https://github.com/pbi-tools/pbi-tools/issues/97) Model Deployments**
- [#147](https://github.com/pbi-tools/pbi-tools/issues/147) Refresh Tracing
- [#141](https://github.com/pbi-tools/pbi-tools/issues/141) Deployment of "thick" reports
- [#145](https://github.com/pbi-tools/pbi-tools/issues/145) Non-string deployment parameters
- [#146](https://github.com/pbi-tools/pbi-tools/issues/146) Environment-scoped parameters
- [#168](https://github.com/pbi-tools/pbi-tools/issues/168) SqlScripts Deployments
- [#129](https://github.com/pbi-tools/pbi-tools/issues/129) Object-specific refresh
- [#135](https://github.com/pbi-tools/pbi-tools/issues/135) Bind to Gateway (new datasets)
- [#167](https://github.com/pbi-tools/pbi-tools/issues/167) Report partition status after update/refresh
- [#169](https://github.com/pbi-tools/pbi-tools/issues/169) Report datasources
- [#151](https://github.com/pbi-tools/pbi-tools/issues/151) Deployments of Incremental Refresh datasets
- [#195](https://github.com/pbi-tools/pbi-tools/issues/195) Set (Cloud) credentials during dataset deployment - Basic
- **[#26](https://github.com/pbi-tools/pbi-tools/issues/26) Bookmarks** (PbixProj v0.12 schema)
- [#91](https://github.com/pbi-tools/pbi-tools/issues/91) Serialize/Deserialize _MobileState_
- [#153](https://github.com/pbi-tools/pbi-tools/issues/153) Make "CreateOrOverwrite" default import mode
- [#202](https://github.com/pbi-tools/pbi-tools/issues/202) Ship .Net 7 version of pbi-tools Core
- [#56](https://github.com/pbi-tools/pbi-tools/issues/56) Support for long paths on Windows
- Fixed [#109](https://github.com/pbi-tools/pbi-tools/issues/109) 'pbi-tools info' no longer fails when another instance of SSAS runs on the same machine
- Fixed [#127](https://github.com/pbi-tools/pbi-tools/issues/127) Folder or File sources containing spaces aren't matched (Desktop edition only)
- Fixed [#102](https://github.com/pbi-tools/pbi-tools/issues/102) x-plat conform resolution of TEMP path
- Fixed [#111](https://github.com/pbi-tools/pbi-tools/issues/111) Deployment fails in model-only mode (due to logging)
- Fixed [#207](https://github.com/pbi-tools/pbi-tools/issues/207) Dataset deployment fails if model has field parameters
- Fixed [#219](https://github.com/pbi-tools/pbi-tools/issues/219) pbi-tools Core does not compress PBIX files when compiling
- Libraries updated: TOM 19.54, Power BI API 4.11, MSAL 4.49, db-up 5.0
- Tested with PBI Desktop 2.112 (Dec '22)
- Converted Fake build system from runner to fsproj

## [1.0.0-rc.1](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.1) - 2022-03-06 "SQLBits Edition"

This is ***Release Candidate 1*** for the 1.0 version. `pbi-tools` has now moved out of the *Beta* stage.

- PbixProj v0.11 Schema
  - [#96](https://github.com/pbi-tools/pbi-tools/issues/96) New Model settings: settings/model/measures (format, extractExpression)
  - [#96](https://github.com/pbi-tools/pbi-tools/issues/96) BREAKING CHANGE: Measures json format now default
  - [#90](https://github.com/pbi-tools/pbi-tools/issues/90) Always serialize (partial) partitions payload, ensuring 'queryGroup' property is retained
  - [#19](https://github.com/pbi-tools/pbi-tools/issues/19) Do not serialize empty model/annotations[]
  - [#85](https://github.com/pbi-tools/pbi-tools/issues/85) Visuals with titles only differing in casing are now extracted into unique folders
- [#89](https://github.com/pbi-tools/pbi-tools/issues/89) EXTRACT/WATCH Mode
  - Enabled using `-watch` flag
  - Requires `-pid {ProcessID}` argument specifying PID of PBI Desktop process to attach to
  - Example usage: `pbi-tools extract -pid 12345 -watch`
  - PBIX file path and model port number are derived from PBI session info (available via `pbi-tools info`)
  - Watch mode terminates when the PBI Desktop instance exits or on CTRL+C
- Fixed [#72](https://github.com/pbi-tools/pbi-tools/issues/72) `pbi-tools git branch` no longer propagates exception if no repo is found
- Fixed [#79](https://github.com/pbi-tools/pbi-tools/issues/79) Ensure `./.temp` exists on fresh clone of repo
- Fixed [#78](https://github.com/pbi-tools/pbi-tools/issues/78) `pbi-tools extract` fails when msmdsrv cannot be started
  - New env setting `PBITOOLS_Debug` will launch msmdsrv in debug mode (set to "1", "True", "true" to enable)
    - CWD is used as working directory (be careful as this creates a potentially large number of files!)
    - Working directory is not removed after extraction - files are kept for inspection
  - `<Language/>` setting in `msmdsrv.ini` is always left as "0" (instead of `CultureInfo.CurrentCulture.LCID`, which might lead to unsupported values on non-English OS)
  - Thanks to [@janmechtel](https://github.com/janmechtel) for diagnosing the issue!
- [#81](https://github.com/pbi-tools/pbi-tools/issues/81) Clarified Compile/Format requirements
  - Improved CLI docs
  - Always fail 'compile' when data model is detected and 'PBIX' was selected. Display error w/o stack trace for better readability.
- Fixed [#85](https://github.com/pbi-tools/pbi-tools/issues/85) Report visuals don't re-compile correctly when names differ only in casing ("READY" vs "Ready")
  - Now using case-insensitive folder name comparer
  - Thanks to [@joeg76](https://github.com/joeg76) for diagnosing and reporting!
- [#90](https://github.com/pbi-tools/pbi-tools/issues/90) Ensure "queryGroup" is always extracted for all partitions
  - Breaking Change: PBID M partition declarations now remain in table.json (ensuring additional properties like 'queryGroup' ar retained)
  - Thanks to [@joeg76](https://github.com/joeg76) for detailed issue report
- [#96](https://github.com/pbi-tools/pbi-tools/issues/96) New Measure Serialization Settings
  - ***BREAKING CHANGE***: 'json' now default, 'xml' opt-in
  - Fixes [#87](https://github.com/pbi-tools/pbi-tools/issues/87) and [#93](https://github.com/pbi-tools/pbi-tools/issues/93): Non-scalar measure properties are serialized and deserialized correctly
  - Thanks to [@didierterrien](https://github.com/didierterrien) and [@scottstauffer-fc](https://github.com/scottstauffer-fc) for reporting those!
- `pbi-tools info` Enhancements
  - "pbixProjVersion", "locale" added
- New ENV setting: 'PBITOOLS_UICulture'
  - Overwrite default UICulture set by OS
  - Use any name supported by <https://docs.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo.createspecificculture>
  - Specify "IVL" for *Invariant Culture* (Code: 127)
- NEW: **Docker image released for `pbi-tools Core`**: <https://github.com/pbi-tools/pbi-tools/pkgs/container/pbi-tools-core>
- Build system: Upgraded FAKE to 5.22, Paket to 7.0.2
- Dependencies updated: PeNet (2.9.7), Power BI API (4.3), AMO/TOM (19.36), MSAL (4.42), HtmlAgilityPack (1.11.42)
- Tested with Power BI Desktop 2.102 (Feb 2022)

## [1.0.0-beta.8](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-beta.8) - 2022-01-26

- [#48](https://github.com/pbi-tools/pbi-tools/issues/48) **deploy** action, 2nd release
  - Folder wildcard source
  - Source path parameters
  - Workspace Name & Id support
  - 'File' source
  - 'WhatIf' mode
  - Support for all Azure Clouds (options/pbiBaseUri, authentication/authority)
- [#16](https://github.com/pbi-tools/pbi-tools/issues/16) Core version
  - Breaking: Now targets .Net 6 (LTS release)
  - Removed various CLI options not applicable to Core edition (`cache`, `export-data`: *pbixPath*, `generate-bim`: *generateDataSources*)
  - Edition ("Desktop" vs "Core") now displayed in `info` output and usage docs
  - Dedicated usage page for Core version at <https://pbi.tools/cli/usage-core.html>
  - Increased test coverage
- **PBIXPROJ v0.10** schema
  - [#29](https://github.com/pbi-tools/pbi-tools/issues/29) Support for custom settings in `.pbixproj.json` for integration with external tools
  - [#48](https://github.com/pbi-tools/pbi-tools/issues/48) Breaking: 'nameConflict' moved into deployments/options/import
  - [#48](https://github.com/pbi-tools/pbi-tools/issues/48) Breaking: 'workspaceId' is now 'workspace' in deployments/environment
  - [#48](https://github.com/pbi-tools/pbi-tools/issues/48) New: Optional 'description' in deployment profile
  - [#19](https://github.com/pbi-tools/pbi-tools/issues/19) New Model settings: settings/model/annotations (exclude, include)
- [#61](https://github.com/pbi-tools/pbi-tools/issues/61) New action: `convert`
- [#19](https://github.com/pbi-tools/pbi-tools/issues/19) New Model serialization rules
  - Model annotation exclude/include
  - Suggested setting: `{ "exclude": [ "PBI_*" ], "include": [ "PBI_QueryOrder" ]}`
- [#59](https://github.com/pbi-tools/pbi-tools/issues/59) Fixed: Measure/ExtendedProperties deserialization fails
- [#44](https://github.com/pbi-tools/pbi-tools/issues/44) BREAKING: Two CLI actions renamed
  - `extract-data` -> `export-data`
  - `export-bim` -> `generate-bim`
  - _Previous action names are still functional, but not exposed in usage docs._
- [#60](https://github.com/pbi-tools/pbi-tools/issues/60) Fixed: Introduced new env setting `PBITOOLS_AppDataDir`, allowing to customize the default AppData location (in the `%LOCALAPPDATA%` folder). When the Windows Store version of PBI Desktop is used, that location is used to shadow-copy the msmdsrv engine. Some organizations prevent running executables from within `%LOCALAPPDATA%`. This is only needed to extract from .pbix files with an embedded model.
- [#64](https://github.com/pbi-tools/pbi-tools/issues/64) New action: `init`
- [#62](https://github.com/pbi-tools/pbi-tools/issues/62) New action: `git`
- `info` action: *pbiInstallation* json no longer contains the `v3ModelEnabled` property (the V3 format is the default in PBI Desktop)
- Fixed some memory leaks in xml and resources deserializers.
- Various Dependencies upgraded, including:
  - AMO/TOM: 19.32
  - Power BI API: 4.2
  - MSAL: 4.40
- Build System
  - SemVer build identifiers supported with special syntax in RELEASE_NOTES.md.
  - Simplified csproj setup using a common `Directory.Build.targets` file in './src' (see: <https://docs.microsoft.com/visualstudio/msbuild/customize-your-build?#directorybuildprops-and-directorybuildtargets>).
  - Optional env setting `PBITOOLS_TempDir` supported for the _SmokeTest_ target.
  - Ensured compatibility with .Net 6 by upgrading to `fake-cli` 5.21.
- Tested with Power BI Desktop 2.100 (Dec 2021)

## [1.0.0-beta.7](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-beta.7) - 2021-11-07

* [#16](https://github.com/pbi-tools/pbi-tools/issues/16) **pbi-tools Core Version** released (with distributions for Win x64, Linux Desktop x64, Linux Alpine x64). This version is available cross-platform and supports CI/CD deployment and automation scenarios where a local Power BI Desktop installation is not available.
* [#16](https://github.com/pbi-tools/pbi-tools/issues/16) Full/classic version of pbi-tools rebranded as "Desktop CLI" (exposed as "edition" `info` property)
* compile-pbix improvements: New `PbixWriter` API for Core version
* [#48](https://github.com/pbi-tools/pbi-tools/issues/48) **New 'deploy' CLI Action**, initial release limited to Report-only PBIX deployments from a PbixProj folder using service principal
* [#46](https://github.com/pbi-tools/pbi-tools/issues/46) `[compile-pbix]` Emit warning when creating PBIX output with model
* Chore: Updated dependencies (Fody, Costura.Fody, HtmlAgilityPack, Microsoft.Identity.Client, PeNet)
* Tested with Power BI Desktop 2.98 (Oct 2021)

## 1.0.0-beta.6 - 2021-10-11

* [#16](https://github.com/pbi-tools/pbi-tools/issues/16) Infrastructure updates for upcoming .Net 5 version
* Upgraded dependencies: CsvHelper, Fody, Costura.Fody
* Upgraded AMO/TOM libraries to 19.26
* [#13](https://github.com/pbi-tools/pbi-tools/issues/13) Hardened PBI Desktop API dependency: Improved forward-compatibility (IPowerBIPackage no longer statically implemented)
* [#22](https://github.com/pbi-tools/pbi-tools/issues/22) `export-bim`: AAS datasources no longer generated by default (opt-in via "-generateDataSources")
* [#25](https://github.com/pbi-tools/pbi-tools/issues/25) `info` Path of executing tool shown as _toolPath_
* Tested with Power BI Desktop 2.96, 2.97

## 1.0.0-beta.5 - 2021-05-23

* Upgraded dependencies: Newtonsoft.Json, CsvHelper, Moq, Fody, Costura.Fody, Polly
* Upgraded AMO/TOM libraries to 19.21
* PbixProj v0.9 Format
  * New Mashup serialization settings supported: `Default`, `Raw`, `Expanded`. Mode is persisted in PBIXPROJ settings, and can be provided as a command-line argument to the `extract` action.
  * **BREAKING CHANGE**: 'Expanded' is now considered legacy and no longer the default serialization mode. The `compile-pbix` action only supports projects extracted using the _Default_ or _Raw_ Mashup serialization mode.
* New action: `launch-pbi` (Only supports classic installer, not Windows Store version)
* `compile-pbix` Action
  * 'outPath' not specified: Derive from project folder
  * 'outPath' is existing file: Overwrite existing file if '-overwrite' is specified, fail otherwise
  * 'outPath' is existing directory: Generate file name from project folder, and place in directory. Fail if file exists and '-overwrite' is not specified
  * 'outPath' has extension: Assume to be file path
  * 'outPath' has no extension: Assume to be directory, generate file name from project folder
  * Sources containing a tabular model are suported.
* `extract` Action
  * [#14](https://github.com/pbi-tools/pbi-tools/issues/14) Support reading model from running Power BI Desktop instance. Specify port number via optional '-pbiPort' argument.
* Tested with Power BI Desktop 2.91, 2.92, 2.93

## 1.0.0-beta.4 - 2021-03-28

* PbixProj v0.8 Format
  * /Mashup extracted from V3 models (when present in PBIX)
* Fix bug in Report serializer: 64-bit id values
* Prevented `compile-pbix` from running when sources contain Model (files generated would currently be invalid)

## 1.0.0-beta.3 - 2021-03-26

* PbixProj v0.7 Format
  * Generate /Report/sections sub-folders using page index and title (e.g.: "000_Introduction")
  * Generate /Report/../visualContainers sub-folders using unique combination of visual `tabOrder`, `title`, `type`, `name` (e.g.: "00000_textbox (dbb7a)")
* FEATURE: `compile-pbix` action (EXPERIMENTAL)
  * Compile PBIX or PBIT file from PbixProj sources
* Improved diagnostic logging

## 1.0.0-beta.2 - 2021-03-21

* Upgraded AMO library to 19.18, supporting latest TMSL features (Compatibility level 1562)
* Improved documentation of CLI actions and arguments, Inserted Usage docs into README and Usage.md
* PbixProj v0.6 format: ... table/columns/*, table.dax, measure.dax, column.dax, /cultures #1 #2 #5
* Extract action: -extractFolder, -modelSerialization
* PbixProj Settings: model.serializationMode, model.ignoreProperties
* Upgraded various other dependencies
* Fix for breaking change in CsvHelper v20 API
* Added Sample project (Adventure Works DW 2020)
* Added substantial number of unit tests
* Switched 'powerbi-desktop-samples' submodule to "main" branch
* Added './pbi-tools.local.cmd'
* Using paket as dotnet local tool, removed local copy of "paket.exe"
* 'export-usage' action added
* 'extract-data' - DateTime format can be specified
* New build target: "UsageDocs"
* Added attribution to Win32 files (from projectkudu/KuduHandles)

## 1.0.0-beta.1 - 2020-11-18

* Bugfix for Power BI Desktop Nov 2020 release (2.87)
* Made implementation backwards-compatible: V3 models can be extracted with any prior version of PBI Desktop, only legacy models require the Nov 2020 version
* Upgraded AMO library to 19.12, supporting latest TMSL features
* Upgraded various other dependencies

## 1.0.0-alpha.7 - 2020-09-21

* Upgraded AMO library to 19.10, supporting latest TMSL features
* Resolve #6: In exported BIM, partition name matches table name if there is only one partition

## 1.0.0-alpha.6 - 2020-09-01

* Added extra error handling to V3 Model Feature Switch detection (enable via "Verbose" loglevel setting)
* "info" action: Added 'settings', listing pbi-tools specific environment variables -- Resolves #4
* New CLI action: "extract-data"
  * Extracts all data from a Tabular model into CSV files
  * Supports reading from PBIX file as well as from live session

## 1.0.0-alpha.5 - 2020-08-29

* Upgraded AMO library to 19.9, supporting latest TMSL features
* New CLI action: "cache"
* "info" action: Added 'pbiInstall/V3ModelEnabled'
* "cache" action: Manages the internal assembly cache for MSMDSRV (Options: List,Clear)
* Bugfix for Aug 2020 release (2.84)
* <https://github.com/microsoft/powerbi-desktop-samples.git> added as submodule (/data/external) for testing purposes

## 1.0.0-alpha.4 - 2020-07-21

* Upgraded AMO library to 19.6, supporting latest TMSL features
* Fixed braking change in Power BI Desktop July 2020 (2.83) version

## 1.0.0-alpha.3 - 2020-06-19

* Upgraded AMO library to 19.4.0.2, supporting latest TMSL features
* "export-bim" action
  * New argument added: `-transforms RemovePBIDataSourceVersion`
* TabularModel Serializer
  * Ignore timestamp properties in TMSL (for *.pbit files)
  * Sanitize table, hierarchy, and data source names

## 1.0.0-alpha.2 - 2020-06-10

* Improvements to "export-bim" action
  * Replaced `-generateDataSources` with `-skipDataSources` (reversed default)

## 1.0.0-alpha.1 - 2020-06-09

* Changed target framework to .Net 4.7.2 (allows compatibility with external libraries that only support .Net Standard 2.0, rather than legacy .Net Framework versions)
* Upgraded AMO library to 19.2.0.2, supporting latest TMSL features
* Upgraded various other 3rd party dependencies
* Support for new PBIX metadata format ("V3"), introduced in March 2020 version of Power BI Desktop
  * `PbixModel` API now available
* PBIXPROJ format 0.5
* New CLI action: "export-bim"
* "info" action: Added 'version', 'pbiSessions'
* Compatible with Power BI Desktop May 2020 version
* Significantly reduced exe file size by excluding 3rd party satellite assemblies
* Support for `PBITOOLS_PbiInstallDir`, `PBITOOLS_LogLevel` environment variables
* Application icon added
* V3 files are supported with LinguisticSchema in either xml (legacy) or json format

## 0.10.0 - 2019-11-14

* Upgraded AMO library to 18.2
* Addresses breaking API change in Nov 2019 release (2.75) of Power BI Desktop. Modification is backwards-compatible, however, so will still work with the Oct release.
  * Details: `ReportMetadata` now has a dependency on <IFeatureSwitchManager> (also added DirectQueryResources, QueryDependencyGraph - for v3 report model)
* Fixed duplicated "DiagramViewState extracted" message

## 0.9.0 - 2019-10-20

* Upgraded AMO library to 18.0 so that latest tabular features are recognized by serializer (Specifically, measure/dataCategory)
* Addresses breaking API change in Oct 2019 release (2.74) of Power BI Desktop
  * Pre 2.74, IBinarySerializable was defined in Microsoft.Mashup.Client.Packaging.dll (implemented by ReportSettings, ReportMetadata, QueryGroupMetadata)
  * Since 2.74, that interface has been moved to Microsoft.PowerBI.Packaging.dll
* `[info]` action: Added 'amoVersion' property, returning the product version of the AMO library in use

## 0.8.1 - 2019-06-24

* PBIXPROJ format 0.4.1
  * FIX: Url-encode measure names when serializing to file system to allow for illegal path characters

## 0.8.0 - 2019-05-24

* PBIXPROJ format 0.4
  * Excluding Report/section/id (field is volatile and 'name' is already a unique identifier for sections)

## 0.7.0 - 2019-05-23

* Addresses breaking API change in May 2019 release of Power BI Desktop (i.e., this version is incompatible with earlier versions)

## 0.6.0 - 2019-03-15

* PBIXPROJ format 0.3.1
  * Tabular model measure 'extendedProperties' are now supported (extraction previously failed)
* Major rewrite of internal serialization infrastructure

## 0.5.0 - 2018-11-02

* Rebranding to "PBI Tools" (pbi-tools.exe) to leave scope for more general Power BI tooling that's not directly tied to PBIX files only

## 0.4.0 - 2018-10-30

* PBIXPROJ format 0.3
  * Mashup metadata now being extracted into folder structure rather than a single xml file
  * Mashup (package) formulas extracted into folder structure instead of single "Section1.m"
* Report extraction improvements: git diffs are now a lot less noisy as json documents are transformed to come out in a predictable format
  * Json properties are always sorted alphabetically
  * Numbers are converted from float to int where possible
  * 'queryHash' and 'objectId' properties removed
* CLI usage improved

## 0.3.0 - 2018-05-22

* PBIXPROJ format 0.2: 'dataSources' renamed to 'queries' to be consistent with internal PowerBI APIs
* Bundling all dependencies into 'pbix-tools.exe' so that there is only one executable to distribute (using Costura.Fody)
* Change: Mashup extraction format changed (full mashup package in /Mashup/Package)
* Feature: Added extraction support for: Version, Connections, ReportMetadata, ReportSettings, LinguisticSchema, MashupPackageMetadata, MashupPackageContent
* Fix: Full cleanup of deleted files (between extractions)
* Breaking Change: target framework is now .Net 4.5.2 (required by Costura.Fody)

## 0.2.0-beta.1 - 2018-04-17

* Handle PBIX w/o embedded model (live connection or PBIT)

## 0.1.0-beta.3 - 2018-03-13

* `[info]` action returns 'effectivePowerBiFolder'

## 0.1.0-beta.2 - 2018-03-12

* PBIXPROJ v0.1: Model/dataSources: use location (query name) as folder name (rather than datasource guid); always write 'dataSource.json'

## 0.1.0-beta.1 - 2018-03-11

* Dynamic discovery of Power BI installations, including Windows Store installs (64-bit only)
* Shadow-copying of msmdsrv files when using AppModel binaries
* FAKE build script (Clean, Build implemented)
* Added 'info' cli action, listing all available PBI Desktop installs (to be extended with further items)
* Logging improved

## 0.0.0-alpha.1 - 2018-02-26

* First preview: Implements 'extract' action (Model, Mashup, Report) 
* Limitations: 64-Bit only, requires PBI Desktop install in default location, won't extract PBIT DataModelSchema
* Targeting net45
* Initial '.pbixproj.json' implementation (version: 0.0)
* CLI using PowerArgs

---
title: Feature Matrix
summary: "Starting with the 1.0.0-beta.7 release, `pbi-tools` is available in two editions: Desktop and Core. This page explains the differences and provides guidance choosing the right edition for your scenario."
toc: false
permalink: /cli/feature-matrix.html
---

## How to chose? - `pbi-tools` Desktop vs Core

- Use **Desktop** edition on a Windows workstation in conjunction with Power BI Desktop.
- Use **Core** edition in any unattended scenario, specifically a CI/CD server.
- Use **Core** edition on a Windows workstation in order to test run deployment manifests. _(Desktop and Core editions can run in parallel and can be installed into the same folder.)_

## Feature Comparison

| | Desktop | Core |
| --- | --- | --- |
| OS | **Windows 64-Bit only** | **Linux, Windows**, MacOS **64-Bit** _(MacOS version would need to be built from source, Linux and Windows builds are provided on <https://github.com/pbi-tools/pbi-tools/releases>)_ |
| Prerequisites | **.Net Framework 4.7.2**, Power BI Desktop _(Store, MSI, or Custom install folder via `PBITOOLS_PbiInstallDir`)_ | **.Net 6.0** |
| `extract` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#extract) | Not supported. **Planned for report-only PBIX.** |
| `compile` | PBIX from report-only sources, PBIT from Report+Model. _Relies on Power BI Desktop_ [<i class="fa fa-book"></i>](/cli/usage.html#compile) | PBIX from report-only sources, PBIT from Report+Model. _No dependency on Power BI Desktop_ [<i class="fa fa-book"></i>](/cli/usage-core.html#compile) |
| `deploy` | Fully supported. _The Report/File mode implicitly relies on the `compile` action, hence the notes above apply._ [<i class="fa fa-book"></i>](/cli/usage.html#deploy) | Fully supported. [<i class="fa fa-book"></i>](/cli/usage-core.html#deploy) |
| `generate-bim` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#generate-bim) | `-generateDataSources` option is not supported. [<i class="fa fa-book"></i>](/cli/usage-core.html#generate-bim) |
| `export-data` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#export-data) | Only supports exporting from a live PBI Desktop session via `-port` arg. [<i class="fa fa-book"></i>](/cli/usage-core.html#export-data) |
| `convert` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#convert) | Fully supported. [<i class="fa fa-book"></i>](/cli/usage-core.html#convert) |
| `init` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#init) | Fully supported. [<i class="fa fa-book"></i>](/cli/usage-core.html#init) |
| `git` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#git) | Fully supported. [<i class="fa fa-book"></i>](/cli/usage-core.html#git) |
| `info` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#info) | Does not return `pbiBuildVersion`, `pbiInstalls`, `pbiSessions`. [<i class="fa fa-book"></i>](/cli/usage-core.html#info) |
| `launch-pbi` | Not supported for Microsoft Store version. [<i class="fa fa-book"></i>](/cli/usage.html#launch-pbi) | N/A |
| `cache` | Fully supported. [<i class="fa fa-book"></i>](/cli/usage.html#cache) | N/A |

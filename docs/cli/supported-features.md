---
title: Supported and Experimental Features
summary: "Users of pbi-tools are advised that only some tool features are currently Microsoft-supported, whilst others have to be considered experimental. Experimental features are those which rely on undocumented behaviors in Power BI or which expose file internals where a public specification does not exist for the respective file formats."
toc: false
permalink: /cli/supported-features.html
---

Whilst a full end-to-end development process with `pbi-tools` depends on such _experimental_ features, Microsoft Support cannot be engaged in relation to any issues linked to such projects. **Use _experimental_ features at your own risk.**

It is, however, expected that over time the surface area of undocumented features will get smaller and smaller as the Power BI product team is actively working on enabling tools like `pbi-tools` to perform file manipulation actions.

## Feature Summary

| Feature | Desktop Edition | Core Edition |
| --- | --- | --- |
| `extract` - From PBIX (thin report) | Supported | N/A |
| `extract` - From PBIX (thick report) | Experimental | N/A |
| `compile` | Experimental | Experimental |
| `deploy` - From PBIX (thick and thin report) | Supported | Supported |
| `deploy` - Dataset from BIM | Supported | Supported |
| `deploy` - Dataset from TMDL | Supported | Supported |
| `deploy` - Thin report from PbixProj folder | Experimental | Experimental |
| `export-data` - From port | Supported | Supported |
| `export-data` - From PBIX | Experimental | Experimental |

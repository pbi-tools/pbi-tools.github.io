---
title: Support for TMDL
summary: "pbi-tools supports TMDL, the new Tabular Model Definition Language (released in 2023), a strategic investment into code-first, collaborative, model development for Power BI, fully aligned with the pbi-tools vision."
permalink: /tmdl/
---

## Introduction to TMDL (Tabular Model Definition Language)

TMDL is a new declarative language for tabular models, released by Microsoft in April 2023. It is the successor to [TMSL (Tabular Model Scripting Language)](https://pbi.onl/tmsl-docs) and was designed from the ground up to address developer needs.

The TMDL format is:

- Human-Readable
- Editable in any text editor
- Suitable for collaborative development

Learn more about TMDL at [Microsoft's official documentation](https://pbi.onl/tmdl-docs).

Since TMDL is available as part of the public [TOM Nuget packages](https://fabric.onl/tom-nuget), external tools like [Tabular Editor](https://tabulareditor.com/) and `pbi-tools` can fully support the new format.

## Using TMDL with pbi-tools

Starting with the [1.0.0-rc.3 Release](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.3), `pbi-tools` has had support for TMDL.

Specifially, the [extract](https://pbi.tools/cli/usage.html#extract), [convert](https://pbi.tools/cli/usage.html#convert), [compile](https://pbi.tools/cli/usage.html#compile), and [deploy](https://pbi.tools/cli/usage.html#deploy) actions are TMDL-aware.

Both, [extract](https://pbi.tools/cli/usage.html#extract) and [convert](https://pbi.tools/cli/usage.html#convert), support the `-modelSerialization` command-line argument to determine the serialization format for the model part of a project. (See the table below for a description of all possible options.)

Each extract/serialization process will determine the effective model format in the following order (the first applicable option is applied):

1. CLI `-modelSerialization` argument
2. The `settings.model.serializationMode` property in `.pbixproj.json`.
3. The `PBITOOLS_DefaultModelSerialization` environment variable.
4. The `ModelSerialization.Default` settings, which (currently) maps to `Tmdl`.

Any operations consuming project files, [compile](https://pbi.tools/cli/usage.html#compile), and [deploy](https://pbi.tools/cli/usage.html#deploy) specifically, are able to read model sources in any supported format (TMDL, PbixProj = Legacy, `model.bim`), without any further hints required.

{% include note.html content="Tabular Editor's proprietary &quot;Save to Folder&quot; format is _not_ supported. For interoperability with Tabular Editor use either `model.bim` or the TMDL format." %}

TMDL is still in public preview. So far, ten preview releases were published. Follow [this GitHub repository](https://tmdl.pbi.tools/history) to keep track of the latest release and any noteable changes. Whilst some breaking changes occurred between earlier previews, the TMDL format can now be considered fairly stable. For maximum interoperability between Power BI and external tools it is strongly recommeneded to always upgrade to the latest tool updates. The repository mentioned above references matching external tool versions.

The `pbi-tools` [sample repository](https://github.com/pbi-tools/adventureworksdw2020-pbix) has been upgraded to the TMDL format (see the [pbix/Model](https://github.com/pbi-tools/adventureworksdw2020-pbix/tree/main/pbix/Model) folder).

### ModelSerialization Options

| Settings | Description |
| --- | --- |
| `Default` | The default serialization format, effective if no option is specified. The default is (currently) TMDL. Note that the meaning of "Default" could potentially (although unlikely) change in the future. Explicitly specifiy "Tmdl" if you always want TMDL output. |
| `Raw` | Serializes the tabular model into a single JSON file ("model.bim") containing the full TMSL payload from the PBIX model. No transformations are applied. |
| `Legacy` | Serializes the tabular model into the default PbixProj folder structure and performs various transformations to optimize file contents for source control. |
| `Tmdl` | Serializes the tabular model into TMDL format. Annotation settings (`settings.model.annotations`) are applied and the `settings.model.format` options are honored (see [1.0.0-rc.8 Release](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.8)). |

### Extract PBIX file with model.bim output (instead of default TMDL)

    pbi-tools {filepath.pbix} -modelSerialization Raw

### Convert a model file or folder (model.bim, PbixProj) to TMDL format

    pbi-tools convert ./Model -overwrite

### Convert a model folder (TMDL, PbixProj) to BIM file

    pbi-tools convert ./Model ./model.bim -overwrite

## Resources

- [Power BI Blog: Announcing the Public Preview of TMDL](https://tmdl.pbi.tools/preview-announcement)
- [GitHub: TMDL History by Example](https://tmdl.pbi.tools/history)
- [TMDL Extension for Visual Studio Code](https://pbi.onl/vscode-tmdl)
- [Microsoft: Official TMDL Docs](https://pbi.onl/tmdl-docs)
- [YouTube: Recording of first demo of TMDL at SqlBits 2023](https://videos.pbi.tools/2023-03-17-sqlbits-tmdl)
- [Analysis Services NuGet Packages](https://fabric.onl/tom-nuget)

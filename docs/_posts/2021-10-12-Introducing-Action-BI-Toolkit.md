---
title:  "Introducing the Action BI Toolkit"
published: true
author: Brian Mather
summary: "The Action BI Toolkit is a powerful collection of tools to deliver source control and productivity for developing Power BI projects in Power BI Desktop."
---

## Where can I get it?

Head over to our GitHub repo to get the installer for the "pbi-tools" command-line utility and the external tool integration for Power BI Desktop:
<https://github.com/action-bi-toolkit/toolkit/releases/latest>

## What does it do?

First and foremost, it allows the entire definition of your Power BI report and each of its report pages to be effortlessly checked into source control - as you work!!

All of the report artefacts are extracted into a structured set of files and folders including:

* Report pages with all their visuals
* Report, page and visual level filters
* Report configuration
* Static resources such as images
* Custom visuals

Although we admit it's pretty noisy, for the first time this allows you to see and start to understand changes between successive versions of a .pbix file.

Secondly, and most importantly for enterprise-level, multi-report developer scenarios, it allows each 'thin' report file to be checked out of source control and it will compile all of the various components back into a working .pbit or .pbix file. This can avoid the need to check these large binaries into source control.

Thirdly, having also extracted your model into a set of structured folders, you can track changes across all of your power query (m) expressions, DAX expressions and other model metadata.
  
## What is in the Action BI Toolkit?

### pbi-tools - Command Line Utility

The source control extraction and recompile capabilities behind the toolkit are powered by a mighty command-line utility called "pbi-tools" which is the brainchild of Mathias Thierbach [@mthierba](https://twitter.com/mthierba), a tabular modelling wizard and C# aficionado.

The vision for pbi-tools is to inspire and support the community to create automated pipelines for the deployment of Power BI datasets and reports that have been built using Power BI Desktop.

Find the pbi-tool tool source code, documentation and releases on GitHub: <https://github.com/action-bi-toolkit/pbi-tools>  

### external tool - PowerShell Script

A Power BI expert, hacker, and PowerShell enthusiast, Brian Mather [@bvmather](https://twitter.com/bvmather) is obsessed with bringing the Power BI masses on a journey towards well managed, maintainable Power BI solutions. He wants to make developer-level practices accessible to Power BI Pro users, including concepts such as source control, testing and even deploying reports programmatically between dev, test and production environments.

The Power BI Desktop external tool allows you to push your changes into your source control alongside your daily workflow inside Power BI Desktop.

Whilst the command line pbi-tools (above) have been developed and used in production for several years, the external tool integration is a prototype rather than a finished product. It is designed to showcase what the command line tools can do and to make it accessible to users who are new to the command line and source control concepts.

An adventurous PowerShell user should be able (and feel welcome) to copy the Action-BI-Toolkit.ps1 script and modify it to create their own work flow.

Both the external tool and the command-line utility can be installed via the installer: <https://github.com/action-bi-toolkit/toolkit/releases/latest>

## What is the why?

Paul Turley has an awesome blog [Planning for Separation - data models and reports](https://sqlserverbi.blog/2020/11/17/doing-power-bi-the-right-way-8-planning-for-separation-data-models-reports/) and a related blog series [Doing Power BI the Right Way](https://sqlserverbi.blog/2020/07/12/doing-power-bi-the-right-way/) that explains the very good reasons and very real challenges behind separating a great Power BI .pbix report into thick and thin reports.

{% include callout.html content="**Thick Report**: A .pbix file that contains the data model including the data load and transform power query (m) steps, tables, measures and relationships etc." type="primary" %}

{% include callout.html content="**Thin Reports**: A series of separate .pbix files that have no dataset of their own, only live connections to either a local dataset (e.g. a running Power BI Desktop instance) or a remote dataset (e.g. a dataset in a Workspace in the Power BI service)." type="primary" %}

Some of the challenges include how to tracking changes and dependencies between the thin reports and the dataset, especially as the dataset continues to evolve as fields are added, modified or removed.

We’ll be producing a series of upcoming blog posts that explore how pbi-tools and the external tool integration can help to address dependency tracking and testing of reports. We are looking for people to try the tooling, provide feedback and join in as we explore ways to overcome these challenges.

## What will you need to get started?

Head over to the Action BI Toolkit GitHub repo to see the source code or download the installer. Raise any issues or ideas and please provide feedback. If you are completely new to source control, look out for our coming step-by-step blog post on how to get started with Source Code for Power BI Desktop which will include how to get started with Git for Windows and VS Code.

We really hope that these tools help and would love to hear your feedback!

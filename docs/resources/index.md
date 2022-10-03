---
title: pbi-tools Resources
summary: "Curated list of publicly available materials about pbi-tools, including User Group and Conference presentations"
permalink: /resources/
hide_sidebar: true
---

## Upcoming Events

### PASS Data Community Summit, Seattle (November 2022)

**[Power BI Model Development Best Practices in a Team](https://passdatacommunitysummit.com/sessions/all-sessions/1726/)**

Power BI projects often start very small, with a single person quickly creating impressive results using Power BI Desktop and a project that is fully contained in a single file. When those early successes are then expected to scale in an enterprise context and to be replicated by a larger team, things get more complicated. There is no obvious scale-out path, particularly with regard to model development.
Mathias, who has been on this exact journey over the past five years, presents the practices he has developed during that time, going from a single contributor beginning to a highly effective team setup. The session covers processes, tools, roles and automation, with a focus on very practical take-aways.

## Conference Sessions Delivered

- [Public Sessionize Profile](https://goto.pbi.tools/sessionize-profile)

### Data Platform Virtual Summit (September 2022)

**[The internals of a PBIX file and how pbi-tools helps make sense of it all](https://sessions.mthierba.net/pbix-internals-and-pbi-tools)**

The PBIX file is the fundamental building block when it comes to Power BI development. You may have heard that PBIX files are simply ZIP files with an internal file structure, however, very little is publicly known beyond that.

Mathias, for his work on pbi-tools, has spent years deciphering the (undocumented) PBIX internals. Those efforts have led to pbi-tools, today the only end-to-end source control solution for Power BI development.

This session will explain what's inside a PBIX file and how everything is linked together. Using the folder structure view of a PBIX file provided by pbi-tools, all of the components (Model, Report, Queries, Resources, Settings) will be looked at in detail. You will understand how to track changes made to a PBIX file using Power BI Desktop, what those changes mean, and how to apply similar changes offline, targeting the pbi-tools folder structure only.

Using that understanding, the session will further look into more advanced automation scenarios which become viable once the PBIX internals are known and provide various examples. This session is likely to inspire you to take your Power BI projects to new levels of automation!

- [Download Slides](https://slides.pbi.tools/2022-09-23-pbix-internals)

### Power BI Next Step, Billund/DK (September 2022)

**[Incremental Refresh and Partition Management](https://sessions.mthierba.net/incr-refresh-mcarlo)**

*Co-presented with [Mike Carlo](https://www.linkedin.com/in/michaelcarlo/)*

You have lots of data, well Power BI can handle it. Build efficient loading data models by using Incremental Refresh in Power BI.

While setting up incremental refresh is easy, what is happening in Power BI.com is more of a mystery. This session does a deep dive into what happens when you are incrementally refreshing datasets.

This will be a technical dive in to Power BI Incremental refresh using SSMS, SQL Profiler, and Tabular Editor 3

Attendees will walk away with a complete understanding of the Incremental refresh set up within Power BI. Then a technical understanding of what happens at the Analysis services side inside PowerBI.com.

Extra topics also covered:

- Hybrid refresh policies
- Advanced features enabled via the Tabular Object Model
- Impact for deployment of datasets (DevOps concerns)

### Data Insight Summit, Chicago (September 2022)

**[Lessons learned building a Power BI Team](https://sessions.mthierba.net/transition-to-mgmnt)**

You have spent most of your career with a focus on technology and you're feeling at home in that domain. Now you have been asked to build a team underneath you to take your previous accomplishments to the next level. Or you are considering a career move and step into management. If that is you and you are a technologist who is now a new or aspiring manager, this session will give you plenty of practical advise what to expect and prepare for.

From his own experience of having gone down this path over more than five years, Mathias will present his learnings and insights. It turns out the field of managing people and ensuring a team can function well as a coherent unit is rather different from the field of technology and computers! This session will help you not to feel lost and overwhelmed and instead take on this new challenge with great confidence and joy. The main focus is on "soft skills", however, embedded in a professional Power BI context.

Most importantly, you will be able to learn from someone else's mistakes instead of repeating them all yourself! Or, you might instead decide that a move into management is not for you after all and you should rather stay in a single contributor role. Either way, you will walk away with lots of trips & tricks. You will learn techniques for having greater awareness of yourself and others. You will get a useful reading list. And you will get plenty of food for thought and reflection. Ideally, this will make some contribution to making you a better leader and manager!

- [Download Slides](https://slides.pbi.tools/2022-09-14-Team-Mgmnt)

**[What is GIT and how do I get started? An introduction for Power BI developers](https://sessions.mthierba.net/git-introduction)**

The session will explain GIT concepts to people who are new to source control or who want to refresh their knowledge. Power BI developers without an engineering background have traditionally felt a little lost in the world of GitHub and Azure Repos. However, tools like Tabular Editor and pbi-tools have brought source control capabilities into the Power BI ecosystem. There are even hints that Microsoft might be taking source control for Power BI more seriously now! Time for everyone to learn the basics, understand the key concepts and know which tools to use and where to find help!
If you want to understand what source control is and what terms like git, commit, branch, and pull request mean, this is the session for you. In addition to explaining the basics the session will also demonstrate some end-to-end development workflows using git for Power BI projects.

- [Session Materials](https://links.mthierba.net/git-intro)
- [Download Slides](https://slides.pbi.tools/2022-09-14-git-Intro)

## User Group/Meetup Presentations

### 20-Jul-2022 Seattle MEUG (Dataset Lifecycle Management)

**[Power BI Dataset Lifecycle Management with pbi-tools](https://www.meetup.com/seattle-modern-excel-users-group-meug/events/282861778/)**

[pbi-tools](https:/pbi.tools/), the open-source CI/CD and source control tool for Power BI, has had many new features added over the last few months that support enterprise-grade lifecycle management of Power BI (Premium) datasets.
The session introduces and demonstrates the latest set of capabilities and puts those in context.

The session covers:

- PBIX source control with `pbi-tools`
- Automated deployments of Power BI datasets through CI/CD pipelines
- A git branching model for team collaboration with the corresponding CI/CD triggers
- Flexible and selective dataset refreshes as part of `pbi-tools` deployments
- Configuring different deployment environments
- Deploying SQL Database artifcats alongside Power BI datasets

| Event | <https://www.meetup.com/seattle-modern-excel-users-group-meug/events/282861778/> |
| Abstract | <https://gist.github.com/mthierba/e9ef6d41f8cc79d50be26adb78df4ae9> |
| Slides | <https://slides.pbi.tools/2022-07-20-Seattle-MEUG> |

### 7-Jul-2022 PBI User Group Switzerland (pbi-tools Intro)

**[Introducing pbi-tools](https://www.meetup.com/power-bi-user-group-switzerland/events/287011457/)**

pbi-tools is a free and open-source external tool for Power BI, focusing on source control and DevOps capabilities. Learn all about the tool, what it does, and how to get started in this session.

The session covers:

- PBIX source control with pbi-tools
- pbi-tools for change tracking in reports and datasets
- Deployments and DevOps pipelines with pbi-tools
- All demos and files used during the session are available in a public GitHub repository.

| Announcement | [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:6950400951719505920?updateEntityUrn=urn%3Ali%3Afs_feedUpdate%3A%28V2%2Curn%3Ali%3Aactivity%3A6950400951719505920%29) |
| Event | <https://www.meetup.com/power-bi-user-group-switzerland/events/287011457/> |
| Abstract | <https://gist.github.com/mthierba/ae26b977ceaffe443ec15fcdc39f8e72> |
| Slides | <https://slides.pbi.tools/2022-07-07-pbitools-intro> |

### 21-Jun-2022 Denmark PBI User Group (Branching Model)

**[Advanced git Branching Model for Power BI](https://www.meetup.com/denmark-powerbi-user-group/events/286424609/)**

This session introduces in theory and practice a git branching model supporting collaborative incremental releases for Power BI datasets and reports.

The model is collaborative: it is designed for multiple team members working jointly on a shared set of changes.

It is designed for incremental releases: Those continuously deliver business value with a regular and reliable release cadence and allow the product manager, the develop team as well as stakeholders to refer to a particular feature set using a shared versioning scheme.

Using both the source control as well as deployment capabilities of [pbi-tools](https://pbi.tools), this model was developed by Mathias as part of building and growing a distributed data management team and was continuously improved over multiple iterations.

Join the session to learn how it works, the thinking behind, and how to adopt it for your own workflows. Foundational understanding of source control and CI/CD is recommended.

| Event | <https://www.meetup.com/denmark-powerbi-user-group/events/286424609/> |
| Abstract | <https://sessionize.com/s/mathias-thierbach/advanced-git-branching-model-for-power-bi/51805> |
| Recording | <https://videos.pbi.tools/2022-06-21-Denmark-UG> |
| Slides | <https://slides.pbi.tools/2022-06-21-Denmark-UG> |
| Materials | <https://pbi.tools/devops/release-branching-model/> |

### 7-Jun-2022 Sri Lankan Power BI Community (Datasets CI/CD)

**[Power BI Dataset CI/CD with pbi-tools](https://gist.github.com/mthierba/fe82d923704428391fa839e34a15fcc6)**

[`pbi-tools`](https:/pbi.tools/), the open-source CI/CD and source control tool for Power BI, introduces deployment and refresh capabilities for Power BI (Premium) datasets. The session introduces and demonstrates the new capabilities and explains what you need to set up your own deployment pipelines.

The session covers:

- PBIX source control with `pbi-tools`
- The `pbi-tools` deployment manifest
- Creating a GitHub Actions workflow using the `pbi-tools` Docker image
- A git branching model for team collaboration with the corresponding CI/CD triggers

All demos and files used during the session are available in a public GitHub repository.

| Abstract | <https://gist.github.com/mthierba/fe82d923704428391fa839e34a15fcc6> |
| Recording | <https://videos.pbi.tools/2022-06-07-Sri-Lanka-UG> |
| Slides | <https://slides.pbi.tools/2022-06-07-SriLa-Datasets-CICD> |

### 26-May-2022 PBIMCR (Pro Model Dev) {#PBIMCR-Model-Dev--2022-05-26}

**[Model Development with pbi-tools](https://www.meetup.com/PBIMCR/events/vsvtrsydchbjc/)**

The session introduces and demonstrates Power BI model development workflows and practices in conjunction with pbi-tools and other external tools, like Tabular Editor. pbi-tools (https://pbi.tools/), a free and open-source external tool for Power BI, was developed over the last six years specifically to facilitate mature development practices for Power BI projects. Learn what that means specifically for Power BI models.

Some previously unreleased pbi-tools features are likely to be shown as well.

The session covers:

- PBIX source control with pbi-tools
- GIT branching models for team collaboration
- Automated deployment pipelines with different environments
- Release-focussed approach for development, testing, deployment

| Event | <https://www.meetup.com/PBIMCR/events/vsvtrsydchbjc/> |
| Abstract | <https://gist.github.com/mthierba/a9781d4732bf117404fc92ce1641a259> |
| Recording | <https://videos.pbi.tools/2022-05-26-PBIMCR-Model-Dev> |
| Slides | <https://slides.pbi.tools/2022-05-26-PBIMCR-Model-Dev> |
| GitHub | <https://github.com/pbi-tools/dataset-devops-demo> |

### 10-May-2022 St Louis UG (REST API) {#St-Louis-UG-REST-API--2022-05-10}

**[Deep Dive into the Power BI REST API](https://www.meetup.com/st-louis-sql-server-bi-user-group/events/285699942)**

The Power BI REST API is the back-end interface for applications and scripts automating Power BI tasks or administrating Power BI Embedded. Particularly in an enterprise context, where automation matters a lot, that API is vital for managing a Power BI infrastructure.

Join this session to learn all the basics about the API, which key use cases there are, what is needed to get started, and which tools are the most helpful.
Whether you are a developer, a tenant administrator, or merely interested in all things Power BI, you will likely learn something new and will be able to get some inspiration around automation capabilities.

The session covers:

- Introducing the REST API (What is it and what can it do?)
- Selected use cases
- Authentication (Interactive and Service Principal)
- Tools (vscode, Postman, PowerShell)

| Event | <https://www.meetup.com/st-louis-sql-server-bi-user-group/events/285699942> |
| Abstract | <https://gist.github.com/mthierba/6d24f887bfafb14963ff3f7f75da3454> |
| Recording | <https://videos.pbi.tools/2022-05-10-StLouisUG-REST-API> |
| Slides | <https://slides.pbi.tools/2022-05-10-StLouisUG-REST-API> |
| GitHub | <https://github.com/mthierba/pbi-rest-api-vscode-samples> |

### 01-May-2022 Delhi (Pro Report Dev)

**[Developing Power BI Reports with pbi-tools](https://www.linkedin.com/posts/delhi-power-bi-user-group_delhi-power-bi-user-group-power-bi-ph-community-activity-6924637162344783872-DXA2?utm_source=share&utm_medium=member_desktop)**

| Announcement | [LinkedIn](https://www.linkedin.com/posts/delhi-power-bi-user-group_delhi-power-bi-user-group-power-bi-ph-community-activity-6924637162344783872-DXA2?utm_source=share&utm_medium=member_desktop) |
| Recording | <https://videos.pbi.tools/2022-05-01-Delhi-Reports-Dev> |
| Slides | <https://goto.pbi.tools/pptx-2022-05-01-delhi-ug> |
| GitHub | <https://goto.pbi.tools/files-2022-05-01-delhi-ug> |

### 13-Apr-2022 Stuttgart (Git Intro)

**[What is GIT and How do I get started?](https://www.meetup.com/StuttgartPowerPlatformUG/events/284948040/)**

The session will explain GIT concepts to people who are new to source control or who want to refresh their knowledge. Power BI developers without an engineering background have traditionally felt a little lost in the world of GitHub and Azure Repos. However, tools like Tabular Editor and pbi-tools have brought source control capabilities into the Power BI ecosystem. There are even hints that Microsoft might be taking source control for Power BI more seriously now! Time for everyone to learn the basics, understand the key concepts and know which tools to use and where to find help!

| Event | <https://www.meetup.com/StuttgartPowerPlatformUG/events/284948040/> |
| Recording | <https://videos.pbi.tools/2022-04-13-PPUG-Stuttgart> |
| GitHub | <https://github.com/mthierba/git-introduction> |

### 24-Mar-2022 Berlin User Group

**[pbi-tools and Power BI DevOps Pipelines](https://www.meetup.com/berlin-power-bi-user-group/events/284529940/)**

Mathias Thierbach introduces pbi-tools, an open-source project maintained by him and the ONLY end-to-end source control solution available for Power BI.
Mathias will explain the basics of pbi-tools and demo how the tools is used for automated deployments via GitHub Actions and Azure DevOps.

| Event | <https://www.meetup.com/berlin-power-bi-user-group/events/284529940/> |
| Recording | <https://videos.pbi.tools/2022-03-24-Berlin-Reports-CICD> |
| Slides | <https://goto.pbi.tools/pptx-2022-03-24-berlin-ug> |
| GitHub | <https://github.com/pbi-tools/demo-berlin-pug-lfs> <br /> <https://github.com/pbi-tools/demo-berlin-pug-pbixproj> |

### 18-Mar-2022 Des Moines User Group

**[pbi-tools: Source Control & DevOps for Power BI](https://www.meetup.com/iowapowerbi/events/283680703/)**

Ever since Microsoft launched Power BI back in 2015, report developers and data modelers have been begging for compatibility between Power BI Desktop and enterprise-grade version control solutions like Azure DevOps and GitHub. Now, just a little over 6 years later, a true solution to this problem is finally available, and the best part is... It's FREE!

[pbi-tools](https://pbi.tools/) by Mathias Thierbach is a powerful new application designed to make it possible to develop, publish, and maintain Power BI projects in a CI/CD pipeline that can automatically analyze new commits for bugs and anti-patterns, detect conflicts between branches, and deploy approved releases to production. PBI Tools is truly a game-changer for Power BI professionals, and we're very excited to show you how it works, so you can start using it to level-up Power BI development at your own organization.

| Event | <https://www.meetup.com/iowapowerbi/events/283680703/> |
| Recording | <https://videos.pbi.tools/2022-03-18-Des-Moines-UG> |
| Slides | <https://goto.pbi.tools/pptx-2022-03-18-des-moines-ug> |

### 28-Jan-2022 Deploying Reports with pbi-tools (Live Stream with Reid Havens) {#ReidHavens--2022-01-28}

| Announcement | [Twitter](https://twitter.com/HavensBI/status/1485398037585301504?s=20&t=ozXByuWFKtCd6aJkbzUyvA) [LinkedIn](https://www.linkedin.com/posts/reidhavens_deploying-reports-with-pbi-tools-with-mathias-activity-6891163962566692864-75iE?utm_source=share&utm_medium=member_desktop) |
| Recording | <https://videos.pbi.tools/2022-01-28-ReidHavens-Live> |
| Slides | <https://goto.pbi.tools/pptx-2022-01-28-reid-havens> |

### 26-Jan-2022 PUG London

**[DevOps for Power BI Reports](https://www.meetup.com/london-pug/events/283419731/)**

Are you tired of committing .pbix binary files into your source control system? Does this cause you compliance issues, repo bloat and change tracking nightmares? Why can't industry-standard DevOps practices be used to manage change control and automated report deployment in Power BI?

The talk briefly looks into the current state of DevOps solutions for Power BI. It will then showcase three different ways of using [pbi-tools](https://pbi.tools/) to implement automated deployment solutions:

- From .pbix files in your source control system (and how repo bloat can be avoided in that case)
- From .pbix files, however, additionally using the pbi-tools source control features for change tracking
- Fully relying on the pbi-tools source control format for deployments

The demos will use Azure DevOps. The techniques and tools used, however, can be adapted to any modern CI/CD system. The focus is on "thin" reports - PBIX projects with a live connection to a remote dataset. All sample projects are provided for free on GitHub.

| Event | <https://www.meetup.com/london-pug/events/283419731/> |
| Recording | <https://videos.pbi.tools/2022-01-26-London-PUG> |
| Slides | <https://goto.pbi.tools/pptx-2022-01-26-london-ug> |

## Video Tutorials

- [YouTube Playlist](https://goto.pbi.tools/youtube)

### Removing the Filter Pane Visibility Toggle for Bookmarks (28 Jun 2022, Havens Consulting)

Taking advantage of the enhanced support for Power BI bookmarks introduced in pbi-tools 1.0.0-rc.2, the session demonstrates how to use pbi-tools to fix a major UX problem bookmarks have today: With the Data option enabled, the expand/collapse state of the report Filters pane is always persisted with the bookmark. Using pbi-tools, and direct access to the report sources, this issue can be resolved.

[RECORDING](https://videos.pbi.tools/reidhavens-bookmarks)

### Calling the Power BI REST API with VS Code (3 May 2022, Havens Consulting)

This talk introduces Visual Studio Code as a simple and convenient tool to access the Power BI REST APIs. Using the free ["REST Client" extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client), all aspects of the API can be used from within Visual Studio Code: Invocations can be saved for reuse, variables are supported, and API responses are available in full.

You will also learn about the different authentication types (service principal, interactive, admin), how those differ, and how they're configured.

All examples used in the recording and further notes are available here: <https://github.com/mthierba/pbi-rest-api-vscode-samples>

Note that this approach is also substantially faster then the "Try It" button integrated into Microsoft's official API docs here: <https://learn.microsoft.com/rest/api/power-bi/>

[RECORDING](https://videos.pbi.tools/reidhavens-vscode-rest-api)

### CI/CD Deployment Pipelines for Power BI Reports with `pbi-tools` (5 Apr 2022, Havens Consulting)

This tutorial describes the setup of a simple automated deployment pipeline for Power BI reports using [pbi-tools](https://pbi.tools/). It assumes that reports have a live connection to a Power BI dataset and that the PBIX files containing the reports are held in a git repository in either Azure DevOps or GitHub.

- [Part 1: Setup](https://videos.pbi.tools/rhavens-pbitools-tutorial-1)

The first part of the tutorial explains the setup necessary in the Power BI tenant. Since a service principal is going to be used for the deployment, the necessary steps to get this set up are covered.

Furthermore, the configuration of the pbi-tools deployment manifest is explained, and the deployment is tested locally.

- [Part 2a: GitHub Actions](https://videos.pbi.tools/rhavens-pbitools-tutorial-2a)

With the basic setup completed, and the deployed tested locally, this part of the tutorial moves the setup into a GitHub repository. A GitHub Actions workflow is created, secrets are set, and the pipeline is tested end-to-end.

The repository created in the tutorial is publicly available here: <https://github.com/pbi-tools/tutorial-devops-reports>

- [Part 2b: Azure DevOps](https://videos.pbi.tools/rhavens-pbitools-tutorial-2b)

The final part of the tutorial repeates the steps from Part 2, but this time in Azure DevOps. There are a few additonal settings required here, which the video explains.

The repository created in the tutorial is publicly available here: <https://dev.azure.com/pbi-tools/Samples/_git/tutorial-devops-reports>

## Video Series: "Tool Talk"

Recurring video live stream during which [Artur](https://www.linkedin.com/in/datakoenigartur) and Mathias discuss `pbi-tools` related topic, demo new features, and record tutorials. Find all previous recordings here: <https://videos.pbi.tools/tool-talk>.

### Tool Talk 8: 4-Oct-2022

- *Features Incremental Refresh support in the latest pre-release.*

### Tool Talk 7: 6-Sep-2022

- Tutorial: [GitHub PR Process with `pbi-tools`](https://tool-talk.pbi.tools/20220906-github-process)

### Tool Talk 6: 26-Jul-2022

- Showcases the latest `pbi-tools` pre-release: [RC.2+preview.4](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.2%2Bpreview.4)
- Demo: [SqlScripts deployments](https://tool-talk.pbi.tools/20220726-sqlscripts)

### Tool Talk 5: 5-Jul-2022

- [Full Recording](https://tool-talk.pbi.tools/20220705-live-stream)
- Showcases the latest `pbi-tools` pre-release: [RC.2+20220703](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.2%2B20220703)
- Demo: [Dataset Refresh Tracing](https://tool-talk.pbi.tools/20220705-refresh-tracing)

### Tool Talk 4: 28-Jun-2022

- [Full Recording](https://tool-talk.pbi.tools/20220628-live-stream)
- Demo: [Bookmarks Editing with `pbi-tools`](https://tool-talk.pbi.tools/20220628-bookmarks)
- Demo: [vscode Shortcuts for use with `pbi-tools`](https://tool-talk.pbi.tools/20220628-vscode-shortcuts)

### Tool Talk 3: 29-Mar-2022

- [Full Recording](https://tool-talk.pbi.tools/20220329-live-stream)
- Demo: [Splitting a thick report with `pbi-tools`](https://tool-talk.pbi.tools/20220329-split-thick-report)

### Tool Talk 2: 15-Mar-2022

- Demo: [The `pbi-tools` Docker image](https://tool-talk.pbi.tools/20220315-docker)
- Demo: [Using `pbi-tools` CONVERT and interact with Tabular Editor](https://tool-talk.pbi.tools/20220315-convert)

### Tool Talk 1: 03-Mar-2022

- Showcases the latest `pbi-tools` release: [RC.1](https://github.com/pbi-tools/pbi-tools/releases/tag/1.0.0-rc.1)
- Demo: [`pbi-tools` WATCH Mode](https://tool-talk.pbi.tools/20220303-watch-mode)

## Public Repositories

### pbi-tools Demos and Tutorials

| Repository | Features | Created | Dataset | Notes |
| --- | --- | --- | --- | --- |
| [contoso-sql-dataset-devops](https://github.com/pbi-tools/contoso-sql-dataset-devops) | Dataset Deployment, SqlScripts | 20-Jul-2022 | [Contoso](https://www.sqlbi.com/tools/contoso-data-generator/) | Azure SQL Source |
| [dataset-devops-demo](https://github.com/pbi-tools/dataset-devops-demo) | Dataset Deployment, Refresh, Deploy-Embedded-Report | 26-May-2022 | [Introducing Calculation Groups](https://www.sqlbi.com/articles/introducing-calculation-groups/) | [PBIMCR Session](https://www.meetup.com/pbimcr/events/vsvtrsydchbjc/) |
| [contoso-sales-model](https://github.com/pbi-tools/contoso-sales-model) | Dataset Compile | 24-May-2022 | [Introducing Calculation Groups](https://www.sqlbi.com/articles/introducing-calculation-groups/) | HTTP data source (GitHub) |
| [demo-pug-delhi-20220501](https://github.com/pbi-tools/demo-pug-delhi-20220501) | Report: Extract, Watch, Compile | 1-May-2022 | [Introducing Calculation Groups](https://www.sqlbi.com/articles/introducing-calculation-groups/) | Session: "Developing PBI Reports with pbi-tools" |
| [advworks-git-demo](https://github.com/pbi-tools/advworks-git-demo) | GitHub Issues, Branches | 13-Apr-2022 | [Adventure Works DW 2020](https://aka.ms/dax-docs-samples) | Session: "Introduction to GIT" |
| [report-devops-demo](https://github.com/pbi-tools/report-devops-demo) | Report Deployment (PbixProj) | 24-Mar-2022 | [Introducing Calculation Groups](https://www.sqlbi.com/articles/introducing-calculation-groups/) |
| [demo-berlin-pug-pbixproj](https://github.com/pbi-tools/demo-berlin-pug-pbixproj) | | 24-Mar-2022 |
| [demo-berlin-pug-lfs](https://github.com/pbi-tools/demo-berlin-pug-lfs) | | 24-Mar-2022 |
| [devops-github-reports-pbixproj](https://github.com/pbi-tools/devops-github-reports-pbixproj) | | 18-Mar-2022 |
| [devops-demo-report](https://github.com/pbi-tools/devops-demo-report) | | 15-Nov-2021 |
| [adventureworksdw2020-pbix](https://github.com/pbi-tools/adventureworksdw2020-pbix) | Dataset Compile | 16-Apr-2021 | [Adventure Works DW 2020](https://aka.ms/dax-docs-samples) | HTTP data source (GitHub) |

### Other

- <https://github.com/pbi-tools/tutorial-devops-reports>
- <https://github.com/pbi-tools/pbix-samples>
- <https://dev.azure.com/pbi-tools/Samples>
- <https://dev.azure.com/pbi-tools/Berlin-PUG>
- <https://dev.azure.com/pbi-tools/DevOps%20Tutorial>
- <https://github.com/mthierba/pbi-rest-api-vscode-samples>
- <https://github.com/mthierba/git-introduction>

## Podcasts

### 5 Sep 2022 SSBI Podcast (Lars Schreiber)

| Link | <https://ssbi-blog.de/podcast/chat-with-mathias-thierbach/> |

## Own Articles

- [TOM Compatibility Levels. The missing documentation](https://goto.pbi.tools/tom-change-log)
- [How-to: List new features in the TOM library](https://notes.mthierba.net/power-bi/analysis-services/list-new-features-in-tom-library)
- [How-to: Create a Power BI Premium dataset via XMLA endpoint and Tabular Object Model (TOM)](https://notes.mthierba.net/power-bi/xmla-endpoint/create-powerbi-premium-dataset-via-tom)
- [How-to: Download the .PBIX file for report when the option is greyed out](https://notes.mthierba.net/power-bi/how-to/download-pbix-report-created-in-service)
- [Release Branching Model for Power BI Projects](https://pbi.tools/devops/release-branching-model/)

## 3rd-party Articles and Mentions

### Data Goblins Blog ([Kurt Buhler](https://twitter.com/kurtbuhler))

- [The Impact Factor of Power BI External Tools](https://data-goblins.com/power-bi/external-tools-impact-factor)
- [Fix Visuals or Replace Measures in Power BI Reports using pbi-tools](https://data-goblins.com/power-bi/replace-report-measures)
- [Track Changes in Power BI: Part 5 - Using pbi-tools](https://data-goblins.com/power-bi/version-control-pt5)
- [Track Changes in Power BI: Part 4 -Reports](https://data-goblins.com/power-bi/version-control-pt4)
- [Running PowerShell from a Python GUI](https://data-goblins.com/power-bi/powershell-in-python-gui)
- [Monitoring Power BI using REST APIs from Python](https://data-goblins.com/power-bi/power-bi-api-python)

### Misc

- <https://powerbi.tips/2022/05/power-bi-hack-download-report-authored-in-browser-as-pbix/>
- <https://codeandsorts.com/source-control-for-power-bi/>

### LinkedIn Mentions

{% include resources/linkedin.html %}

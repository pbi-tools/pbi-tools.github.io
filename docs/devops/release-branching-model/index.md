---
title: Release Branching Model for Power BI Projects
permalink: /devops/release-branching-model/
last_updated: 21 Jun 2022
---

The _Release Branching Model_ is a Project Management/Development model for enterprise Power BI projects. It borrows proven concepts from other Git branching models, provides a high degree of automation in conjunction with the source control and deployment features of [`pbi-tools`](/), and enables teams to successfully collaborate on Power BI report and dataset projects _(support for Dataflows coming)_.

In short, it answers the question:

{% include callout.html content="**How to get changes into Production in a structured, fast, and controlled way?**" type="danger" %}

## Objectives

- **Continuously ship business value**: A regular, predictable release cadence improves buy-in from business, see [Versioned Releases](how-it-works.md#versioned-releases).
- **Production is guarded**: Direct Production access removed in favor of system-driven workflow.
- **Enable parallel development**: Scalability is achieved by dividing work on a milestone among different team members.
- **Deployments are automated**: Removal of manual steps provides maximum consistency and reliabilty.
- **Hold all communication in one system**: The DevOps project (combining git repository, issue tracker, PR reviews) automatically becomes a vital repository for organizational knowledge.
- **Quick feedback**: Developers get to see their changes in a Dev/Test environment immediately, removing blockers and delays.

## How it works

![Diagram-Overview](/images/branching-model-overview.png)

### In a nutshell

1. The `main` branch always represents **Production**.
2. All previous releases are tagged in the git repository.
3. Before work on a new release starts, features and bugs from the backlog are grouped together in a **release milestone** and a new `Release/x.x` branch is created off `main`.
4. Developers begin work on issues assigned to them by creating a new **feature branch** (e.g., `Issue/102-mt`) off the Release branch.
5. The developer creates a **Pull Request** (PR) from the Feature branch to the Release branch once work is ready for review. The PR triggers a deployment into the **Dev/Test** environment. _Optionally, automated tests could be run at this stage, for instance using [Tabular Editor's Best Practice Analyzer](https://docs.tabulareditor.com/te2/Best-Practice-Analyzer-Improvements.html)._
6. The Development Lead reviews the PR and raises questions on the PR conversation tab. Any further commits by the developer trigger new **Dev/Test** deployments.
7. Once a PR is signed off, the changes are merged into the Release Integration branch, which triggers a deployment into the **UAT** environment. _Here, feedback can be collected from external stakeholders._
8. When all issues in scope have been integrated into the Release branch, Release Notes are updated and the Release branch is merged into `main`, which triggers a **Production** deployment.
9. The head of `main` is tagged with the version number, and a release is created in the project (GitHub/GitLab).
10. The new release is now in **Production**.

{% include note.html content="This effectively allows to work on Power BI projects similar to software projects, for which mature development workflows have long been established." %}

### Ingredients {#ingredients}

| **Git Repository** | Keeping all artifacts of a Power BI project under source control is required for change control, versioning, automated deployments, and team collaboration. |
| **Issue Tracker/Backlog** | It is key to hold all bugs and features for a given project in an issue tracker that's integrated with the Git source control system. This allows to link all report/dataset changes to their corresponding issue, including all conversations that took place during review. |
| **Release Milestone** | Grouping a set of issues into a milestone as part of release planning is important since it defines a clear release scope and allows tracking of development progress using burn-down charts and other project management tools. |
| **Versioned Releases** | Similar to software releases (for instance, _Power BI Desktop 2.106_ or _Visual Studio Code 1.68_), Power BI datasets and reports can be developed as versioned releases: Each version represents a particular snapshot of features, and those versions can be referred to without ambiguity by business stakeholders, project leads, documentation writers, testers, developers. All git source control systems allow the tagging of particular points in a project's history with a version number. |
| **Deployment Environments** | At least three environments are recommended for a Continuous Deployment setup: Dev/Test, Staging/UAT, Production. In a Power BI context, each environment usually consists of a different workspace. |
| **CI/CD Pipeline** | The CI/CD pipeline brings everything together in a highly automated fashion. Triggers ensure that processes are system driven. Ultimately, publishing access to Power BI workspaces can be removed from individual developers and entirely delegated to CI/CD pipelines, ensuring a maximum protection of Production environments. |

{% include note.html content="All of the above are provided by any current DevOps system, for instance [GitHub](setup-github.md), Azure DevOps, GitLab, Bitbucket etc." %}

### Key Personas {#personas}

| **Business Stakeholder(s)** | They're your customer and sponsor. Actively involve them in release planning. Convince them of a model that delivers value on a regular cadence. Involve them early as new features become available in UAT. |
| **Project Lead** | The most important role in the model. Enforces the process and enables the developer team. Could also be split between _Product Owner_ and _Technical Lead_. Find a description of project lead workflows [here](workflows-project-lead.md). |
| **Developer(s)** | Require thorough training on the process. Will value the model once the delivery improvements become tangible. Find a description of developer workflows [here](workflows-developer.md). |

## Next Steps

- [How it works](how-it-works.md)
- [Setup: Power BI](setup-powerbi.md)
- [Setup: GitHub](setup-github.md) _(Azure DevOps, GitLab instructions to follow)_
- [Workflows: Project Lead](workflows-project-lead.md)
- [Workflows: Developer](workflows-developer.md)
- [Resources](resources.md)

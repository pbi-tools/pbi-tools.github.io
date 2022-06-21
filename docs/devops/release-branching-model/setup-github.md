---
---

## Repository Settings

### Set secrets at the environment, repository or organization level

![GitHub Repo Secrets](/images/setup-github-074519.png)

Reference the secret in the workflow YAML file:

<script src="https://gist.github.com/mthierba/c93a0dc024c8a10f54594b273593e25e.js"></script>

### Protect the 'main' and 'Release' branches

![Branch Protection](/images/setup-github-075259.png)

![Branch Protection Detail](/images/setup-github-075333.png)

Further Reading: [About protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)

### Optionally, configure Environment protection rules

![Environment Protection Rule](/images/setup-github-075044.png)

### Optionally, protect tags

![Protected tags](/images/setup-github-075209.png)

This prevents developers from creating and pushing their own tags.

## GitHub Actions - CI/CD Pipeline

Each CI/CD pipeline is defined as a workflow with a corresponding YAML file in the (standard) `.github/workflows` folder:

![GitHub Workflows Folder](/images/setup-github-075842.png)

The three workflow files aboce are essentially identical. They only differ in the type of trigger used and the target environment.

### Development Trigger

```yaml
on:
  pull_request:
    branches:
      - 'Release/*'
```

### UAT/Staging Trigger

```yaml
on:
  push:
    branches:
      - 'Release/*'
```

### Production Trigger - Schedule

```yaml
on:
  schedule: 
    - cron: '0/10 * * * *'
```

### Production Trigger - Push

```yaml
on:
  push:
    branches:
      - 'main'
```

### Full Example

<script src="https://gist.github.com/mthierba/9fb927470616c82a630452b00cf07487.js"></script>

### View previous workflow runs on the "Actions" tab

![Workflow Runs](/images/setup-github-080900.png)

### Environments

Access active environments from the project landing page:

![Environments](/images/setup-github-080948.png)

The full deployment history for all environments:

![Deployment History](/images/setup-github-081005.png)

Detail view for a particular deployment:

![Deployment Detail](/images/setup-github-081155.png)

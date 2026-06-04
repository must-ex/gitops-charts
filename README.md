# gitops-charts

Shared Helm charts for product GitOps. Charts here are consumed by product gitops repos (`custody-gitops`, `finora-sto-gitops`, etc.) via Helm dependency / git ref.

## Structure

```
charts/
  <product>/        # Helm chart per product (templates + default values)
.github/workflows/
  ci-validate.yml      # helm lint, kubeconform schema check
  impact-preview.yml   # render all consumers and post diff on PR
consumers.yaml         # registry of product gitops repos that depend on charts here
```

## Ownership

DevOps team. Product-specific values live in each product's gitops repo, not here.

## Versioning

Each chart follows semver via git tags: `<chart>-vX.Y.Z` (e.g. `custody-v0.1.0`).
Backward compatibility required — new fields must have defaults.

## Contributing

PRs trigger `ci-validate` and `impact-preview` automatically. Review the per-consumer diff before merging.

See [DevOps GitOps Operations Strategy](https://www.notion.so/...) for the full operating model.

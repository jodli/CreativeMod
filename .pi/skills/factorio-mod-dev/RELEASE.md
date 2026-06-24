# Release Reference

## How the workflow works

`.github/workflows/release.yml` triggers on **any tag push**.

It:
1. Verifies the pushed tag name matches `version` in `info.json`
2. Verifies `changelog.txt` contains a `Version: <tag>` entry
3. Packages the mod zip via `Roang-zero1/factorio-mod-package`
4. Creates a GitHub Release and uploads the zip as an asset

Pushes to `master` alone do **not** trigger a release — only the tag does.

## Checklist for a new release

```bash
# 1. Bump version in info.json
#    "version": "X.Y.Z"

# 2. Prepend a changelog entry (see format below)

# 3. Commit
git add info.json changelog.txt
git commit -m "chore: bump version to X.Y.Z and add changelog entry"

# 4. Tag (must match info.json version exactly — no "v" prefix)
git tag X.Y.Z

# 5. Push commits + tag
git push origin master
git push origin X.Y.Z
```

The tag push fires the workflow. Check progress at:
`https://github.com/jodli/CreativeMod/actions`

## changelog.txt format

```
---------------------------------------------------------------------------------------------------
Version: X.Y.Z
Date: YYYY-MM-DD
  Bugfixes:
    - Description of fix.
  Features:
    - Description of feature.
  Changes:
    - Description of change.
---------------------------------------------------------------------------------------------------
```

Only include sections that apply. Entry must go at the **top** of the file (before the previous version).

## Version conventions

| Change | Bump |
|---|---|
| Factorio version port or breaking change | minor (`2.1.x → 2.2.0`) |
| Bug fix or small improvement | patch (`2.1.x → 2.1.x+1`) |
| New user-facing feature | minor |


# Own Bread

Own Bread is a Flutter product prototype for home bakers. It turns bread baking from a static recipe-reading experience into a guided step-by-step session.

## MVP flow

Home → Recipe detail → Start baking → Guided steps → Complete session

## Tech

- Flutter
- Dart
- Local mock data for fast prototyping

## Design system

**Implemented in code:** theme tokens live under [`lib/app/theme/`](lib/app/theme/) (`AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppTheme`).

### View the HTML reference

| Where | Link |
|--------|------|
| **This repo on GitHub** | [Open `docs/own-bread-design-system.html`](docs/own-bread-design-system.html) — opens the file in GitHub (use **Raw** or clone locally for full interactivity). |
| **Live page (recommended)** | After you enable **GitHub Pages** (Settings → Pages → Branch `main` / folder `/docs`), use:<br>`https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/own-bread-design-system.html`<br>or the short root URL (redirects to the same page):<br>`https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/` |

Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your GitHub user/org and repository name.

**Local:** double-click `docs/own-bread-design-system.html`, or from the repo root: `start docs\own-bread-design-system.html` (Windows).

The page documents the palette and typography with copyable HEX swatches (works best via GitHub Pages or opening the file locally).

### How to show “design system complete” in this README

Use one or more of these:

1. **Checkbox list** — mark the doc and the code when both exist:

   ```markdown
   - [x] Theme tokens in `lib/app/theme/`
   - [x] Design system reference page: `docs/own-bread-design-system.html`
   ```

2. **Badge line** — short status under the title or in a “Status” subsection:

   `Design system: documented (HTML) + implemented (Flutter theme)`

3. **Screenshot** — add `docs/design-system-preview.png` (optional) and link it: `![Design system](docs/design-system-preview.png)` so the README shows visual proof at a glance.

**Status (edit as you ship):**

- [x] Flutter theme tokens (`lib/app/theme/`)
- [x] Static design-system page (`docs/own-bread-design-system.html`)

## Structure

```text
lib/
  app/
    app.dart
    theme/
  core/
    widgets/
  features/
    home/
    recipes/
    baking_session/
  shared/
    models/
```

## Run

```bash
flutter pub get
flutter run
```

## Next steps

- Add active timers
- Add local persistence
- Add settings and history
- Add polished submission README and video link

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

**Static reference (for reviewers / portfolio):** open [`docs/own-bread-design-system.html`](docs/own-bread-design-system.html) in your browser (double-click the file, or from the repo root run `start docs/own-bread-design-system.html` on Windows). It documents the same palette and typography with copyable HEX swatches.

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

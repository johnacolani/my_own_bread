# Own Bread

Own Bread is a Flutter product prototype for home bakers. It turns bread baking from a static recipe-reading experience into a guided step-by-step session.

## MVP flow

Home → Recipe detail → Start baking → Guided steps → Complete session

## Tech

- Flutter
- Dart
- Local mock data for fast prototyping

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

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
- Add video link (demo / walkthrough)

---

## Section A — Design Rationale

**Who and what problem**  
The user is a **home baker** who already has recipes but struggles to stay oriented while hands are in dough or flour. Reading a long block of text on a phone is easy at the counter; **executing** it while timing proofs and bakes is not. The problem is **cognitive load and context-switching**: leaving the flow to find the next instruction or remember how long a step runs. That matters because bread mistakes are slow and costly—ruined loaves waste time and ingredients, and the hobby stops feeling restorative.

**Solution directions**  
I considered: (1) a **recipe library** with rich metadata but no session mode—fast to build, weak during the bake; (2) **video-first** tutorials—high production cost and not recipe-agnostic; (3) a **guided session** that walks one recipe step-by-step with optional timing cues. I chose (3) because it directly addresses “what do I do *now*?” and scales from mock data to real persistence later without rethinking the core UX.

**Assumptions**  
I assumed bakers want **linear steps** with clear “next” affordances; that **suggested durations** per step (not rigid automation) are enough for an MVP; and that **local mock recipes plus a simple create flow** are acceptable to test layout and flow before backend work. The **highest-risk** assumption is that people will actually **start a session** instead of only browsing recipes—that should be validated first, because the product’s value is in the session, not the catalog.

**Success**  
Success means bakers **complete a session** without abandoning mid-flow. I’d measure: **session start rate** (detail → start), **step completion** (funnel through steps), **session completion rate**, and qualitative **“I knew what to do next”** in interviews. Early prototypes: weekly builds with 3–5 target users; after changes, same cohort for comparison.

**MVP cuts and v2**  
For this MVP I cut: **persistent storage**, **history**, **notifications**, **fine-grained timer presets**, and **social/sharing**. The MVP proves the **guided path and visual calm** of the experience. v2 would add **saved sessions and history**, **reliable timers and background alerts**, **settings** (units, defaults), and possibly **recipe import** or cloud sync once the core loop is validated.

---

## Section B — Design Decisions & Next Steps

**Decision 1 — Guided session over “kitchen dashboard”**  
**Trade-off:** A single-recipe, full-screen session **reduces** glanceable access to multiple recipes at once but **gains** focus and a clear mental model (one loaf, one path). I gave up flexibility for power users who juggle several bakes; I gained a simpler state machine and a clearer story for first-time users.

**Decision 2 — Analog-style timer for timed steps**  
**Trade-off:** An analog presentation is less “precision instrument” than a digital countdown in a utility app. I accepted slightly less at-a-glance precision for **warmth and craft alignment** with baking as a hands-on ritual, while still anchoring duration to the step. I gave up ultra-compact numeric urgency; I gained differentiation and a calmer feel during long proofs.

**Decision 3 — Mock data + in-app recipe creation**  
**Trade-off:** No backend keeps the prototype fast and offline-friendly. I gave up multi-device sync and shared libraries; I gained **end-to-end flow testing** (create → list → detail → session) without infrastructure, so design and navigation can be validated before persistence work.

**If I had another 30 minutes**  
I’d refine **empty and edge states**: last step completion copy, behavior when a recipe has no timed steps, and **tap targets** on the session screen for floury fingers. I’d add one **micro-interaction** (e.g. step transition) so the flow feels finished, not just functional.

**User research for the core assumption**  
I’d run **5–30 minute moderated sessions** with home bakers: give them a realistic recipe and ask them to **complete a bake** using the app while thinking aloud. I’d watch for **hesitation before “Start baking”**, confusion on **which step they’re on**, and whether they **trust the suggested times**. I’d follow with a short debrief: “When would you use this vs. paper or a blog?” That directly tests whether **session mode** is compelling enough to return to.

---

## Section C — AI Usage Log

This documents significant AI-assisted steps—not to claim the work was automated, but to show how AI fit into design and implementation decisions.

1. **Theme and project structure**  
   - *Asked:* Help organizing Flutter theme tokens (colors, type, spacing) and a sensible `lib/` feature layout for a small app.  
   - *Got:* Suggested folder structure and naming patterns for `AppTheme`-style consolidation.  
   - *Kept/changed:* Adopted the token-based approach and feature folders; adjusted names and values to match the bread brand and my own spacing scale.

2. **Guided baking session UX**  
   - *Asked:* Feedback on a linear step flow (next/finish), optional per-step timers, and completion screen—what to prioritize in an MVP.  
   - *Got:* A rationale for keeping one recipe per session and deferring persistence.  
   - *Kept/changed:* Kept the linear session model; simplified some ideas (e.g. skipped background timers until a later iteration).

3. **Analog timer widget**  
   - *Asked:* Ideas for a step timer that feels crafted rather than clinical, implemented in Flutter.  
   - *Got:* Implementation direction for a custom painter / animated dial–style control.  
   - *Kept/changed:* Kept the analog concept and core behavior; iterated on sizing and when the timer appears so it does not dominate non-timed steps.

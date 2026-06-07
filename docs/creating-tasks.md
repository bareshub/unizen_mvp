# Creating Tasks (GitHub Issues)

This guide describes how to write GitHub issues for UniZen so that work is tracked consistently and is easy to plan, link, and review.

## Issue Types

Prefix the issue title with one of the following tags:

- `[Epic]` — A large body of work spanning multiple issues (e.g. a whole screen or feature area).
- `[Layout]` — Implementing a UI layout/screen from a design mockup.
- `[Spike]` — Time-boxed research/investigation to explore an approach or technology before committing to it.
- `[Design]` — Visual/UX design work (mockups, design system updates, asset preparation).
- `[Navigation]` — Routing/navigation flow changes (GoRouter routes, redirects, deep links).
- `[Doc]` — Documentation (README, guides, code comments at scale, ADRs).
- `[Chore]` — Maintenance work (dependency bumps, refactors, tooling, CI, migrations).
- `[Persistence]` — Data storage/repository layer work (local/remote data sources, caching, models).
- `[Fix]` — A bug fix. Most issue trackers separate this from `[Chore]` because fixes are user-facing and often need to be prioritized/triaged differently from maintenance work.
- `[Animation]` — 3D model/animation work (boss scenes, transitions, `flutter_scene` integration).
- `[Localization]` — Translation and locale-specific behavior.

Title format: `[Type] Short, descriptive name` — e.g. `[Layout] Add Exam Page`, `[Epic] Exam Roadmap`.

## Sections

Every issue should contain the following sections, in this order. Omit a section only if it doesn't apply (e.g. `Resources` on a chore with no mockups).

### Description

A short paragraph explaining *what* needs to be done and *why*. For Epics, describe the overall goal and the user value; for individual tasks, describe the specific piece of work.

### Expected Behavior

A checklist (`- [ ]` / `- [x]`) of concrete, verifiable outcomes. Each item should describe an observable behavior or requirement, not an implementation step. Check items off (`- [x]`) as they are completed; leave incomplete items unchecked (`- [ ]`).

```md
- [x] Layout matches the designed mockup
- [ ] The text field for exam name has a validator for minimum and maximum name length
```

### References

Links to related issues, using GitHub's auto-linking (`#<issue-number>`):

```md
- Epic: #45
- Based on: #46
```

Common relation labels: `Epic`, `Based on`, `Blocks`, `Blocked by`, `Related to`.

### Resources / Additional Context

Anything that helps whoever picks up the issue:

- Design mockups or screenshots (drag-and-drop images into the issue body so GitHub hosts them, or paste `<img>` tags with the generated `user-attachments` URL).
- Links to relevant packages or API docs, e.g. [pub.dev: \`carousel_slider\`](https://pub.dev/packages/carousel_slider).
- Any constraints, decisions, or context that isn't obvious from the description.

Use `Resources` when the section is mainly visual (mockups, screenshots) and `Additional Context` when it's mainly links/notes. Either name is fine — pick whichever fits the content.

## Examples

### Layout / Feature task

```md
[Layout] Add Exam Page

### Description
Implement the Add Exam Page Layout.

### Expected Behavior
- [x] Layout matches the designed mockup
- [x] Horizontal scroll view with different ECTS and Bosses
- [x] The selected ECTS card stand out, making the boss image bigger
- [x] The text field for exam name has a validator for minimum and maximum name length

### References
- Epic: #45
- Based on: #46

### Additional Context
- [pub.dev: `carousel_slider`](https://pub.dev/packages/carousel_slider)
- [pub.dev: `carousel_view`](https://api.flutter.dev/flutter/material/CarouselView-class.html)
```

### Epic

```md
[Epic] Exam Roadmap

### Description

Design and implement the Exam Roadmap Screen, a centralized view where users can visualize all their exams as a progression path. Each exam is represented by a "boss" along the roadmap, allowing users to track their progress and see a recap of each exam in one place.

### Expected Behavior

- [x] Display all exams as a sequential visual path (roadmap), with each exam represented by a boss.
- [x] Upper summary with the average grade and the number of passed exams
- [x] A "+" icon at the end of the roadmap lets users add a new exam, navigating to the Add Exam Page.
- [x] When a new exam is added, a new path and boss node is created on the roadmap.
- [ ] The final exam (thesis) should be treated as a final boss, requiring a dedicated section on the Add Exam Page to flag it.
- [x] Tapping on a boss opens a detailed recap card, showing exam info and providing an option to start the timer.

### Resources

<img width="394" height="806" alt="Image" src="https://github.com/user-attachments/assets/585d3353-0c8c-4724-88b1-d50fb29f52db" />
```

## Tips

- Keep `Expected Behavior` items small and independently checkable — this makes review and progress tracking easier.
- Link an issue to its Epic as soon as it's created so the roadmap stays navigable.
- When an issue is split off from a larger one, reference it with `Based on: #<issue-number>`.
- Branch names should reference the issue, e.g. `feature/<issue-number>-short-description` or `chore/<issue-number>-short-description` (see recent branches like `epic/54-exam-roadmap` and `chore/66-migrate-flutter-version`).

# AGENTS.md

## Project

DoctorHunt — a simple Flutter MVP/training app for booking doctors, with two user types: **patients** and **doctors**. The project is currently **UI-first**; Firebase is the eventual backend but is NOT implemented yet.

**Core principle: keep the architecture clean, predictable, and simple. Do not turn this MVP into enterprise architecture.** No unnecessary layers, abstractions, packages, or state-management complexity.

## State of the repo

- The repo is **not yet scaffolded** (empty directory at time of writing). If `pubspec.yaml`/`lib/` do not exist, do not invent application architecture or implementation on your own.
- When scaffolding is explicitly requested: run standard Flutter scaffolding first (e.g. `flutter create .`), then apply the DoctorHunt structure/conventions below. Do not silently create a different architecture.
- Always inspect the **actual current structure** before changing anything; the intended layout is a convention to follow, not an assumption to code against.

## Intended structure

```
lib/
├── main.dart
├── apps/
│   ├── core/
│   │   ├── extensions/
│   │   ├── network/
│   │   ├── router/
│   │   ├── utils/
│   │   └── widgets/
│   ├── features/<feature>/
│   │   ├── data/{models, repo, service}
│   │   └── presentation/{controller, screens, widgets}
│   └── main/
└── generated/            # app_colors.dart, image_assets.dart, style_atom.dart
```

Every feature follows the same `data/{models, repo, service}` + `presentation/{controller, screens, widgets}` layout. There is **no `domain` layer** — do not introduce one without approval.

## Stack (locked)

- **Models:** `freezed` + `json_serializable`; immutable. Generated files stay next to their sources. Freezed is for **models only**, never Cubit states.
- **Repositories:** abstract contract + concrete implementation in `feature/data/repo/` — e.g. `doctor_repository.dart` + `doctor_repository_impl.dart`. Keep repo responsibilities separate from API/backend transport. Follow an existing naming convention if one is established.
- **Services:** API/backend communication only — no UI or business-flow logic.
- **State:** `flutter_bloc`, **Cubit by default**. Use full Bloc only when genuinely event-driven. Standard flow: `initial → loading → success → failure`; add states only when needed.
- **DI:** `get_it` + `injectable`. Presentation code obtains Cubits/repos/services through the existing DI setup and `BlocProvider` pattern — never manually construct dependency graphs or instantiate them in UI code. Do not introduce another DI mechanism.
- **Cubit/Bloc lifecycle & provisioning:** Provide new Cubit/Bloc instances via `BlocProvider(create: (_) => getIt<SomeCubit>(), ...)` so the provider owns the instance's lifecycle. Do not create Cubits manually in `initState`, store them in widget fields, or use `BlocProvider.value` just because the instance was manually created. Register Cubits in GetIt as transient factories (`@injectable`, never `@lazySingleton`/`@singleton`) so each provider/screen instance gets a fresh Cubit and GetIt never hands back an instance that `BlocProvider` has closed. Keep `BlocProvider.value` only when deliberately passing an already-existing instance whose lifecycle must remain owned elsewhere.
- **Navigation:** `go_router`, centralized in `apps/core/router/`. No direct `Navigator` use in feature code. No auth guards unless requested.
- **Responsive:** `flutter_screenutil` for Figma-derived UI dimensions (`.w`, `.h`, `.sp`, `.r`). Don't apply it blindly to every numeric value — non-dimension/API/framework constants stay normal values. Responsiveness adapts the Figma design; it must NOT redesign the UI (visual hierarchy, component structure, spacing system, interaction patterns stay as designed).
- **Design tokens:** centralized in `lib/generated/` (`app_colors.dart`, `image_assets.dart`, `style_atom.dart`). **Never hand-edit generated files** — see Generated files below.
- **Styling (mandatory):**
  - Use `atmos_style` for **all** UI styling. Never use inline `TextStyle(...)` objects or ad-hoc style construction. Every text/typography style must come from `atmos_style`.
  - Use `app_colors` for **all** colors. No hardcoded color values anywhere in UI code — colors must come from `app_colors`.
  - When a style or color you need isn't available, extend/modify the generation source that produces `style_atom.dart` / `app_colors.dart` and regenerate — never hand-edit generated files and never inline a one-off style/color.
- **Const:** prefer `const` constructors/values where applicable and they improve immutability/performance; don't force `const` where it reduces readability or isn't applicable.

## UI / Figma

Figma design is the **single source of truth** for visual and interaction design: https://www.figma.com/design/C1vB8GJpBtmElvfrVcqxeA/Doctor-Hunt--Code-PLus-?node-id=0-1&p=f&t=0w9MzoiO58T5Y23u-0 (accessed via the Composio/Figma MCP).

Workflow for any UI: analyze Figma → identify reusable components → map design tokens → implement shared widgets → implement screen → compare with Figma → fix visual differences → verify again. Follow the design's colors, type, sizes, spacing, radii, borders, shadows, icons, images, states, layout, and responsive behavior. If a Figma design is available, do not invent an alternative UI. Fix small visual mismatches without asking; significant design-interpretation decisions require approval. If Figma/MCP is unavailable and the UI can't be determined reliably, ask — don't guess.

## Localization

English-only; no localization package at this stage and none should be introduced unless explicitly requested. Don't hardcode repeated/user-facing strings in widgets — follow the project's centralized-strings convention if one exists. If no string-management convention exists and creating one would be a project-wide architectural decision, ask the user first. Don't add a localization package just to solve this.

## Dependencies

Never add a dependency without explicit approval. Check the existing stack/SDK first. Never silently modify `pubspec.yaml`.

## Layer responsibilities

```
UI / widgets → Cubit / controller → repository → service → backend / API
```

- **UI/widgets:** render UI and dispatch user actions.
- **Cubit/controller:** feature state, business rules, async flows, presentation logic.
- **Repository:** data access and repository abstraction.
- **Service:** API/backend transport only.
- **Models:** data representation.

Do not move business logic into widgets, services, or repositories when it belongs in the Cubit/controller.

## Snackbar notifications

Use the project's snackbar extension (`SnackbarsContext`) for all user-facing success/error notifications in presentation code. Call `context.showErrorSnackBar(message)` on failure and `context.showSuccessSnackBar(message)` on success. The extension handles styling, animation, and dismissal automatically — never build custom snackbars or use `ScaffoldMessenger` directly. In Cubits/controllers, emit states (`success`/`failure`) with messages; the UI layer consumes those states and triggers the appropriate snackbar.

## Strict rules

- No `print`.
- No business logic in screens or UI widgets.
- No `BuildContext` in repositories, services, models, or Cubits/controllers — `BuildContext`-dependent operations live only in the presentation/UI layer.
- No `setState` when state belongs in a Cubit — Cubit should normally own feature state.
- No hardcoded colors — all colors must come from `app_colors`.
- No inline `TextStyle(...)` objects or ad-hoc styles — all text/typography styles must come from `atmos_style`.
- No hardcoded user-facing strings.
- No unnecessary duplication, abstractions, or dependencies.
- No direct navigation outside the centralized router.
- No backend/Firebase implementation, tests, git operations, architecture changes, or unrelated refactoring unless explicitly requested.
- No edits to generated files unless required via their generation source.
- No inline `ElevatedButton`/`TextButton`/`Material` buttons when a shared widget exists — always use the project's shared widgets (e.g. `PrimaryButton` in `apps/core/widgets/`) instead of re-implementing the same design inline. If the shared widget doesn't cover a needed variant, extend it or ask before creating a duplicate.

## Magic numbers

- Avoid magic numbers in business logic and UI.
- UI dimensions, spacing, font sizes, radii, and similar design values must come from the Figma/design system and use ScreenUtil where appropriate.
- Literal values are allowed when semantically meaningful or required by an API/framework — not every numeric literal is a magic number.

## Comments

No restatement comments. Only non-obvious reasoning, constraints, architectural decisions, workarounds. Prefer self-explanatory code.

## Reusable widgets

Feature widgets → `feature/presentation/widgets/`. Shared app-wide widgets → `apps/core/widgets/`. Promote to core only for genuinely shared behavior; avoid premature abstraction.

## Existing code takes precedence

Before introducing a new pattern, inspect how the existing codebase solves the same problem. Prefer consistency with established project conventions over a theoretically "better" pattern. Do not rewrite working code because you prefer a different structure, and do not add a new abstraction when an existing one already solves the problem.

## Generated files

Never manually edit generated files. If a generated file must change: (1) identify the actual generation source/config/command in the repository, (2) modify the source/config, (3) regenerate the output when appropriate. Never invent a generation source or manually recreate generated output.

## Verification

```
Implement → dart format . → dart analyze / inspect LSP diagnostics → fix errors/warnings introduced by the changes → dart analyze again
```

Use the Dart LSP/analyzer feedback while implementing. A task is not complete while your changes leave analyzer errors; unrelated pre-existing analyzer issues don't block completion. No tests are needed or written — unit, widget, or integration — unless explicitly requested. The repo keeps no test suite; don't create, update, or maintain one. Don't claim something was verified if it wasn't.

## Ask before you decide

Ask the user before touching: architecture, dependencies, public APIs, navigation structure, major UI/design interpretation, new layers/patterns, backend/Firebase work, or significant refactors. For small local details, just pick the simplest reasonable implementation consistent with the project.

## Task workflow

Understand task → inspect structure → inspect related code → inspect Figma → find reusable components/tokens → identify ambiguities → ask the user if a significant decision is required → plan → implement → compare with Figma → fix diffs → format → analyze → fix → analyze → report what changed and any limitations. Don't start implementing on an assumption when the ambiguity could materially affect architecture, behavior, navigation, dependencies, or design. For small local details, use the simplest reasonable solution without interrupting the user. Search before creating; reuse existing conventions.

## Git

No commit/push/merge/rebase/reset/amend unless explicitly requested. When a commit is requested, use Conventional Commits (`feat:`, `fix:`, `refactor:`).

## Definition of done

Implemented; follows the existing architecture and folder structure; matches Figma as closely as reasonable; reuses existing widgets/tokens; no new deps/architecture/Firebase; no unrelated refactoring; formatted; no new analyzer errors/warnings introduced by the changes (pre-existing unrelated issues don't count); respects the strict rules; final response summarizes changes and remaining limitations. Don't claim the code is clean unless the relevant verification actually ran.

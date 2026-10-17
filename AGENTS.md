# AGENTS.md

## Mission

Senior Flutter/Dart engineer. Write idiomatic, simple, correct code consistent with this repo's existing conventions. Smallest clear solution over clever or over-engineered ones. When a project convention conflicts with a generic preference here, follow the project.

## Advisory Role & Decision Approval

- Not just an implementer: if you see a better approach (architecture, performance, maintainability), say so with the trade-offs of both options.
- **Significant** decisions (architecture, new layers, public APIs, new dependencies, breaking changes): do not implement anything — requested or proposed — until the user explicitly approves the specific approach.
- **Minor** implementation details: don't ask, just pick the simplest reasonable option matching existing code, and mention any alternative in passing.

## Research

Trust order: this repo's code/rules > official Flutter/Dart/pub.dev docs > other sources. Don't search the web for basic facts; search only for version-specific or unfamiliar package/API behavior.

## Before Coding

- Inspect: `pubspec.yaml`, `lib/`, existing architecture, state management, DI, routing, shared widgets, design tokens, `.env`/`.env.example`, `slang` setup.
- Search for an existing equivalent before creating a new class/widget/service/repository/helper. Reuse > extend > create new.
- Don't web-search basic Dart/Flutter facts you already know. Search only for version-specific/unfamiliar API behavior, preferring pub.dev and official docs.

## Project-Specific Rules

**Feature layout**

- Feature-first: `lib/apps/features/<role: common | patient | admin>/<feature>/` with `presentation/` (screens, widgets, controller) and `data/` (service, repo, models). Shared infra lives in `lib/apps/core/` (router, di, theme, models, error, widgets, extensions, utils). Mirror an existing feature's folders when adding a new one.
- Shared cross-feature models (`Doctor`) live in `apps/core/models/doctor.dart`; feature-local models (`UserProfile`, `Role`) live in the feature's `data/models/`.
- The `auth` feature (renamed from `login`) is the repo's Clean Architecture exemplar: `domain/` (`repositories/` abstract contract + `usecases/`), `data/` (`remote_data/` transport + `repo/` impl), `presentation/`. Reuse that shape for the next approved domain refactor.

**Layering**

- `auth`: `Cubit → Use case → Repository → RemoteDataSource → Firebase`, plus `UserService` for profile writes. Use cases own error translation to `AuthFailure`; the repository impl is data-only orchestration (no try/catch mapping). All other features keep `Cubit → Repository → Service → Firebase` until a domain layer is explicitly approved for them.
- `Role`/`UserProfile`/`UserService` stay in the `profile` feature; auth's layers import them. `AuthFailure` stays in `core/error`. No entities in `auth/domain` yet.

**DI — injectable + get_it**

- Annotations: services/use cases `@lazySingleton`; repository impls `@LazySingleton(as: Interface)`; cubits `@injectable` (registered as GetIt factories); Firebase instances via `FirebaseModule` (`@module`). `core/di/injection.dart` is the only hand-written DI file; the rest is generated.
- Regenerate after changing registrations: `dart run build_runner build --delete-conflicting-outputs` (rewrites `lib/apps/core/di/injection.config.dart`).
- Screen-scoped cubits: `BlocProvider(create: (_) => getIt<XCubit>()..load())` — cubits are GetIt factories, so BlocProvider owns disposal. Shared feature cubits are passed across screens via router `state.extra` (a record like `(ManageDoctorsCubit, Doctor?)`) and exposed with `BlocProvider.value` (see `doctor_form_screen.dart`). App-wide session state (`AuthRoleNotifier`) is a lazySingleton read via `getIt` directly.

**Auth / routing**

- One centralized `GoRouter` in `core/router/app_router.dart`. Route paths are `AppRouter.xxx` constants; navigate with `context.go` / `context.push` / `context.pop` (go_router), never raw `Navigator`.
- `AuthRoleNotifier` (`core/auth/auth_role_notifier.dart`) is the single session + role source the router redirects on (status unknown/authenticated/unauthenticated; `Role` is only `patient` or `admin`). Don't add a second session-tracking mechanism.

**Branching**

- All Clean Architecture refactoring — introducing domain layers (`domain/`), feature renames/re-layouts (e.g. `login → auth`), or promoting shared widgets/models into `apps/core/` — happens ONLY on the `clean-architecture` branch. Regular feature work continues on its own branch; CA changes are reviewed/merged through the normal flow.

**Data / Firestore**

- Services are thin per-feature Firestore transports. Collection names are private constants on the service (`static const _collection = 'doctors'`) — don't inline them at call sites.
- New Firestore doc ids are generated client-side via `_firestore.collection(c).doc().id` before `set()`.
- Profiles live at `users/{uid}` with `role` serialized via `role.name` (`UserProfile.toJson`). Models use `fromJson(String id, Map<String, dynamic>)` / `toJson()` with `??` defaults.
- Google OAuth uses `AppConstants.googleServerClientId` (web OAuth client id, `core/utils/app_constants.dart`).

**Errors**

- Pipeline: auth use cases (or repository impls in non-auth features) throw `AuthFailure(code: ..., cause: ...)` → cubit catches `on Exception` and stores `mapError(e)`'s code in state → UI maps the code to a translated message via `context.resolveAuthCode(code)` and shows it with `context.showErrorSnackBar` / `context.showSuccessSnackBar`. Reuse those extensions (`core/extensions/error_mapper.dart`, `core/extensions/snackbar_context.dart`); `google-signin-canceled` maps to an empty string (silent).

**Localization & tokens**

- `slang`, single locale `en`; source strings in `lib/i18n/en.i18n.json`. Regenerate with `dart run slang` (outputs `strings.g.dart` + `strings_en.g.dart`). Access via `context.t.<group>.<key>`.
- Colors: `AppColors.<name>` (`core/theme/app_colors.dart`, "generated from Figma") — add new colors there, never inline hex. Text styles: generated atoms `context.<weight><size><ColorName>` from `lib/generated/style_atoms.dart` (e.g. `context.semiBold21BlackSoft`, `context.regular15.greyPaleBlue.copyWith(...)`). That file is output of `lib/generate_styles.dart` — edit the script and run `dart run lib/generate_styles.dart` (repo root); never hand-edit.
- Responsive sizing via `flutter_screenutil` (`.w` / `.h` / `.r` / `.sp`, design size 375×812). Asset paths via `ImageAssets` (`core/utils/image_assets.dart`). Reuse shared widgets `PrimaryButton`, `BackgroundBlobs`, `LoadingScreen`, `AppShell`, `ConfirmationDialog`/`SuccessDialog` (`core/widgets/`). Form validators via `AppValidator` (`core/utils/app_validator.dart`), which return translated messages.

**Commands & verification**

- `flutter analyze` (lint + typecheck; flutter_lints) and `dart format`. No test directory exists yet — don't invent a test command.
- Regeneration commands: DI → `dart run build_runner build --delete-conflicting-outputs`; i18n → `dart run slang`; styles → `dart run lib/generate_styles.dart`; Firebase platform config → `flutterfire configure` (rewrites `lib/firebase_options.dart`).

**Pre-approved packages** (no re-approval needed for their intended purpose): `flutter_dotenv` (env/secrets), `slang` + `slang_flutter` (localization). Any other new dependency still needs approval.

**Don't infer a rule from one instance.** Only record something here as a project-wide rule if the pattern repeats across multiple existing features, the user stated it explicitly, or it's documented elsewhere in the repo.

## Code Quality

Follow Effective Dart (naming, imports, null-safety, immutability) — no need to restate the basics; only note deviations in Project-Specific Rules.

- One responsibility per function; small, early returns, no deep nesting.
- No workarounds for real bugs: no `Future.delayed` to patch a lifecycle/race issue, no `dynamic`/casts/`!` to silence type errors, no duplicate state to dodge a proper fix. If a workaround is genuinely required by an external limitation, comment why and isolate it.
- Errors: never swallow silently, never empty `catch`, only catch what you can handle/transform/report. Convert to the project's failure representation; keep user-facing messages separate from technical detail.
- `BuildContext`: check `mounted`/`context.mounted` after `await`; never store `BuildContext` in non-widget/long-lived classes.

## Widgets & State

- Split any widget doing more than one visual job into smaller widgets.
- Purely ephemeral, local-only UI state (obscure-password toggle, expand/collapse, hover) → local `setState` in the smallest widget that needs it, not the shared Cubit/Bloc. Promote to shared state only if something outside that widget must read/control it.
- Don't wrap a large tree in one `StatefulWidget`/`BlocBuilder`/`Consumer` when only a small part needs to rebuild.

## Cubit + GetIt Provisioning

- `BlocProvider.create`: screen-scoped Cubit, new instance per subtree — disposed automatically by `BlocProvider`. Never call `.close()` on it manually.
- `BlocProvider.value`: instance already exists (from GetIt or an ancestor) and must outlive/be shared — `.value` never disposes it. Never pass a freshly created Cubit here.
- Resolve from GetIt directly for app-wide/session-wide state registered as `singleton`/`lazySingleton`, or when DI wiring is required.
- Disposal: GetIt `factory` + `.value` → whoever resolved it must close it manually. GetIt `singleton`/`lazySingleton` → never close manually. Never wrap a GetIt singleton in `BlocProvider.create`.
- Match how existing Cubits in the project are already provisioned before introducing a new pattern.

## Architecture

Clean Architecture as a guideline, proportional to actual complexity — not every layer is mandatory.

- **Layering**: `Presentation (screens, widgets, Cubit/Bloc) → Repository → Service (API/DB/Firebase/etc.) → external source`. A Cubit/Bloc depends on the Repository only, never directly on a Service/API client — Services are consumed exclusively by repositories. If a feature has no repository layer, stay consistent about that within the feature.
- **Domain layer is not mandatory by default.** Consider it only when business logic is genuinely non-trivial, reused across multiple flows, or needs independent testability. Before adding one, ask for explicit approval, stating: why it's needed, what business logic would live there, what files/classes it adds, and the simpler alternative (keeping logic in the repository/Cubit).
- Avoid: use-cases that only forward one repository call, domain entities that just duplicate a data model, repository abstractions that add no real separation, and any layer that exists only to match a diagram.
- Keep business logic out of widgets; keep presentation logic out of repositories/services; keep data-source/API logic out of Cubits and widgets.
- Existing project: inspect the current architecture and state-management/DI/repository patterns first, and reuse them. Don't move working code between layers without a concrete reason — ask before any significant architectural change.
- Decision priority when unsure where code belongs: existing project convention → Clean Architecture principle → simplicity/maintainability → actual business complexity → avoidance of unnecessary abstraction.

## Design Tokens

Use existing `AppColors`/`AtomsStyle` (or the project's equivalent) — never hardcode a `Color`/`TextStyle` that already has a token. Missing token → add to its source, not inline. Never hand-edit generated token files.

## Environment Variables & Secrets

Use `flutter_dotenv`, reading from a `.env` file (gitignored), with a matching `.env.example` (placeholders, committed). New secret → add the key + placeholder to `.env.example` and read it via `flutter_dotenv`; never hardcode it.

## Localization

- User-facing text (labels, buttons, messages) → `slang`/`slang_flutter` keys. No hardcoding; reuse existing keys.
- Technical strings stay plain (not translated): logs, error codes, enum values, route names, analytics/event keys, env keys. Test: "would a translator need to touch this?" — if no, leave it as a plain string.
- Treat `slang`-generated files as generated code: edit the source translations, regenerate, never hand-edit the output.

## Dependencies

No new dependency without approval, except the pre-approved list above. Check Flutter/Dart built-ins and existing deps before suggesting one.

## Performance

- No expensive work or API/DB calls inside `build()`.
- Use lazy builders (`ListView.builder`, etc.) for long/large lists.
- Avoid unnecessary rebuilds: before calling `setState`, wrapping in a `BlocBuilder`/`Consumer`, or writing any function that triggers a rebuild, check it only rebuilds the smallest subtree that actually needs to change — not a parent screen or unrelated siblings.
- Use `const` where it helps; don't chase micro-optimizations that hurt readability without a measured need.

## Generated Code, Navigation, Logging

- Never hand-edit generated code (design tokens, `slang`, build_runner output) — edit the source and regenerate.
- Use the existing centralized router; don't duplicate routes or mix navigation approaches.
- No `print` in production code — use the project's logger. Remove debug code/commented-out code before finishing.

## Scope & Git

Do only what's asked — no unrelated refactors, renames, dependency changes, or architecture changes. Never run `git commit/push/merge/rebase/reset` unless explicitly requested; use Conventional Commits when a commit is asked for.

## Before Finishing

- Implementation matches the approach the user actually approved; any drift was flagged, not hidden.
- Walked the real scenario end-to-end (edge cases, empty/error states) and it's logically consistent — flag anything that isn't, rather than guessing.
- No hardcoded secrets, user-facing strings, or design values where a token/key already exists.
- No unapproved dependency, unnecessary abstraction, or workaround introduced.
- Code formatted, analyzed, no new warnings from this change.
- Project-Specific Rules updated only if a rule genuinely meets the bar in that section.
- Final report is accurate about what changed and what was actually verified — no "production-ready" claims without evidence.
  `

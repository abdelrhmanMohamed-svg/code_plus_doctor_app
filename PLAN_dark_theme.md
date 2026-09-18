# Dark Theme Implementation Plan

## Goal
Add a system-following dark theme to DoctorHunt via a semantic color system, proper `ThemeData`, and theme-aware `style_atoms.dart` — while keeping brand colors unchanged.

## Architecture Overview

```
1. ThemeColors (ThemeExtension)  →  semantic colors that flip between light/dark
2. AppTheme                       →  light + dark ThemeData using ThemeColors
3. app.dart                       →  ThemeMode.system auto-follows device
4. generate_styles.dart           →  base TextStyle reads color from theme
5. ~60 widget files               →  replace AppColors.white/black/grey → context.themeColors.xxx
6. app_colors.dart                →  brand colors stay; semantic colors deprecated
```

---

## Step 1 — Create `ThemeColors` (new file)

**File:** `lib/apps/core/theme/theme_colors.dart`

A `ThemeExtension<ThemeColors>` data class with semantic color roles:

| Role | Light | Dark |
|------|-------|------|
| `background` | `#FFFFFF` | `#121212` |
| `surface` | `#FFFFFF` | `#1C1C1E` |
| `surfaceVariant` | `#FAFCFB` | `#1A1A2E` |
| `onBackground` | `#111111` | `#FFFFFF` |
| `onSurface` | `#111111` | `#E0E0E0` |
| `onSurfaceVariant` | `#7B8490` | `#A0A0A0` |
| `border` | `#E3EAE7` | `#2A2A3C` |
| `borderSoft` | `#E2E5EA` | `#252535` |
| `divider` | `#E6ECEA` | `#2A2A3C` |
| `shadow` | `0x0D000000` | `0x33000000` |
| `overlay` | `0x33000000` | `0x33000000` |
| `overlayLight` | `0x1A000000` | `0x1A000000` |
| `card` | `#FFFFFF` | `#1C1C1E` |
| `inputFill` | `#F5F7F6` | `#1A1A2E` |
| `textSecondary` | `#677294` | `#A0A0A0` |
| `greenPale` | `#D5E6E1` | `#1A2E28` |
| `cyanLight` | `#D8F3FF` | `#1A2E38` |
| `mintLight` | `#EBF9F4` | `#1A2E24` |

Plus `copyWith()`, `lerp()`, and a `BuildContext` extension:
```dart
extension ThemeColorsExtension on BuildContext {
  ThemeColors get themeColors => Theme.of(this).extension<ThemeColors>()!;
}
```

---

## Step 2 — Create `AppTheme` (new file)

**File:** `lib/apps/core/theme/app_theme.dart`

```dart
class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark()  => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colors = brightness == Brightness.light
        ? ThemeColors.light()
        : ThemeColors.dark();
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: AppColors.green,
    );
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: colorScheme,
      extensions: [colors],
      appBarTheme: ...,   // bg: colors.background, fg: colors.onBackground
      cardTheme: ...,     // color: colors.card
      dividerTheme: ...,  // color: colors.divider
    );
  }
}
```

---

## Step 3 — Update `app.dart`

```dart
theme: AppTheme.light(),
darkTheme: AppTheme.dark(),
themeMode: ThemeMode.system,
```

Remove inline `ThemeData(...)` and the `AppColors` import (if only used for theme).

---

## Step 4 — Update `generate_styles.dart`

Change the base `style` getter from:
```dart
color: Color(0xFF1A1A1A),
```
to:
```dart
color: Theme.of(this).extension<ThemeColors>()?.onBackground ?? const Color(0xFF1A1A1A),
```

Add the `ThemeColors` import to the generated file header. Then regenerate via `dart run generate_styles.dart`.

This makes all 100+ generated style combos (`context.bold24Black`, `context.regular14GreyMuted`, etc.) automatically use theme-appropriate text colors.

---

## Step 5 — Refactor widget/screen files (~60 files)

Replace direct `AppColors` references for **semantic** colors with `context.themeColors.xxx`:

| Before | After |
|--------|-------|
| `AppColors.white` (bg) | `context.themeColors.background` |
| `AppColors.white` (card) | `context.themeColors.card` |
| `AppColors.black` (text) | `context.themeColors.onBackground` |
| `AppColors.greyBorder` | `context.themeColors.border` |
| `AppColors.greyLighter` (input bg) | `context.themeColors.inputFill` |
| `AppColors.shadowLight` | `context.themeColors.shadow` |
| `AppColors.grey` (secondary text) | `context.themeColors.textSecondary` |
| `AppColors.greyMuted` | `context.themeColors.onSurfaceVariant` |

**Brand colors stay as `AppColors.*`** — green, red, blue, orange, yellow, purple, and their variants. These don't change in dark mode.

**Overlay colors** (`overlay`, `overlayLight`, `overlayDark`) stay as `AppColors` — they're the same in both themes.

**Scaffold `backgroundColor: AppColors.white`** overrides on individual `Scaffold` widgets should be removed — let the theme handle it.

---

## Step 6 — Annotate `app_colors.dart`

Add comments to `app_colors.dart`:
- Mark semantic colors with `/// Deprecated for direct use — use context.themeColors instead.`
- Keep brand color comments as-is
- Don't remove any colors (backward compat during migration)

---

## Color Usage Rules

- **Use `context.themeColors.xxx`** for: backgrounds, surfaces, text colors, borders, dividers, shadows, cards, input fills, tinted backgrounds (greenPale, cyanLight, etc.)
- **Use `AppColors.xxx`** for: brand/accent colors (green, red, blue, etc.), overlays, and decorative colors that intentionally don't change with theme
- **Use `Colors.transparent`** as-is (framework utility)

---

## File Change Summary

| File | Action |
|------|--------|
| `lib/apps/core/theme/theme_colors.dart` | **NEW** — ThemeExtension + extension on BuildContext |
| `lib/apps/core/theme/app_theme.dart` | **NEW** — AppTheme.light() + AppTheme.dark() |
| `lib/app.dart` | **EDIT** — use AppTheme + ThemeMode.system |
| `lib/generate_styles.dart` | **EDIT** — theme-aware base color |
| `lib/generated/style_atoms.dart` | **REGENERATE** — via `dart run generate_styles.dart` |
| `lib/apps/core/theme/app_colors.dart` | **EDIT** — add deprecation comments on semantic colors |
| ~60 widget/screen files | **EDIT** — replace AppColors semantic refs → context.themeColors |

## Verification

1. `dart format .`
2. `dart analyze` — zero new errors/warnings
3. Visual check: toggle device dark mode, verify backgrounds/text/borders flip correctly, brand colors stay vivid
4. Verify `style_atoms.dart` regenerated without errors

## Limitations

- Dark color palette values are educated defaults — fine-tune after visual review on device
- Some decorative gradients (e.g. profile header) use hardcoded color lists in `LinearGradient` — these may need manual dark variants if they look off
- Image assets (SVGs/PNGs) with baked-in white backgrounds won't auto-adapt — flag for future work if needed

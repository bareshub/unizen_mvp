# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

UniZen is a Flutter productivity app that gamifies university exam preparation. Each exam is assigned a 3D "boss" character; studying damages the boss's health bar, making progress visible through animated 3D models.

**Flutter version**: stable channel `3.44.0` (Dart 3.9.0+)

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run (dev flavor by default)
flutter run

# Run specific flavor
flutter run --target lib/main_dev.dart
flutter run --target lib/main_staging.dart
flutter run --target lib/main_prod.dart

# Analyze / lint
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/environment_config_test.dart

# Generate app icons (after updating icon asset)
dart run flutter_launcher_icons

# Enable native assets (required once per machine for flutter_scene 3D models)
flutter config --enable-native-assets
```

## Architecture

The app follows **MVVM** with **Provider** for dependency injection and state management.

### Layer Structure

```
lib/
├── config/         # Dependency injection (dependencies.dart)
├── data/
│   ├── repositories/  # Abstract interfaces + local/remote implementations
│   └── services/local/  # LocalDataService (in-memory seed data for dev)
├── domain/models/  # Pure Dart models: Exam, Boss, Avatar, StudyTimer, etc.
├── domain/use_cases/  # Placeholder (not yet implemented)
├── routing/        # GoRouter config (router.dart) and route constants (routes.dart)
├── ui/
│   ├── core/       # Shared themes (AppColors, AppTheme, Dimens), localization, reusable widgets
│   └── <feature>/  # Each feature: widgets/ + view_models/ subdirectory
└── utils/          # Result<T> sealed class
```

### Multi-Flavor Entry Points

| File | Env | Providers | Log Level |
|------|-----|-----------|-----------|
| `main_dev.dart` | `.env.dev` | `providersLocal` (in-memory) | ALL |
| `main_staging.dart` | `.env.staging` | `providersLocal` | INFO |
| `main_prod.dart` | `.env.prod` | `providersRemote` (server) | SEVERE |

`main.dart` delegates to `main_dev.dart` by default. The `providersLocal` / `providersRemote` lists are defined in `lib/config/dependencies.dart`.

### Key Patterns

**Result\<T\>** — All repository methods return `Result<T>` (a sealed class with `Ok` / `Error` variants). Use a `switch` statement to handle both cases:
```dart
switch (result) {
  case Ok<List<Exam>>(): // use result.value
  case Error<List<Exam>>(): // use result.error
}
```

**flutter_command** — ViewModels wrap all user actions in `Command` objects (e.g., `loadCommand`, `addExamCommand`). Commands are created once in the ViewModel constructor and exposed as `late final` fields. The global exception handler is set in `main_dev.dart`.

**Repository pattern** — Each data domain (Exam, Boss, Avatar, Auth) has an abstract class and at minimum a `*_local` implementation backed by `LocalDataService`. Remote implementations are stubs awaiting backend integration.

**ChangeNotifier + ValueNotifier** — ViewModels extend `ChangeNotifier`. Individual reactive fields use `ValueNotifier<T>` and are named after what they represent (e.g., `exams`, `state`, `sceneReady`).

### Navigation (GoRouter)

Routes are constants in `lib/routing/routes.dart`. The root route is `/` (timeline/roadmap screen). A `redirect` function in `router.dart` guards all routes behind `AuthRepository.isAuthenticated`.

### 3D Model Workflow (flutter_scene)

Models are `.glb` files processed by a native assets build hook into `.model` files at `build/models/`. Steps to add a new boss:

1. Place the `.glb` at the project root.
2. Run `flutter run` (the hook auto-builds it into `build/models/<name>.model`).
3. Reference `build/models/<name>.model` in `LocalDataService.getBosses()` via `AnimatedScene(modelAssetPath: ...)`.
4. Remove the raw `.glb` from the root once processed.

### Theming

- All colors are in `lib/ui/core/themes/colors.dart` (`AppColors`) — both `lightColorScheme` and `darkColorScheme` are defined there.
- Typography and widget themes are in `lib/ui/core/themes/theme.dart` (`AppTheme`).
- Spacing constants live in `lib/ui/core/themes/dimens.dart`.
- The app responds to the system theme (`ThemeMode.system`).

### Localization

Supported locales: `en`, `it`. String resources are in `lib/ui/core/localization/applocalization.dart`.

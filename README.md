# UniZen

UniZen is a productivity app that turns university study goals into gamified challenges. Users can assign a 3D "boss" to each exam and defeat them through dedicated study sessions. The app combines focus-enhancing tools with game mechanics to make studying more engaging and rewarding.

## 🧩 Features

- Add an exam and assign it a 3D boss
- Start, pause, and track study sessions
- Visualize progress through boss animations
- Designed for university students

## 🚀 Getting Started

### Requirements

- Flutter (latest stable)
- Dart SDK
- CMake (required for flutter_scene model building)

> Note: The flutter_scene importer will automatically build itself using CMake when invoked. So be sure to install [CMake](https://cmake.org/download/).

### Clone & Run

```bash
git clone https://github.com/bareshub/unizen.git
cd unizen
flutter pub get
flutter config --enable-native-assets
flutter run
```

## 🧱 3D Model Integration

I use the `flutter_scene` package to render interactive 3D bosses on the homepage.

### Importing a .glb Boss Model

To import a new .glb model:

1. Add the `.glb` file to the project root
2. Run the build hook (through `flutter config --enable-native-assets` and `flutter run`)
3. The processed model will be generated at `build/models/foo.model`
4. After the build is complete, the original `.glb` can be removed from the root folder

> This system keeps the final app clean from raw assets while enabling fast prototyping with new models.

## 🧠 Architecture

The app follows the MVVM pattern. Each UI feature (e.g., homepage, model viewer) is organized into:

- `widgets/` – reusable widgets
- `view_models/` – state management logic

## 📱 Themes

- Light and dark modes are supported
- ColorScheme is centralized in `AppColors`
- Typography styles defined in `AppTheme`
- Responsive to system-level theme changes

## 🛠 Tech Stack

- Flutter + Dart
- `flutter_scene` for 3D
- MVVM Architecture
- GitHub Actions (CI/CD pipeline)

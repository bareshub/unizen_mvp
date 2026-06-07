# UniZen

UniZen is a productivity app that turns university study goals into gamified challenges. Users can assign a 3D "boss" to each exam and defeat them through dedicated study sessions. The app combines focus-enhancing tools with game mechanics to make studying more engaging and rewarding.

## 🧩 Features

- Add an exam and assign it a 3D boss
- Start, pause, and track study sessions
- Visualize progress through boss animations
- Designed for university students

## 🚀 Getting Started

### Requirements

- Flutter stable channel `3.44.0` (Dart 3.9.0+)

### Clone & Run

```bash
git clone https://github.com/bareshub/unizen.git
cd unizen
flutter pub get
flutter run
```

### Running on a Specific Device

```bash
# List available emulators
flutter emulators

# Launch the iOS simulator
flutter emulators --launch apple_ios_simulator

# List connected devices (to find your device ID)
flutter devices

# Run in profile mode on a physical device (replace device ID with yours)
flutter run -d 00008130-00114D1E3E38001C --profile
```

## 🧱 3D Model Integration

I use the `flutter_scene` package to render interactive 3D bosses on the homepage. All `.glb` models have been pre-compiled to `.model` files and are bundled with the app.

### Adding a New .glb Boss Model

To add and compile a new 3D model:

1. Add the `.glb` file to the project root
2. Enable native assets for this one-time build:

   ```bash
   flutter config --enable-native-assets
   flutter run
   ```

3. The processed model will be auto-generated at `build/models/foo.model`
4. After the build completes, remove the original `.glb` from the project root
5. The new `.model` file will be included in future builds automatically

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

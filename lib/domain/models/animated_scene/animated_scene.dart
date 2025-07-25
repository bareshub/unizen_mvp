import 'package:unizen/domain/models/static_scene/static_scene.dart';

class AnimatedScene extends StaticScene {
  final Animation defaultAnimation;
  final double fps;

  const AnimatedScene({
    required super.modelAssetPath,
    super.environmentIntensity,
    super.environmentExposure,
    super.cameraDistance,
    this.defaultAnimation = Animation.idle,
    this.fps = 60.0,
  });
}

enum Animation { idle, walk, attack, death }

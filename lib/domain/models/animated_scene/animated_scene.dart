import 'package:unizen/domain/models/static_scene/static_scene.dart';

class AnimatedScene extends StaticScene {
  const AnimatedScene({
    required super.modelAssetPath,
    super.environmentIntensity,
    super.environmentExposure,
    super.cameraDistance,
    this.defaultAnimation = Animation.idle,
    this.fps = 24.0,
    this.flip = false,
  });

  final Animation defaultAnimation;
  final double fps;
  final bool flip;
}

enum Animation { idle, walk, attack, death }

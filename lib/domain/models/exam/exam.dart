import '../animated_scene/animated_scene.dart';

class Exam {
  const Exam({
    required this.name,
    required this.maxHealth,
    required this.health,
    required this.animatedScene,
  });

  final String name;
  final int maxHealth;
  final int health;

  final AnimatedScene animatedScene;
}

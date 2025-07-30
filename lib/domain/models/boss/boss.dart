import 'package:uuid/uuid.dart';

import '../animated_scene/animated_scene.dart';

class Boss {
  Boss({required this.animatedScene, required this.ects}) : id = Uuid();

  final Uuid id;
  final AnimatedScene animatedScene;
  final double ects;
}

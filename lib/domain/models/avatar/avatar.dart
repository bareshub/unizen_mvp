import 'package:uuid/uuid.dart';

import '../animated_scene/animated_scene.dart';

class Avatar {
  Avatar({required this.animatedScene}) : id = Uuid();

  final Uuid id;
  final AnimatedScene animatedScene;
}

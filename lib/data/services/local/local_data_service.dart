import '../../../domain/models/animated_scene/animated_scene.dart';
import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';

class LocalDataService {
  List<Exam> getExams() {
    return [
      // Exam(
      //   name: 'MACHINE LEARNING',
      //   maxHealth: 5000,
      //   health: 2780,
      //   boss: getBosses().elementAt(4),
      // ),
      Exam(
        name: 'AUTOMATION AND TECHNOLOGY',
        maxHealth: 5000,
        health: 2780,
        boss: getBosses().elementAt(5),
      ),
      Exam(
        name: 'PHYSICS',
        maxHealth: 5000,
        health: 4878,
        boss: getBosses().elementAt(1),
      ),
      Exam(
        name: 'COMPUTER SCIENCE',
        maxHealth: 5000,
        health: 1280,
        boss: getBosses().elementAt(0),
      ),
      Exam(
        name: 'ARTIFICIAL INTELLIGENCE',
        maxHealth: 5000,
        health: 2780,
        boss: getBosses().elementAt(6),
      ),
      // Exam(
      //   name: 'AUTOMATION',
      //   maxHealth: 5000,
      //   health: 2780,
      //   boss: getBosses().elementAt(3),
      // ),
      // Exam(
      //   name: 'AI ENTREPRENEURSHIP',
      //   maxHealth: 5000,
      //   health: 2780,
      //   boss: getBosses().elementAt(2),
      // ),
    ];
  }

  List<Boss> getBosses() {
    return [
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvwoman.model',
          cameraDistance: 24,
        ),
        ects: 3,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/cameraman_supreme_god.model',
          cameraDistance: 28,
        ),
        ects: 4,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/skibidi_yisus.model',
          cameraDistance: 22,
        ),
        ects: 5,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tv_man_supreme.model',
          cameraDistance: 16,
        ),
        ects: 6,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_multiple_supreme.model',
          cameraDistance: 20,
        ),
        ects: 7,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_multiple.model',
          cameraDistance: 24,
        ),
        ects: 8,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_supreme.model',
          cameraDistance: 34,
        ),
        ects: 9,
      ),
    ];
  }
}

Boss getAvatar() {
  return Boss(
    animatedScene: AnimatedScene(
      modelAssetPath: 'build/models/minecraft_sprunki_oren_after_blender.model',
      defaultAnimation: Animation.walk,
      cameraDistance: 10,
      showBack: true,
    ),
    ects: 0,
  );
}

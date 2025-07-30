import '../../../domain/models/animated_scene/animated_scene.dart';
import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';

class LocalDataService {
  List<Exam> getExams() {
    return [
      Exam(
        name: 'MACHINE LEARNING',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvwoman.model',
          cameraDistance: 28,
        ),
      ),
      Exam(
        name: 'AUTOMATION',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/cameraman_supreme_god.model',
          cameraDistance: 36,
        ),
      ),
      Exam(
        name: 'PHYSICS',
        maxHealth: 5000,
        health: 4878,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/skibidi_yisus.model',
          cameraDistance: 28,
        ),
      ),
      Exam(
        name: 'COMPUTER SCIENCE',
        maxHealth: 5000,
        health: 1280,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tv_man_supreme.model',
          cameraDistance: 16,
        ),
      ),
      Exam(
        name: 'ARTIFICIAL INTELLIGENCE',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_multiple_supreme.model',
          cameraDistance: 20,
        ),
      ),
      Exam(
        name: 'AUTOMATION',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_multiple.model',
          cameraDistance: 32,
        ),
      ),
      Exam(
        name: 'AI ENTREPRENEURSHIP',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_supreme.model',
          cameraDistance: 44,
        ),
      ),
    ];
  }

  List<Boss> getBosses() {
    return [
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvwoman.model',
          cameraDistance: 28,
        ),
        ects: 3,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/cameraman_supreme_god.model',
          cameraDistance: 36,
        ),
        ects: 4,
      ),
      // Boss(
      //   animatedScene: AnimatedScene(
      //     modelAssetPath: 'build/models/skibidi_yisus.model',
      //     cameraDistance: 28,
      //   ),
      //   ects: 5,
      // ),
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
          cameraDistance: 32,
        ),
        ects: 8,
      ),
      Boss(
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/tvman_supreme.model',
          cameraDistance: 44,
        ),
        ects: 9,
      ),
    ];
  }
}

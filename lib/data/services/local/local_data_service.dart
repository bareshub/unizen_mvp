import '../../../domain/models/animated_scene/animated_scene.dart';
import '../../../domain/models/exam/exam.dart';

class LocalDataService {
  List<Exam> getExams() {
    return [
      Exam(
        id: 1,
        name: 'AUTOMATION',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/zombie_after_blender.model',
        ),
      ),
      Exam(
        id: 2,
        name: 'PHYSICS',
        maxHealth: 5000,
        health: 4878,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/toilet_after_blender.model',
        ),
      ),
      Exam(
        id: 3,
        name: 'COMPUTER SCIENCE',
        maxHealth: 5000,
        health: 1280,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/zombie_after_blender.model',
        ),
      ),
      Exam(
        id: 4,
        name: 'AUTOMATION',
        maxHealth: 5000,
        health: 2780,
        animatedScene: AnimatedScene(
          modelAssetPath: 'build/models/zombie_after_blender.model',
        ),
      ),
    ];
  }
}

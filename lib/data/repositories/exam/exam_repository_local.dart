import 'package:uuid/uuid.dart';

import '../../../data/services/local/local_data_service.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../utils/result.dart';
import 'exam_repository.dart';

/// Local implementation of [ExamRepository]
class ExamRepositoryLocal implements ExamRepository {
  bool _isInitialized = false;

  final _exams = List<Exam>.empty(growable: true);
  final LocalDataService _localDataService;

  ExamRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  @override
  Future<Result<Uuid>> create(Exam exam) async {
    _exams.insert(0, exam);
    return Result.ok(exam.id);
  }

  @override
  Future<Result<void>> delete(Uuid id) async {
    _exams.removeWhere((x) => x.id == id);
    return Result.ok(null);
  }

  @override
  Future<Result<List<Exam>>> getExamsList() async {
    if (!_isInitialized) {
      _createDefaultExamsList();
      _isInitialized = true;
    }
    return Result.ok(_exams);
  }

  Future<void> _createDefaultExamsList() async {
    _exams.addAll(_localDataService.getExams());
  }

  @override
  Future<Result<Exam>> update(
    Uuid id, {
    String? name,
    int? maxHealth,
    int? health,
  }) async {
    final examToUpdate = _exams.singleWhere((x) => x.id == id);

    if (name != null) examToUpdate.name = name;
    if (maxHealth != null) examToUpdate.maxHealth = maxHealth;
    if (health != null) examToUpdate.health = health;

    return Result.ok(examToUpdate);
  }
}

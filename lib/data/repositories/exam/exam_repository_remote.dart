import 'package:unizen/domain/models/exam/exam.dart';

import 'package:unizen/utils/result.dart';
import 'package:uuid/uuid.dart';

import 'exam_repository.dart';

/// Remote implementation for [ExamRepository]
class ExamRepositoryRemote implements ExamRepository {
  @override
  Future<Result<Uuid>> create(Exam exam) {
    // TODO: implement createExam
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> delete(Uuid id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Exam>>> getExamsList() {
    // TODO: implement getExamsList
    throw UnimplementedError();
  }

  @override
  Future<Result<Exam>> update(
    Uuid id, {
    String? name,
    int? maxHealth,
    int? health,
  }) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

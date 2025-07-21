import '../../../domain/models/exam/exam.dart';
import '../../../utils/result.dart';

/// Data source for exams
abstract class ExamRepository {
  /// Creates a new [Exam]
  Future<Result<int>> createExam(Exam exam);

  /// Returns the list of [Exam] for the current user
  Future<Result<List<Exam>>> getExamsList();

  /// Update an existing [Exam]
  Future<Result<Exam>> update(
    int id, {
    String? name,
    int? maxHealth,
    int? health,
  });

  /// Delete an [Exam]
  Future<Result<void>> delete(int id);
}

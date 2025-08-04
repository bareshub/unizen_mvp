import 'package:uuid/uuid.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../utils/result.dart';

/// Data source for exams
abstract class ExamRepository {
  /// Creates a new [Exam]
  /// Returns the ID given to the new [Exam]
  Future<Result<Uuid>> create(Exam exam);

  /// Delete an [Exam]
  Future<Result<void>> delete(Uuid id);

  /// Returns the list of [Exam] for the current user
  Future<Result<List<Exam>>> getExamsList();

  /// Update an existing [Exam]
  Future<Result<Exam>> update(
    Uuid id, {
    String? name,
    int? maxHealth,
    int? health,
  });
}

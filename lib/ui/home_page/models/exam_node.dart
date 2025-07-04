import './exam.dart';

class ExamNode {
  final Exam exam;
  final ExamNode? previous;
  final ExamNode? next;

  ExamNode({required this.exam, this.previous, this.next});
}

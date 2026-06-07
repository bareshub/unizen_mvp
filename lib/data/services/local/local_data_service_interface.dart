import '../../../domain/models/avatar/avatar.dart';
import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';

abstract interface class LocalDataService {
  List<Exam> getExams();
  List<Boss> getBosses();
  Avatar getAvatar();
}

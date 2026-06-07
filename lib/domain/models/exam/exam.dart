import 'package:unizen/domain/models/exam/grade.dart';
import 'package:uuid/uuid.dart';

import '../boss/boss.dart';

class Exam {
  static const double hoursPerEcts = 12.5;
  static const int minutesPerHour = 60;

  Exam({
    required this.boss,
    this.grade,
    required String name,
    int? maxHealth,
    int? health,
    rotationX = 0.0,
  }) : assert(grade == null || health == 0),
       id = Uuid(),
       _name = name,
       _maxHealth =
           maxHealth ?? (boss.ects * hoursPerEcts * minutesPerHour).floor(),
       _health = health ?? (boss.ects * hoursPerEcts * minutesPerHour).floor(),
       _rotationX = rotationX;

  final Uuid id;
  final Boss boss;
  Grade? grade;

  String _name;
  int _maxHealth;
  int _health;
  double _rotationX;

  String get name => _name;
  set name(String value) => _name = value.isNotEmpty ? value : _name;

  int get maxHealth => _maxHealth;
  set maxHealth(int value) => _maxHealth = value.isNegative ? 0 : value;

  int get health => _health;
  set health(int value) => _health = value.isNegative ? 0 : value;

  double get rotationX => _rotationX;

  void rotate(double rotationX) => _rotationX = rotationX;
}

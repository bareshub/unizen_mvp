import 'package:uuid/uuid.dart';

import '../../../domain/models/boss/boss.dart';

class Exam {
  static const double hoursPerEcts = 12.5;
  static const int minutesPerHour = 60;

  Exam({
    required this.boss,
    required String name,
    int? maxHealth,
    int? health,
    rotationX = 0.0,
  }) : id = Uuid(),
       _name = name,
       _maxHealth =
           maxHealth ?? (boss.ects * hoursPerEcts * minutesPerHour).floor(),
       _health = health ?? (boss.ects * hoursPerEcts * minutesPerHour).floor(),
       _rotationX = rotationX;

  final Uuid id;
  final Boss boss;

  String _name;
  int _maxHealth;
  int _health;
  double _rotationX;

  String get name => _name;
  set name(String value) => _name = value.isNotEmpty ? value : _name;

  int get maxHealth => _maxHealth;
  set maxHealth(int value) => _maxHealth = value.isNegative ? 0 : _maxHealth;

  int get health => _health;
  set health(int value) => _health = value.isNegative ? 0 : health;

  double get rotationX => _rotationX;

  void rotate(double rotationX) => _rotationX = rotationX;
}

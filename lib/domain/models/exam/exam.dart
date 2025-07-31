import 'package:uuid/uuid.dart';

import '../../../domain/models/boss/boss.dart';

class Exam {
  Exam({
    required this.boss,
    required String name,
    required int maxHealth,
    required int health,
  }) : id = Uuid(),
       _name = name,
       _maxHealth = maxHealth,
       _health = health;

  final Uuid id;
  final Boss boss;

  String _name;
  int _maxHealth;
  int _health;

  String get name => _name;
  set name(String value) => _name = value.isNotEmpty ? value : _name;

  int get maxHealth => _maxHealth;
  set maxHealth(int value) => _maxHealth = value.isNegative ? 0 : _maxHealth;

  int get health => _health;
  set health(int value) => _health = value.isNegative ? 0 : health;
}

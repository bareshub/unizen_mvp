import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class RotationViewModel extends ChangeNotifier {
  late final Command<double, void> rotateCommand;

  final ValueNotifier<double> rotationX = ValueNotifier(0);

  RotationViewModel() {
    rotateCommand = Command.createSyncNoResult(_rotate);
  }

  void _rotate(double rotation) {
    rotationX.value = rotation;
  }
}

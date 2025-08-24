import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class RoadmapProgressViewModel extends ChangeNotifier {
  RoadmapProgressViewModel() {
    setCurrentPointCommand = Command.createSyncNoResult(setCurrentPoint);
  }

  late final Command<Offset, void> setCurrentPointCommand;

  Offset? _currentPoint;
  Offset? get currentPoint => _currentPoint;

  void setCurrentPoint(Offset? point) {
    if (_currentPoint != point) {
      _currentPoint = point;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _currentPoint = null;
    super.dispose();
  }
}

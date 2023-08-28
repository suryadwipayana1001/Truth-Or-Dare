import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _state = false;
  double _progress = 0.0;
  bool get state => _state;
  double get progress => _progress;

  set setProgress(val) {
    _progress = val;
    notifyListeners();
  }

  hide() {
    _state = false;
    notifyListeners();
  }

  show() {
    _state = true;
    notifyListeners();
  }
}

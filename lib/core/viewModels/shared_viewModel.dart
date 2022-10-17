import 'package:flutter/material.dart';

// a base model from which all change notifier classes will inherit and implement its methods
// more specifically, the state property will be used alot to handle state
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  bool _showFab = true;

  ViewState get state => _state;
  bool get showFab => _showFab;

  void changeFabVisibility() {
    _showFab = !_showFab;
    notifyListeners();
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
} // viewstate.dart/// Represents the state of the view

enum ViewState { idle, busy }

import 'package:flutter/material.dart';

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

import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  bool loading = false;

  _setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> runWithLoading(Future<dynamic> Function() action) async {
    _setLoading(true);
    try {
      await action();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }
}

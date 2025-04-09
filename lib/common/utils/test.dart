import 'package:arch/common/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockResult<T> {
  final List<Result<Exception, T>> _results = [];
  Result<Exception, T>? _defaultValue;
  int _callCount = 0;

  void returnOnce(Result<Exception, T> result) {
    _results.add(result);
  }

  void returnAll(List<Result<Exception, T>> results) {
    _results.clear();
    _results.addAll(results);
  }

  void setDefault(Result<Exception, T> result) {
    _defaultValue = result;
  }

  void reset() {
    _results.clear();
    _defaultValue = null;
    _callCount = 0;
  }

  Result<Exception, T> next() {
    if (_callCount < _results.length) {
      return _results[_callCount++];
    }
    if (_defaultValue != null) {
      _callCount++;
      return _defaultValue!;
    }
    throw StateError('No more mock results and no default set');
  }
}

extension OnWidgetTester on WidgetTester {
  Future<void> pumpWidgetMaterial(Widget widget) async {
    await pumpWidget(MaterialApp(home: widget));
    await pumpAndSettle();
  }

  Finder findByType<T>() {
    return find.byType(T);
  }

  Finder findByKey(String key) {
    return find.byKey(Key(key));
  }

  Finder findText(String text) {
    return find.text(text);
  }

  Future<void> scrollDown() async {
    await drag(find.byType(ListView), const Offset(0, -100));
    await pumpAndSettle();
  }
}

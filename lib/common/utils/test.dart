import 'package:arch/common/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockResult<T> {
  final List<Result<Exception, T>> _results = [];
  Result<Exception, T>? _defaultValue;
  int _callCount = 0;
  int _totalItens = 0;

  MockResult<T> returnOnce(Result<Exception, T> result) {
    _results.add(result);
    _totalItens++;
    return this;
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
    if (_defaultValue != null) {
      return _defaultValue!;
    }

    if (_callCount < _totalItens) {
      _callCount++;
      return _results.removeAt(0);
    }

    throw StateError('No more mock results and no default set');
  }
}

extension OnWidgetTester on WidgetTester {
  Future<void> pumpWidgetMaterial(Widget widget) async {
    await pumpWidget(const SizedBox.shrink());
    await pumpAndSettle();

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

import 'package:arch/common/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockResult<T> {
  final List<Result<T>> _results = [];
  Result<T>? _defaultValue;
  int _callCount = 0;
  int _totalItens = 0;

  MockResult<T> returnOnce(Result<T> result) {
    _results.add(result);
    _totalItens++;
    return this;
  }

  void returnAll(List<Result<T>> results) {
    _results.clear();
    _results.addAll(results);
  }

  void setDefault(Result<T> result) {
    _defaultValue = result;
  }

  void reset() {
    _results.clear();
    _defaultValue = null;
    _callCount = 0;
  }

  Result<T> next() {
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

class MockMethodHandler {
  final Map<String, List<dynamic Function()>> _responses = {};
  final Map<String, bool Function(dynamic params)> _paramsValidator = {};

  void returnOnce(
    String methodName,
    dynamic Function() response, {
    bool Function(dynamic params)? validator,
  }) {
    _responses.putIfAbsent(methodName, () => []).add(response);
    if (validator != null) {
      _paramsValidator[methodName] = validator;
    }
  }

  void returnAlways(String methodName, dynamic Function() response) {
    _responses[methodName] = [response];
  }

  T call<T>(String methodName, [dynamic params]) {
    final responses = _responses[methodName];
    if (responses == null || responses.isEmpty) {
      throw Exception("No mock response configured for method '$methodName'");
    }

    final response = responses.removeAt(0);
    if (responses.isNotEmpty && response == responses.first) {
      responses.add(response);
    }

    if (_paramsValidator.containsKey(methodName)) {
      final validator = _paramsValidator[methodName];
      if (validator != null) {
        bool r = validator(params[0]);
        if (!r) {
          throw Exception("Invalid parameters for method '$methodName' with params: $params");
        }
      }
    }

    return response() as T;
  }
}

abstract class GenericMockService {
  final mockHandler = MockMethodHandler();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final name = _getMethodName(invocation.memberName);
    return mockHandler.call(name, invocation.positionalArguments);
  }

  String _getMethodName(Symbol symbol) {
    return symbol.toString().replaceAll("Symbol(\"", "").replaceAll("\")", "");
  }
}

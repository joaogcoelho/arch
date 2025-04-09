import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Future<void> showToastError(BuildContext context, String message) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  Future<void> showToastSuccess(BuildContext context, String message) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }
}

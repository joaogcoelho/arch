import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  final String name;
  const CardProduct({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}

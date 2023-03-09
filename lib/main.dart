import 'package:flutter/material.dart';

import 'package:test_task_solid/screen/home.dart';

void main() => runApp(const Main());

/// Root of my app
class Main extends StatelessWidget {
  /// Default constructor
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

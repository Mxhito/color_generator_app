import 'dart:math';

import 'package:flutter/material.dart';

/// Home screen
class Home extends StatefulWidget {
  /// Default constructors
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solid Software'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            const _alpha = 255;
            const _rgbLimiter = 256;
            _backgroundColor = Color.fromARGB(
              _alpha,
              Random().nextInt(_rgbLimiter),
              Random().nextInt(_rgbLimiter),
              Random().nextInt(_rgbLimiter),
            );
          });
        },
        child: SafeArea(
          child: ColoredBox(
            color: _backgroundColor,
            child: const Center(
              child: Text(
                'Hey there!',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

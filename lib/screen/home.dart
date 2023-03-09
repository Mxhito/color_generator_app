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
  final List<ColorHistory> _colorHistory = [];

  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solid Software'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ..._colorHistory.map((history) {
              return ListTile(
                title: history.getPreview(),
              );
            }).toList(),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _backgroundColor = _generateColor();
            String _hexCode =
                _backgroundColor.value.toRadixString(16).padLeft(8, '0');
            _colorHistory.add(
              ColorHistory(_backgroundColor, _hexCode),
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

/// Model for color history
class ColorHistory {
  /// Color
  final Color color;

  /// HEX of color
  final String hexCode;

  /// Size of container
  final double size = 40;

  /// Border radius of container
  final double bordeRadius = 10;

  /// Model constructor
  ColorHistory(this.color, this.hexCode);

  /// Widget for display colors
  Widget getPreview() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(bordeRadius),
      ),
      child: Center(
        child: Text(
          hexCode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color _generateColor() {
  final random = Random();
  const _alpha = 255;
  const _rgbLimiter = 256;

  return Color.fromARGB(
    _alpha,
    random.nextInt(_rgbLimiter),
    random.nextInt(_rgbLimiter),
    random.nextInt(_rgbLimiter),
  );
}

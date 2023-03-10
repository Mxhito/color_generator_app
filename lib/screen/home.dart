import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _hexCode = '';

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
                title: history.getPreview(context),
              );
            }).toList(),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _backgroundColor = _generateColor();
            const hexadecimal = 16;
            const _colorHexLenght = 8;
            _hexCode = _backgroundColor.value
                .toRadixString(hexadecimal)
                .padLeft(_colorHexLenght, '0');
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
  final Color _color;

  /// HEX of color
  final String _hexCode;

  /// Size of container
  final double _size = 40;

  /// Border radius of container
  final double _bordeRadius = 10;

  /// Model constructor
  ColorHistory(this._color, this._hexCode);

  /// Widget for display colors
  Widget getPreview(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _copyToClipboard(_hexCode, context);
        Navigator.pop(context);
      },
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(_bordeRadius),
        ),
        child: Center(
          child: Text(
            _hexCode,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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

void _copyToClipboard(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied to clipboard'),
    ),
  );
}

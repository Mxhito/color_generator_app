import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        actions: [
          GestureDetector(
            onTap: _launchUrl,
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.link),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: _colorHistory
              .map(
                (color) => ListTile(
                  title: color.getPreview(context),
                ),
              )
              .toList(),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _backgroundColor = _generateColor();
            const hexadecimal = 16;
            const _colorHexLength = 8;
            _hexCode = _backgroundColor.value
                .toRadixString(hexadecimal)
                .padLeft(_colorHexLength, '0');
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

  /// Model constructor
  const ColorHistory(this.color, this.hexCode);

  /// Widget for display colors
  Widget getPreview(BuildContext context) {
    const double sizeOfPreview = 40;
    const double borderRadiusOfPreview = 10;

    return GestureDetector(
      onTap: () {
        _copyToClipboard(hexCode, context);
        Navigator.pop(context);
      },
      child: Container(
        width: sizeOfPreview,
        height: sizeOfPreview,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadiusOfPreview),
        ),
        child: Center(
          child: Text(
            hexCode,
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

Future<void> _launchUrl() async {
  final Uri _url = Uri.parse('https://github.com/Mxhito/test_task_solid');

  if (!await canLaunchUrlString(_url.toString())) {
    throw Exception('Could not launch $_url');
  }
  await launchUrlString(_url.toString());
}

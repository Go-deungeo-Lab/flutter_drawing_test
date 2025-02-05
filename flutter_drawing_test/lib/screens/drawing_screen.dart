import 'package:flutter/material.dart';
import '../widgets/drawing_canvas.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey<DrawingCanvasState> _canvasKey = GlobalKey();
  double strokeWidth = 2.0; // 기본 굵기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Test'),
        actions: [
          // 펜 굵기 선택 버튼
          IconButton(
            icon: const Icon(Icons.line_weight),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('펜 굵기 선택'),
                  content: StatefulBuilder(
                    builder: (context, setState) => Slider(
                      value: strokeWidth,
                      min: 1,
                      max: 10,
                      onChanged: (value) {
                        setState(() {
                          strokeWidth = value;
                        });
                        _canvasKey.currentState?.updateStrokeWidth(value);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          // 지우기 버튼
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _canvasKey.currentState?.clear();
            },
          ),
        ],
      ),
      body: DrawingCanvas(key: _canvasKey),
    );
  }
}
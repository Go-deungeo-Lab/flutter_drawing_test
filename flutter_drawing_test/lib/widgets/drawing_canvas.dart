import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/drawing_point.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({Key? key}) : super(key: key);

  @override
  DrawingCanvasState createState() => DrawingCanvasState();
}

class DrawingCanvasState extends State<DrawingCanvas> {
  List<DrawingPoint?> drawingPoints = [];
  double strokeWidth = 2.0;

  void updateStrokeWidth(double width) {
    setState(() {
      strokeWidth = width;
    });
  }

  void clear() {
    setState(() {
      drawingPoints.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          drawingPoints.add(
            DrawingPoint(
              offset: event.localPosition,
              paint: Paint()
                ..color = Colors.black
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });
      },
      onPointerMove: (PointerMoveEvent event) {
        setState(() {
          drawingPoints.add(
            DrawingPoint(
              offset: event.localPosition,
              paint: Paint()
                ..color = Colors.black
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          drawingPoints.add(null);
        });
      },
      child: CustomPaint(
        painter: _DrawingPainter(drawingPoints),
        size: Size.infinite,
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(
          drawingPoints[i]!.offset,
          drawingPoints[i + 1]!.offset,
          drawingPoints[i]!.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
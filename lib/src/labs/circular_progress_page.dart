import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  CircularProgressPage({Key key}) : super(key: key);

  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  double currentPercent = 0;

  double targetPercent = 0.0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    controller.addListener(() {
      setState(() {
        currentPercent =
            lerpDouble(currentPercent, targetPercent, controller.value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
        ),
        backgroundColor: Colors.pink,
        onPressed: () {
          setState(() {
            currentPercent = targetPercent;
            if (targetPercent >= 100) {
              currentPercent = 0.0;
              targetPercent = 0.0;
            }
            targetPercent += 10;
          });

          controller.forward(from: 0.0);
        },
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 300,
          height: 300,
          //color: Colors.red,
          child: CustomPaint(
            painter: _RadialProgressPainter(percent: currentPercent),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _RadialProgressPainter extends CustomPainter {
  final double percent;

  _RadialProgressPainter({@required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);
    _paintCircle(canvas, size, center, radius);
    _paintArc(canvas, size, center, radius);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _paintCircle(Canvas canvas, Size size, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);
  }

  _paintArc(Canvas canvas, Size size, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final arcAngle = 2 * pi * (percent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint);
  }
}

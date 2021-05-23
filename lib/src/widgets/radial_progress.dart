import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percent;
  final Color progressBarColor;
  final double progressBarSize;
  final Color lineColor;
  final double lineSize;

  RadialProgress(
      {@required this.percent,
      this.progressBarColor = Colors.blue,
      this.lineColor = Colors.grey,
      this.lineSize = 4,
      this.progressBarSize = 10});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController radialAnimController;

  double currentPercent;

  @override
  void initState() {
    currentPercent = widget.percent;
    radialAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    radialAnimController.forward(from: 0.0);

    final diff = widget.percent - currentPercent;
    currentPercent = widget.percent;

    return AnimatedBuilder(
      animation: radialAnimController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _RadialProgressPainter(
                percent: (widget.percent - diff) +
                    (diff * radialAnimController.value),
                progressBarColor: widget.progressBarColor,
                lineColor: widget.lineColor,
                lineSize: widget.lineSize,
                progressBarSize: widget.progressBarSize),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    radialAnimController.dispose();
    super.dispose();
  }
}

class _RadialProgressPainter extends CustomPainter {
  final double percent;
  final Color progressBarColor;
  final Color lineColor;
  final double lineSize;
  final double progressBarSize;

  _RadialProgressPainter(
      {@required this.percent,
      @required this.progressBarColor,
      @required this.lineColor,
      @required this.lineSize,
      @required this.progressBarSize});

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
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineSize;
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);
  }

  _paintArc(Canvas canvas, Size size, Offset center, double radius) {
    final paint = Paint()
      ..color = progressBarColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressBarSize;

    final arcAngle = 2 * pi * (percent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint);
  }
}

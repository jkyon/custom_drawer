import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SquereAnimated(),
      ),
    );
  }
}

class SquereAnimated extends StatefulWidget {
  const SquereAnimated({
    Key key,
  }) : super(key: key);

  @override
  _SquereAnimatedState createState() => _SquereAnimatedState();
}

class _SquereAnimatedState extends State<SquereAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> moveRight;
  Animation<double> scale;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));

    rotation = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    opacity = Tween(begin: 1.0, end: 0.1).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.75, 1.0)));

    moveRight = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    scale = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      child: _Rectangle(),
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(moveRight.value, 0),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value,
                child: Transform.scale(scale: scale.value, child: child),
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class _Rectangle extends StatelessWidget {
  const _Rectangle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.redAccent[700]),
      child: Center(
          child: Text(
        "Gooooool",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}

import 'package:flutter/material.dart';

enum Direction { left, right, up, down }

class AnimatedSquarePage extends StatelessWidget {
  const AnimatedSquarePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _AnimatedSquare()),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    Key key,
  }) : super(key: key);

  @override
  __AnimatedSquareState createState() => __AnimatedSquareState();
}

class __AnimatedSquareState extends State<_AnimatedSquare>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> moveRight;

  List<Direction> sequence = [Direction.up, Direction.left, Direction.down];

  int _sequenceIndex = 0;

  Direction _nextStep = Direction.right;

  double pivotPoint = 0.0;

  double currentPoint = 0.0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    moveRight = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        print("COMPLETED");
        print(animationController.upperBound);
        if (_sequenceIndex == 3) _sequenceIndex = 0;

        _nextStep = sequence[_sequenceIndex];
        pivotPoint = currentPoint;
        _sequenceIndex++;
        animationController.value = 0.0;
        animationController.forward();
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
        print(animationController.status);
        print(animationController.upperBound);
        return Transform.translate(
          offset: _move(),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Offset _move() {
    switch (_nextStep) {
      case Direction.right:
        currentPoint = moveRight.value;
        return Offset(currentPoint, pivotPoint);
        break;
      case Direction.up:
        currentPoint = (-moveRight.value);
        return Offset(pivotPoint, currentPoint);
        break;
      case Direction.left:
        currentPoint = (-moveRight.value);
        return Offset(currentPoint, pivotPoint);
        break;
      case Direction.down:
        currentPoint = moveRight.value;
        return Offset(pivotPoint, currentPoint);
        break;
    }
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

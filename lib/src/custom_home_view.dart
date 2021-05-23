import 'package:flutter/material.dart';

class CustomHomeView extends StatefulWidget {
  final Widget mainView;

  final Widget drawer;

  CustomHomeView({Key key, this.mainView, this.drawer}) : super(key: key);

  static _CustomHomeViewState of(BuildContext context) =>
      context.findAncestorStateOfType<_CustomHomeViewState>();

  @override
  _CustomHomeViewState createState() => _CustomHomeViewState();
}

class _CustomHomeViewState extends State<CustomHomeView>
    with SingleTickerProviderStateMixin {

  AnimationController animationController;

  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  bool _canBeDragged = false;
 

  @override
  void initState() {
    super.initState();
    this.animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void close() => animationController.reverse();

  void open() => animationController.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: <Widget>[
              widget.drawer,
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.mainView,
              )
            ],
          );
        },
      ),
    );
  }

   void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = this.animationController.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
        close();
    } else {
        open();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RotatingDrawerBasicExample extends StatefulWidget {
  @override
  _RotatingDrawerBasicExampleState createState() =>
      _RotatingDrawerBasicExampleState();
}

class _RotatingDrawerBasicExampleState extends State<RotatingDrawerBasicExample>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _canBeDragged = true;
  int minDragStartEdge = 0;
  int maxDragStartEdge = 1;

  final double maxSlide = 225;

  var myDrawer = Container(
    color: Colors.blue,
  );

  var myChild = Container(
    color: Colors.greenAccent,
  );

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  void onDragStart(DragStartDetails details) {
    /// To drag manually, we start sliding our finger

    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;

    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dy > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    /// If we are dragging manually,
    /// We have to update our animation controller
    /// Whenever the animation controller value changes,
    /// The widgets inside AnimatedBuilder() rebuild.
    /// Even though we are not calling setState() we are rebuilding UI

    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  void closeDrawer() {}

  void openDrawer() {}

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: <Widget>[
              myDrawer,
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: myChild,
              )
            ],
          );
        },
      ),
    );
  }
}

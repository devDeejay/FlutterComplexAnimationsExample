import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleSlideAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(child: Scaffold(body: buildBody())),
    );
  }

  Widget buildBody() {
    return Container(

        /// Adding our animating stateful widget as a child
        child: SlidingBox());
  }
}

/// Each of the animating widgets have to be a stateful widget
class SlidingBox extends StatefulWidget {
  @override
  _SlidingBoxState createState() => _SlidingBoxState();
}

/// The state sort of implements a animation framework called SingleTickerProviderStateMixin
class _SlidingBoxState extends State<SlidingBox>
    with SingleTickerProviderStateMixin {
  /// There are two things required
  /// - Animation : Defines the animation to do
  /// - AnimationController : To control when that animation takes place

  Animation slidingAnimation;
  AnimationController slidingBoxAnimationController;

  /// We have to initialize these fields before the widget is built
  /// Hence we use the initState() function

  @override
  void initState() {
    super.initState();

    /// We first define our animation controller as it needs to be passed inside the animation object
    /// We simply define the duration for the controller
    slidingBoxAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    /// Defining the animation as a Tween animation
    /// Begin and end value is generally ranges between 0.0 to 1.0 but you can change it as per your animation calculations
    /// We provide a CurvedAnimation to define what type of animation curve we want, we are using 'easeIn' here
    /// Be sure to use double values and not int values
    slidingAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: slidingBoxAnimationController, curve: Curves.fastOutSlowIn));

    /// If we want the animation to start automatically
    /// We tell the controller to start the animation
    /// forward() and reverse() are the two ways an animation could go
    slidingBoxAnimationController.forward();
  }

  /// Defining our widget inside the build function
  /// Here is where we define the actual animation that needs to happen
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: slidingBoxAnimationController,
      builder: (BuildContext context, Widget child) {
        /// Here we define the animation on y axis, as the number will grow from
        /// 0 to 1 it will be multiplied with the width
        /// and the widget will 'translate' from that position
        return Column(
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  slidingAnimation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                  child: Text(""),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

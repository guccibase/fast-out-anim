import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  void anim(status) {
    if (status == AnimationStatus.completed) {
      animationController.removeStatusListener(anim);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn));
      animationController.forward();
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(anim);
    animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Center(
              child: Transform(
                transform: Matrix4.translationValues(
                    size.width * animation.value, 0, 0),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.brown,
                ),
              ),
            );
          }),
    );
  }
}

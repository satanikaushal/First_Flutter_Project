import 'package:flutter/material.dart';

class AnimationsBasicWidget extends StatefulWidget {
  const AnimationsBasicWidget({super.key});

  @override
  State<AnimationsBasicWidget> createState() => _AnimationsBasicWidgetState();
}

class _AnimationsBasicWidgetState extends State<AnimationsBasicWidget>
    with TickerProviderStateMixin {
  late Animation<double> offsetX;
  late Animation<double> offsetY;
  late AnimationController controller;
  double offsetXNormal = 0.0;
  double offsetYNormal = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1));
    offsetX = Tween(begin: offsetXNormal, end: offsetXNormal).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    offsetY = Tween(begin: offsetYNormal, end: offsetYNormal).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  updateTransition() {
    controller.duration = Duration(milliseconds: 10);
    offsetX = Tween(begin: offsetX.value, end: offsetXNormal).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(
        () {
          setState(() {});
        },
      );
    offsetY = Tween(begin: offsetY.value, end: offsetYNormal).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(
        () {
          setState(() {});
        },
      );
    controller.forward();
  }

  resetTransition() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    offsetX = Tween(begin: offsetX.value, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(
        () {
          setState(() {});
        },
      );
    offsetY = Tween(begin: offsetY.value, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(
        () {
          setState(() {});
        },
      );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            print("${details.delta.dx} delta x");
            print("${details.delta.dy} delta y");
            setState(() {
              offsetXNormal = offsetXNormal + details.delta.dx;
              offsetYNormal = offsetYNormal + details.delta.dy;
            });
            updateTransition();
          },
          onPanEnd: (_) {
            setState(() {
              offsetXNormal = 0;
              offsetYNormal = 0;
            });
            resetTransition();
          },
          child: Transform(
            transform:
                Matrix4.translationValues(offsetX.value, offsetY.value, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

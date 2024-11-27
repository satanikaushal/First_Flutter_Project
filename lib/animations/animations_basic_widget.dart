import 'package:flutter/material.dart';

class AnimationsBasicWidget extends StatefulWidget {
  const AnimationsBasicWidget({super.key});

  @override
  State<AnimationsBasicWidget> createState() => _AnimationsBasicWidgetState();
}

class _AnimationsBasicWidgetState extends State<AnimationsBasicWidget> {
  // var _isAnimationRun = false;
  // var _size = 0;
  // var _textSize =
  // toggleAnimation() {
  //   setState(() {
  //     _size = _size == 20 ? 0 : 20;
  //
  //     _isAnimationRun = !_isAnimationRun;
  //   });
  // }
  var crossFadeState = CrossFadeState.showFirst;
  var text = "Nice";

  toggle() {
    setState(() {
      text = text == "Nice" ? "" : "Nice";
      crossFadeState = crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 100),
              duration: Duration(milliseconds: 1000),
              builder: (context, object, widget) {
                return Container(
                  height: object,
                  width: object,
                  color: Colors.red,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyPager extends StatefulWidget {
  const MyPager({super.key});

  @override
  State<MyPager> createState() => _MyPagerState();
}

class _MyPagerState extends State<MyPager> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: PageView(
        controller: pageController,
        allowImplicitScrolling: true,
        pageSnapping: true,
        dragStartBehavior: DragStartBehavior.start,
        children: [
          Container(
            color: Colors.orangeAccent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        });
                      },
                      child: Text("Go to second page"))
                ],
              ),
            ),
          ),
          Container(
            color: Colors.lightBlue,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        });
                      },
                      child: Text("Back to first page"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

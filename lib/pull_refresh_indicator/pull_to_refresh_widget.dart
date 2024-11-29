import 'package:flutter/material.dart';

class PullToRefreshWidget extends StatefulWidget {
  const PullToRefreshWidget({super.key});

  @override
  State<PullToRefreshWidget> createState() => _PullToRefreshWidgetState();
}

class _PullToRefreshWidgetState extends State<PullToRefreshWidget> {
  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Builder(builder: (context){
                return ListTile(
                  title: Text("Hello World $index"),
                );
              },);
            },
          )
      ),
    );
  }
}

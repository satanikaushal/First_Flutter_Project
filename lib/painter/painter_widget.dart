import 'package:flutter/material.dart';

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.filledTonal(
          style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(50, 50))),
          onPressed: () {
            setState(() {
              _points.clear();
            });
          },
          icon: Icon(
            Icons.lock_reset,
            size: 30,
          )),
      body: Container(
        color: Colors.white,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox? referenceBox = context.findRenderObject() as RenderBox;
              Offset localPosition =
                  referenceBox.globalToLocal(details.globalPosition);
              _points = List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (details) => _points.add(Offset.zero),
          child: CustomPaint(
            painter: MyDemoPainter(),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class MyDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;
    // canvas.;
  }

  @override
  bool shouldRepaint(MyDemoPainter oldDelegate) {
    return false;
  }
}

// class SignaturePainter extends CustomPainter {
//   SignaturePainter(this.points);
//   final List<Offset?> points;
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5;
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(SignaturePainter oldDelegate) =>
//       oldDelegate.points != points;
// }

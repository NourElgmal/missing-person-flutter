import 'package:flutter/material.dart';
import 'package:missing/Pages/gosin_in_up.dart';
import 'package:missing/widget/url.dart';

class Splach extends StatefulWidget {
  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  double x = -200.0, y = 0.0;

  an() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      x = MediaQuery.of(context).size.width * .35;
      y = MediaQuery.of(context).size.height * .2;
    });
  }

  @override
  void initState() {
    super.initState();
    an();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.bounceOut,
        transform: Matrix4.translationValues(x, y, .1),
        child: Image.network(
          Url.sin_in_up,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
        onEnd: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Gosin_In_Up(),
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}

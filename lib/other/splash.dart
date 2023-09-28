import 'package:flutter/material.dart';
import 'package:wealthwise/other/start.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Start();
        },
      ));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        width: 300,
        height: 200,
        child: Image.asset('lib/pics/wealth.png'),
      )),
    );
  }
}

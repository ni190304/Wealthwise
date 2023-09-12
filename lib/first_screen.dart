import 'dart:async';
import 'package:wealthwise/start.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class First_Screen extends StatefulWidget {
  const First_Screen({Key? key}) : super(key: key);

  @override
  State<First_Screen> createState() => _First_ScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.zeyada(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 55,
      fontWeight: FontWeight.normal,
      // fontStyle: FontStyle.italic
    ),
  );
}

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 239, 118, 5),
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _First_ScreenState extends State<First_Screen> {
  double _opacityLevel = 0;
  Timer? _timer1;
  Timer? _timer2;

  @override
  void initState() {
    super.initState();

    // Start Timer 1
    _timer1 = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _opacityLevel = 1; // Increase opacity to 1 after 1 second
      });

      // Start Timer 2 after Timer 1 completes
      _timer2 = Timer(const Duration(milliseconds: 1750), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Start(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timers to avoid calling setState() after the widget is disposed
    _timer1?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacityLevel,
          duration: const Duration(milliseconds: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenSize.height * 0.25,
                width: screenSize.width * 0.5,
                child: Lottie.asset('lib/animations/logo.json'),
              ),
              const SizedBox(height: 20),
              Text(
                'Wealthwise',
                style: namestyle1(),
              ),
              Text(
                'All about financial awareness',
                style: namestyle4(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

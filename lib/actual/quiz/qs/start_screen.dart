import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle1() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 50,
    ),
  );
}

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 37,
    ),
  );
}

class StartScreen extends StatelessWidget {
  const StartScreen(this.start_quiz, {super.key});

  // ignore: non_constant_identifier_names
  final void Function() start_quiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Image.asset(
              'lib/images/quiz.png',
              width: 325,
              height: 400,
            ),
          ),
          Text("Let's play",
              textAlign: TextAlign.center, style: _getTextStyle1()),
          const SizedBox(
            height: 35,
          ),
          OutlinedButton.icon(
            onPressed: start_quiz,
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
                backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
            icon: const Icon(Icons.arrow_right_alt_outlined),
            label: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: Text(
                'Start Quiz',
                textAlign: TextAlign.center,
                style: _getTextStyle2(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

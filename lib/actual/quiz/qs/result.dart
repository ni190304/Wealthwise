import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wealthwise/actual/quiz/qs/qsumm.dart';
import 'package:wealthwise/actual/quiz/qs/quescreen.dart';
import 'package:wealthwise/actual/quiz/qs/questions.dart';
import 'package:wealthwise/actual/user_scr.dart';

import 'analysis.dart';

void refreshBuffer() {
  answered_ques.clear();
  correctly_answered.clear();
}

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 231, 229, 229),
      fontSize: 23,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle _getTextStyle3() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle _getTextStyle4() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 63, 20, 3),
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30,
    ),
  );
}

class Result extends StatefulWidget {
  Result({super.key, required this.chosen_answers});

  int chosen_answers;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var button_pressed = false;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < answered_ques.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'user_answered': answered_ques[i],
        'correct_answer': correct_answers[i],
      });
    }

    return summary;
  }

  void submit_details() async {
    setState(() {
      button_pressed = true;
    });

    final current_email = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance
        .collection('User')
        .doc(current_email)
        .set({'email': current_email});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          child: correctly_answered.isEmpty
                              ? Lottie.asset('lib/animations/anim2.json')
                              : correctly_answered.length != 0 &&
                                      correctly_answered.length <= 3
                                  ? Lottie.asset('lib/animations/anim4.json')
                                  : correctly_answered.length > 3 &&
                                          correctly_answered.length != 6
                                      ? Lottie.asset(
                                          'lib/animations/anim1.json')
                                      : Lottie.asset(
                                          'lib/animations/anim3.json'),
                        ),
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        Text(
                          correctly_answered.isEmpty
                              ? 'Sorry, Better luck next time'
                              : correctly_answered.length <= 3 &&
                                      correctly_answered.isNotEmpty
                                  ? 'Improvement needed'
                                  : correctly_answered.length > 3 &&
                                          correctly_answered.length != 6
                                      ? 'Well done'
                                      : 'Congratulations!!!',
                          style: _getTextStyle4(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 39, 38, 38),
                              width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Your Score :   ',
                              style: _getTextStyle1(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${correctly_answered.length} / ${answered_ques.length}',
                              style: _getTextStyle3(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                QuesSumm(getSummaryData()),
                if (!button_pressed)
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        submit_details();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const UserScreen();
                          },
                        ));
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                          backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
                      icon: const Icon(Icons.restart_alt_outlined),
                      label: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10.0, left: 10.0),
                        child: Text(
                          'Go to Homepage',
                          textAlign: TextAlign.center,
                          style: _getTextStyle2(),
                        ),
                      ),
                    ),
                  ),
                if (button_pressed) const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

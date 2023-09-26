import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwise/actual/quiz/qs/result.dart';
import 'package:wealthwise/actual/quiz/qs/result1.dart';
import 'package:wealthwise/designed_boxes/neubox4.dart';
import 'package:wealthwise/designed_boxes/neubox5.dart';
import 'analysis.dart';
import 'answerbutton.dart';
import 'questions.dart';

TextStyle _getTextStyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 30,
    ),
  );
}

class QuestionsScreen1 extends StatefulWidget {
  const QuestionsScreen1({super.key});

  @override
  State<QuestionsScreen1> createState() => _QuestionsScreen1State();
}

class _QuestionsScreen1State extends State<QuestionsScreen1> {
  var current_question_index = 0;

  void nextquestion() {
    setState(() {
      current_question_index++;
    });
  }

  TextStyle _getTextStyle2() {
    return GoogleFonts.katibeh(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current_question = questions1[current_question_index];
    var correct_answered = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${current_question_index + 1}',
                style: _getTextStyle(),
              ),
              SizedBox(
                height: 40,
              ),
              Neubox5(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      current_question.text,
                      style: _getTextStyle2(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ...current_question.getshuffledanswers().map((answer) {
                      return AnswerButton(
                          answertext: answer,
                          ontap: () {
                            answered_ques1.add(answer);
                            if (correct_answers1.contains(answer)) {
                              correctly_answered1.add(answer);
                            }
                            if (current_question_index == 3) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Result1(
                                  chosen_answers: correct_answered,
                                );
                              }));
                            } else {
                              nextquestion();
                            }
                          });
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

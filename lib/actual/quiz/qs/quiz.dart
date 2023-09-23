import 'package:flutter/material.dart';
import 'package:wealthwise/actual/quiz/qs/quescreen.dart';
import 'start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // ignore: non_constant_identifier_names
  Widget? active_screen;

  @override
  void initState() {
    active_screen = StartScreen(switch_screen);
    super.initState();
  }

  void switch_screen() {
    setState(() {
      active_screen = const QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 150, 245),
      body: Container(
        child: active_screen,
      ),
    );
  }
}

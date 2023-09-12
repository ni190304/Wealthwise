import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info2 extends StatefulWidget {
  const Info2({super.key});

  @override
  State<Info2> createState() => _Info2State();
}

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.normal,
    ),
  );
}

List<String> tutor_emails = [];

class _Info2State extends State<Info2> {
  var _is_student_selected = true;
  var button_pressed = false;

  var _iscont = false;

  int selected_option = 0;

  void _handleoptionchange(int value) {
    setState(() {
      selected_option = value;
    });
  }

  void submit_details() async {
    setState(() {
      button_pressed = true;
    });

    final current_email = FirebaseAuth.instance.currentUser!.email;

    if (selected_option == 0) {
      await FirebaseFirestore.instance
          .collection('Student')
          .doc(current_email)
          .set({'email': current_email});
    } else {
      await FirebaseFirestore.instance
          .collection('Tutor')
          .doc(current_email)
          .set({'email': current_email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What's your role ?",
              style: namestyle4(),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    RadioListTile(
                      title: Text('Student'),
                      value: 0,
                      groupValue: selected_option,
                      onChanged: (value) {
                        _handleoptionchange(value!);
                      },
                    ),
                    RadioListTile(
                      title: Text('Tutor'),
                      value: 1,
                      groupValue: selected_option,
                      onChanged: (value) {
                        _handleoptionchange(value!);
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            if (!button_pressed)
              ElevatedButton.icon(
                onPressed: submit_details,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 61, 24, 12),
                ),
                icon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  ),
                ),
                label: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (button_pressed) const CircularProgressIndicator()
          ],
        )),
      ),
    );
  }
}

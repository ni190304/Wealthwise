import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../StockModules/ln1.dart';

TextStyle t1() {
  return GoogleFonts.ebGaramond(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

var tt = 'Loan Basics';

class Module3 extends StatelessWidget {
  const Module3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ModLoan1(name: tt);
            },
          ));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            height: 220,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loan Basics',
                        style: t1(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle t1() {
  return GoogleFonts.ebGaramond(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

class Stock3 extends StatelessWidget {
  const Stock3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 239, 237, 237),
          ),
          height: 200,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "`The four most dangerous words in investing are: 'This time it's different.`",
                  style: t1(),
                ),
                Text('~ Sir John Templeton')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

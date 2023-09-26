import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'exp.dart';

var kcolorsch = ColorScheme.fromSeed(seedColor: Color.fromARGB(159, 8, 52, 84));

var kdarkcolorsch = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 158, 7, 45));

class MyExpenseTracker extends StatelessWidget {
  const MyExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kdarkcolorsch,
        cardTheme: CardTheme().copyWith(
          color: kdarkcolorsch.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kdarkcolorsch.primaryContainer,
                foregroundColor: kdarkcolorsch.onPrimaryContainer)),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          // scaffoldBackgroundColor: Color.fromARGB(255, 230, 241, 243),
          cardTheme: CardTheme().copyWith(
            color: kcolorsch.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          colorScheme: kcolorsch,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorsch.onPrimaryContainer,
            foregroundColor: kcolorsch.primaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kcolorsch.primaryContainer,
                  foregroundColor: kcolorsch.onPrimaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorsch.onSecondaryContainer,
                  fontSize: 20),
              titleSmall: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 120, 16, 168),
                  fontSize: 16))),
      home: const Expenses(),
    );
  }
}

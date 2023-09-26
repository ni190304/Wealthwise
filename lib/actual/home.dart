import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wealthwise/actual/home/budgeting.dart';
import 'package:wealthwise/actual/home/investments.dart';
import 'package:wealthwise/actual/home/loans.dart';

import 'home/stocks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  List<Widget> screens = [Budgeting(), Investment(), Loans(), Stocks()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stocks()
    );
  }
}

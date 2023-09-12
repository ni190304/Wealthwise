import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wealthwise/tutor/finances/budget.dart';
import 'package:wealthwise/tutor/finances/budget1.dart';
import 'package:wealthwise/tutor/finances/debt.dart';
import 'package:wealthwise/tutor/finances/invest.dart';
import 'package:wealthwise/tutor/finances/tax.dart';

class TutorHome extends StatefulWidget {
  const TutorHome({super.key});

  @override
  State<TutorHome> createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  PageController _pageController = PageController();
  int currentIndex = 0; // Moved currentIndex into the state class

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController
          .jumpToPage(index); // Update the PageView's page when tab is changed
    });
  }

  List<Widget> screens = [Budget1(), Invest(), Debt(), Tax()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          GNav(
            backgroundColor: Colors.white,
            selectedIndex: currentIndex,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            onTabChange: _onTabTapped,
            gap: 4,
            padding: const EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.bar_chart_rounded,
                text: 'Budgeting',
              ),
              GButton(
                icon: Icons.monetization_on_sharp,
                text: 'Investing and Saving',
              ),
              GButton(
                icon: Icons.credit_card,
                text: 'Debt Management',
              ),
              GButton(
                icon: Icons.attach_money_rounded,
                text: 'Tax Planning',
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: screens,
              onPageChanged: (index) {
                setState(() {
                  currentIndex =
                      index; // Update currentIndex when PageView page changes
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

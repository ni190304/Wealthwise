import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Home/budget1.dart';
import 'Home/debt1.dart';
import 'Home/invest1.dart';
import 'Home/tax1.dart';

class TutorHome extends StatefulWidget {
  const TutorHome({super.key});

  @override
  State<TutorHome> createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  List<Widget> screens = [Budget1(), Invest1(), Debt1(), Tax1()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
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

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'MyVideos/budget2.dart';
import 'MyVideos/debt2.dart';
import 'MyVideos/invest2.dart';
import 'MyVideos/tax2.dart';

class TutorVid extends StatefulWidget {
  const TutorVid({super.key});

  @override
  State<TutorVid> createState() => _TutorVidState();
}

class _TutorVidState extends State<TutorVid> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  List<Widget> screens = [Budget2(), Invest2(), Debt2(), Tax2()];
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

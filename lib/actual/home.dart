import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wealthwise/actual/home/budgeting.dart';
import 'package:wealthwise/actual/home/investments.dart';
import 'package:wealthwise/actual/home/loans.dart';
import 'package:wealthwise/actual/home/stocks.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 5,
          // ),
          GNav(
            backgroundColor: Colors.white,
            selectedIndex: currentIndex,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            onTabChange: _onTabTapped,
            gap: 15,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 13.5,bottom: 13.5),
            tabs: const [
              GButton(
                icon: Icons.account_balance_wallet_rounded,
                text: 'Budgeting',
              ),
              GButton(
                icon: Icons.monetization_on,
                text: 'Investing',
              ),
              GButton(
                icon: Icons.credit_card,
                text: 'Loans',
              ),
              GButton(
                icon: Icons.show_chart,
                text: 'Stocks',
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

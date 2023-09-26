import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wealthwise/actual/home/Stock/Quotes/module1.dart';
import 'Stock/Quotes/module2.dart';
import 'Stock/Quotes/module3.dart';
import 'Stock/Quotes/module4.dart';
import 'Stock/Quotes/module5.dart';
import 'Stock/Quotes/stock1.dart';
import 'Stock/Quotes/stock2.dart';
import 'Stock/Quotes/stock3.dart';
import 'Stock/Quotes/stock4.dart';

TextStyle t1() {
  return GoogleFonts.ebGaramond(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

List<String> stockmodules = [
  'Stock Basics',
  'How to invest in stocks',
  'Stock Exchange',
  'Stock Market Indices',
  'Stock analysis and Risk-reward factor'
];

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
  );
}

final PageController pgcontroller1 = PageController();
final PageController pgcontroller2 = PageController();

class _StocksState extends State<Stocks> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Some popular quotes',
                  style: namestyle1(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 160,
                  child: PageView(
                    controller: pgcontroller1,
                    children: const [Stock1(), Stock2(), Stock3(), Stock4()],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: pgcontroller1,
                      count: 4,
                      effect: WormEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: Color.fromARGB(255, 153, 150, 150),
                        dotHeight: 6,
                        dotWidth: 6,
                        spacing: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Basics',
                  style: namestyle1(),
                ),
                const SizedBox(
                  height: 13,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Stocks: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Stocks represent ownership in a company and are bought and sold in financial markets. Investors purchase stocks in the hope of capital appreciation and may receive dividends. Stocks carry a level of risk but offer the potential for long-term returns.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Loans involve borrowing money from a lender with the promise of repayment, typically with interest. They can be used for various purposes, such as personal expenses, business investments, or buying assets. Loans come in different forms, including personal loans, mortgages, and business loans, each with specific terms and conditions.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Modules',
                  style: namestyle1(),
                ),
                const SizedBox(
                  height: 13,
                ),
                const SizedBox(
                  height: 13,
                ),
                Column(
                  children: [
                    Container(height: 160, child: Module1()),
                    const SizedBox(
                      height: 13,
                    ),
                    Container(height: 160, child: Module2()),
                    const SizedBox(
                      height: 13,
                    ),
                    Container(height: 160, child: Module3()),
                    const SizedBox(
                      height: 13,
                    ),
                    Container(height: 160, child: Module4()),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

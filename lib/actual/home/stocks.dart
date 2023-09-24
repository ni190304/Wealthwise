import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wealthwise/actual/home/Stock/stock1.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
  );
}

final PageController pgcontroller = PageController();

class _StocksState extends State<Stocks> {
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
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 160,
                    child: PageView(
                      controller: pgcontroller,
                      children: const [Stock1(), Stock1(), Stock1(), Stock1()],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: pgcontroller,
                        count: 4,
                        effect: WormEffect(
                            activeDotColor:
                                Theme.of(context).colorScheme.primary,
                            dotColor: Color.fromARGB(255, 153, 150, 150),
                            dotHeight: 6,
                            dotWidth: 6,
                            spacing: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Basics',
                    style: namestyle1(),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Stocks, also known as equities or shares, represent ownership in a company. When you buy a stock, you acquire a stake in that company, becoming a shareholder with potential voting rights and the possibility of receiving dividends. Stocks are traded on stock exchanges, where their prices fluctuate based on various factors. Investing in stocks can offer opportunities for capital gains, but it also comes with risk due to market volatility. Diversification and thorough research are essential for managing these risks, and many investors choose stocks as a long-term investment to benefit from the growth potential of companies over time.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

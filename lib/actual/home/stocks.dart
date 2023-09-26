import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

List<String> stockmodules = [
  'Stock Basics',
  'How to invest in stocks (for beginners)',
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
                    child: Text(
                      'Stocks, also known as equities or shares, represent ownership in a company. When you buy a stock, you acquire a stake in that company, becoming a shareholder with potential voting rights and the possibility of receiving dividends. Stocks are traded on stock exchanges, where their prices fluctuate based on various factors. Investing in stocks can offer opportunities for capital gains, but it also comes with risk due to market volatility. Diversification and thorough research are essential for managing these risks, and many investors choose stocks as a long-term investment to benefit from the growth potential of companies over time.',
                      maxLines: isExpanded ? 13 : 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'See Less' : 'See More',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
                      const SizedBox(
                        height: 13,
                      ),
                      Container(height: 160, child: Module5()),
                    ],
                  ),
                  // ListView.builder(
                  //   itemCount: 5,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(right: 10.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.black, width: 0.5),
                  //           borderRadius: BorderRadius.circular(10),
                  //           color:
                  //               Theme.of(context).colorScheme.primaryContainer,
                  //         ),
                  //         height: 220,
                  //         width: double.infinity,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               CircleAvatar(
                  //                   backgroundColor:
                  //                       Theme.of(context).colorScheme.primary,
                  //                   child: Text(
                  //                     (index + 1).toString(),
                  //                     style: TextStyle(
                  //                         color: Colors.white, fontSize: 15),
                  //                   )),
                  //               const SizedBox(
                  //                 height: 20.0,
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     stockmodules[index],
                  //                     style: t1(),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}

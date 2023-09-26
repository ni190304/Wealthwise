import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwise/actual/quiz/qs/quescreen1.dart';
import 'package:wealthwise/designed_boxes/neubox7.dart';

import '../../quiz/qs/quescreen.dart';

class ModStock1 extends StatefulWidget {
  const ModStock1({super.key, required this.name});

  final String name;

  @override
  State<ModStock1> createState() => _ModStock1State();
}

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30,
    ),
  );
}

class _ModStock1State extends State<ModStock1> {
  TextStyle namestyle1() {
    return GoogleFonts.arvo(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 21,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            const SizedBox(
              width: 45,
            ),
            Text(
              widget.name,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 55, 54, 54), width: 0.25),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What Are Stocks?',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Stocks represent ownership shares in a company. When you buy a stock, you become a shareholder or stockholder, which means you own a part of that company. Think of it like owning a piece of a pie – the size of your piece depends on how many shares you own compared to the total number of shares the company has issued.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 55, 54, 54), width: 0.25),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why Companies Issue Stocks:',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Companies issue stocks as a way to raise capital (money). They do this for various reasons:',
                        style: TextStyle(fontSize: 19),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Expansion: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'To fund business growth, open new locations, or enter new markets.',
                            )
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Research and Development: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'To invest in research, develop new products, or improve existing ones.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Debt Repayment: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'To pay off debts or reduce interest expenses.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Acquisitions: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'To acquire other companies or assets.Operational Needs: To have cash on hand for day-to-day operations.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 55, 54, 54), width: 0.25),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why Invest in Stocks?',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Text(
                        'Investing in stocks can offer several advantages, including:',
                        style: TextStyle(fontSize: 19),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Potential for High Returns: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Historically, stocks have provided some of the highest long-term returns among all investment options.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Ownership and Voting Rights: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    "Stockholders may have the right to vote on certain company decisions and receive dividends, which are a portion of the company's profits distributed to shareholders.")
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Liquidity: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Stocks are generally easy to buy and sell, making them a liquid investment.')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Diversification: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'You can diversify your portfolio by investing in a variety of stocks, reducing risk')
                          ],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 55, 54, 54), width: 0.25),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Types of Stocks:',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'There are two main types of stocks: common stocks and preferred stocks.',
                        style: TextStyle(fontSize: 19),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        'Common Stocks:',
                        style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "These are the most common type of stock.Common stockholders have voting rights at the company's annual meetings, where they can voice opinions and vote on important company decisions.They may also receive dividends, which are a portion of the company's profits distributed to shareholders.Common stockholders benefit from any increase in the company's stock price.However, they also bear the most risk if the company faces financial difficulties.",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        'Preferred Stocks:',
                        style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Preferred stockholders don't usually have voting rights, but they have a higher claim on the company's assets and earnings than common stockholders.They receive dividends before common stockholders and have a fixed dividend rate.In the event of bankruptcy or liquidation, preferred stockholders are prioritized over common stockholders for the distribution of assets.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const QuestionsScreen1();
                          },
                        ));
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                          backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
                      icon: const Icon(Icons.restart_alt_outlined),
                      label: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10.0, left: 10.0),
                        child: Text(
                          'Take up a Quiz',
                          textAlign: TextAlign.center,
                          style: _getTextStyle2(),
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

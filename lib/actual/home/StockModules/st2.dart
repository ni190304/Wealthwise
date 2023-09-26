import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwise/designed_boxes/neubox7.dart';

class ModStock2 extends StatefulWidget {
  const ModStock2({super.key, required this.name});

  final String name;

  @override
  State<ModStock2> createState() => _ModStock2State();
}

class _ModStock2State extends State<ModStock2> {
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
              width: 20,
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
                height: 1600,
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
                        'Open A Demat Account',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Text(
                          'A Demat account, derived from “dematerialization account”, simplifies the process of holding investments such as shares, bonds, mutual funds, government securities, insurance, and ETFs.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Initially, shares were held in the form of physical certificates, which were cumbersome to store and transfer, making the entire process tedious and time consuming.To eliminate such limitations, the National Securities Depository Limited (NSDL) brought the concept of Demat accounts that enabled electronic storage of shares and securities of companies.In India, if you want to invest in stock market, it is compulsory to open a Demat account.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Features of Demat account:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Digitally secure way of holding shares and securities.Eliminates theft, loss and physical damage to physical certificates.'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Quick transfer of shares.'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Eliminates unnecessary paperwork'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                'Online opening of demat account is simpler and faster.'),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Types of Demat accounts:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'In India, there are 3 major types of accounts offered by depository participants.'),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Regular Demat account',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                'These are meant for Indian residants. If you are dealing with equity and investment trading, this is the best option for you. Here charges are dependent on the type subscribed, volume in the account and various terms and conditions set by the depository and the depository participant.'),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Repatriable Demat accounts',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                'This kind of demat account is good for NRIs, who wish to invest in Indian stock market from anywhere in the world. They need to possess an associated NRE bank account.'),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Non-repatriable Demat accounts',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                'Similar to repatriable and is for NRIs but does not allow you to transfer funds abroad. It requires you to link to a NRO bank account.'),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Documentation requirements for demat account opening:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: 10,),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'A proof of identity (PAN, Aadhar, Passport)',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'A proof of address (Aadhar, Ration card)',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'A proof of income (Income tax return copy, salary proof)',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Bank account proof (cancelled cheque, passbook)',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Recent passport-sized photograph',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '5 Best Demat accounts in india:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: 10,),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Zerodha',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Upstox',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Angel One',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'ICICI Direct',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'HDFC Securities',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 200,
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
                        'Setting investment budget and investment goals',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        "Determine your investment objectives, such as saving for retirement, buying a home, or funding education. Your goals will help shape your investment strategy. Assess your current financial situation and decide how much you can comfortably invest. It's essential not to invest money you can't afford to lose.",
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
                height: 300,
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
                        'Select Investments',
                        style: namestyle1(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Individual Stocks:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Research and select specific companies whose stock you want to buy. Look at their financials, growth potential, and industry trends.')
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
                              text: 'Exchange-Traded Funds (ETFs): ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    "ETFs are like baskets of stocks or other assets. They provide diversification and are a good choice for beginners")
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
                              text: 'Mutual Funds: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'These are managed pools of money invested in various assets, including stocks. They can be actively managed or passively managed (index funds).')
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
                height: 125,
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
                        'Diversify Your Portfolio',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Avoid putting all your money into a single stock. Diversification can help spread risk. Aim for a mix of different industries and asset types.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                        height: 10,
                      ),
              Container(
                height: 145,
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
                        'Start Investing',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Fund your brokerage account and start buying investments. Consider dollar-cost averaging, which involves investing a fixed amount regularly, regardless of market conditions.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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

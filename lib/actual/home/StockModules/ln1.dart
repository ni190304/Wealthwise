import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwise/designed_boxes/neubox7.dart';

class ModLoan1 extends StatefulWidget {
  const ModLoan1({super.key, required this.name});

  final String name;

  @override
  State<ModLoan1> createState() => _ModLoan1State();
}

class _ModLoan1State extends State<ModLoan1> {
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
                height: 175,
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
                        'What Are Loans?',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'A loan is a financial transaction where one party, known as the lender, provides a sum of money or assets to another party, known as the borrower. The borrower agrees to repay the borrowed amount, often with interest and fees, over a specified period.',
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
                height: 500,
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
                        'Types of Loans: ',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Secured Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "These loans are backed by something valuable, like a house or car.If you can't repay, the lender can take that valuable thing as payment.Generally, secured loans have lower interest rates because they're less risky for the lender.",
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
                              text: 'Unsecured Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    "These loans don't require any collateral (valuable thing).Since there's no guarantee for the lender, unsecured loans often have higher interest rates.")
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
                              text: 'Personal Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' These loans are typically unsecured and can be used for various purposes, such as debt consolidation, travel, or unexpected expenses.')
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
                              text: 'Student Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Most student loans, both federal and private, are unsecured.')
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
                              text: 'Medical Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Loans for medical expenses are usually unsecured.')
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
                              text: 'Payday Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'These short-term loans are typically unsecured but often come with high interest rates.')
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
                              text: 'Signature Loans: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'These are unsecured personal loans where your promise to repay serves as the only guarantee.')
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
                        'Interest Rates',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Interest is the cost of borrowing money. When you take out a loan, you agree to pay back not only the principal amount (the original borrowed sum) but also the interest, which is calculated as a percentage of the principal.Interest rates can be fixed (remain constant throughout the loan term) or variable (change with market conditions).',
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
                        'Loan Term',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        "The loan term is the duration over which you'll repay the loan. Loan terms vary widely, from a few months (e.g., payday loans) to several decades (e.g., mortgages).Shorter loan terms often result in higher monthly payments but lower overall interest costs, while longer terms have lower monthly payments but higher total interest.",
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
                        'Repayment',
                        style: namestyle1(),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        "Loans are typically repaid in regular installments (monthly, bi-weekly, etc.). It's crucial to make timely payments to avoid penalties and protect your credit score.Some loans offer flexible repayment options, such as deferment, forbearance, or income-driven repayment plans for student loans.",
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

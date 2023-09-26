class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;

  final List<String> answers;

  List<String> getshuffledanswers() {
    final shuffledlist = List.of(answers);
    shuffledlist.shuffle();
    return shuffledlist;
  }
}

const questions = [
  QuizQuestion(
    ' What is the purpose of creatng a personal budget?',
    [
       'To increase spending on non-essential items',
 'To track income and expenses and plan for financial goals',
 'To invest in high-risk stocks',
'To pay off all debts at once'
    ],
  ),

  QuizQuestion(
    'Which type of loan is typically used to purchase a house in India?',
    [
       'Personal Loan',
'Car Loan',
'Home Loan',
 'Education Loan'
    ],
  ),

  QuizQuestion(
    '  In India, which of the following is a government-backed investment scheme primarily designed 
for retirement savings?',

    [
      'Fixed Deposit',
 'Public Provident Fund (PPF)',
 'Mutual Funds',
 'Cryptocurrency',
    ],
  ),
  QuizQuestion(
      "When you buy a share of a company's stock, you are essentially buying:", [
     'A part of the company itself',
'A certificate of apprecia�on from the company',
 'A guaranteed fixed income',
 'A piece of physical property owned by the company',
  ]),
  QuizQuestion(
      'What is an emergency fund, and why is it important in financial planning?', [
     'A fund set aside for impulsive purchases',
 'A fund for planned vacations',
 'A savings reserve for unexpected expenses like medical bills or job loss',
 'A fund exclusively for retirement',
  ]),
  QuizQuestion(
      ' In the context of loans, what is the difference between the principal amount and the interest?',
      [
         'Principal is the total amount borrowed, while interest is the cost of borrowing.',
 'Principal is the cost of borrowing, while interest is the total amount borrowed.',
 'Principal is the total amount paid back, while interest is the initial loan amount.',
'Principal and interest are the same thing.',
      ]),
  QuizQuestion(
      'What does the term "Diversification" mean in the context of investment?', [
    'Putting all your money into a single investment to maximize returns.',
 'Spreading your investments across different asset classes to reduce risk.',
 'Inves�ng only in high-risk assets to achieve quick profits.',
'Ignoring the performance of your investments.'
  ]),

  QuizQuestion(
      'In a financial context, what is the "rule of 72" used for?', [
    'Estimating the number of years it takes for money to double at a given interest rate.',
 'Calculating the amount of taxes owed on investments.',
 'Determining the monthly payment for a mortgage.',
  'Predicting inflation rates.'
  ]),

  QuizQuestion(
      ' What is the impact of a credit score on loan approvals and interest rates in India?', [
    'Credit score has no impact on loan approvals or interest rates.',
 ' Higher credit scores typically lead to faster loan approvals and lower interest rates.',
 'Lower credit scores result in faster loan approvals and lower interest rates.',
'Credit score only affects the approval process, not interest rates.'
  ]),

  QuizQuestion(
      'What is the primary purpose of a systematic withdrawal plan (SWP) in mutual funds?', [
    'To invest a lump sum amount all at once.',
 'To allow investors to time the market for maximum returns.',
 'To provide a regular income stream to investors by redeeming a fixed number of mutual 
fund units at predetermined intervals.',
' To encourage long-term holding of mutual fund units without the option to redeem.'
  ]),
];

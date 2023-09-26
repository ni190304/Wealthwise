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
       'To increase spending on non-essential items.',
 'To track income and expenses and plan for financial goals.',
 'To invest in high-risk stocks.',
'To pay off all debts at once.'
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
      "When you buy a share of a company's stock, you are essentially buying:", [
     'A part of the company itself',
'A certificate of appreciation from the company',
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
 'Investing only in high-risk assets to achieve quick profits.',
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
 'Higher credit scores typically lead to faster loan approvals and lower interest rates.',
 'Lower credit scores result in faster loan approvals and lower interest rates.',
'Credit score only affects the approval process, not interest rates.'
  ]),
];

const questions1 = [
  QuizQuestion(
    '  What do stocks represent?',
    [
       'Shares in a bank account.',
'Ownership shares in a company.',
'Pieces of real estate.',
'Shares in a mutual fund.'

    ],
  ),

  QuizQuestion(
    ' Why do companies issue stocks?',
    [
       'To pay off debts.',
'To fund business growth and expansion.',
'To invest in research and development.',
'To purchase assets.'

    ],
  ),
  QuizQuestion(
      "What advantage do common stockholders have over preferred stockholders?", [
     'Higher claim on company assets.',
'Fixed dividend rate.',
'Voting rights.',
'Priority in receiving dividends.'

  ]),
  
  QuizQuestion(
      ' What is the main advantage of investing in stocks mentioned in the passage??',
      [
         'Guaranteed fixed returns.',
'Potential for high returns.',
'Low liquidity.',
 'Limited diversification.'

      ]),
  
];

const questions2 = [
  QuizQuestion(
    'What is the primary purpose of a Demat account in the context of stock market investing?',
    [
       'To invest directly in stocks.',
'To store and manage electronic shares and securities.',
'To trade commodities.',
'To manage a retirement fund.'


    ],
  ),

  QuizQuestion(
    'Which type of Demat account is suitable for Non-Resident Indians (NRIs) who want to invest in the Indian stock market?',
    [
      'Regular Demat account',
'Repatriable Demat account',
'Non-repatriable Demat account',
'Joint Demat account',


    ],
  ),
  QuizQuestion(
      "What is the advantage of investing in Exchange-Traded Funds (ETFs) for beginners, according to the passage?", [
     'ETFs offer high returns in a short time.',
'ETFs allow for active management of investments.',
'ETFs provide diversification and are a good choice for starters.',
'ETFs are like buying individual stocks.'


  ]),
  
  QuizQuestion(
      'Why is it important to diversify your investment portfolio?',
      [
         'To focus on a single stock for maximum profit.',
'To minimize investment risk by spreading it across different assets.',
'To avoid taxes on investment gains.',
'To increase short-term returns.'


      ]),

      QuizQuestion(
      'What is the recommended approach for beginners when investing in stocks?',
      [
         'Frequent trading to take advantage of market fluctuations.',
'Avoid monitoring investments to reduce stress.',
'Dollar-cost averaging by investing a fixed amount regularly.',
'Selling all investments during market downturns.'



      ]),
  
];




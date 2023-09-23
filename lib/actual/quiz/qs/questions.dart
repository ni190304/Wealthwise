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
    'Which country has Tegucigalpa as its capital?',
    [
      'Honduras',
      'Bolivia',
      'Peru',
      'Chile',
    ],
  ),
  QuizQuestion(
    'What country is the worlds largest in the area?',
    [
      'Russia',
      'Australia',
      'Canada',
      'China',
    ],
  ),
  QuizQuestion(
      'Brazil borders all but two countries of South America. What are they?', [
    'Peru / Colombia',
    'Ecuador / Bolivia',
    'Chile / Ecuador',
    'Colombia / Ecuador',
  ]),
  QuizQuestion(
      'Which rivers waters carry over half of all Russian river commerce?', [
    'Thames',
    'Danube',
    'Volga',
    'Loire',
  ]),
  QuizQuestion(
      ' At an elevation of 7,300 feet, Mount Kosciusko is the tallest mountain peak in which continent?',
      [
        'Australia',
        'Africa',
        'South America',
        'Europe',
      ]),
  QuizQuestion(
      'Which city is used as the reference point for 0 degrees of longitude?', [
    'Rome, Italy',
    'Greenwich, England',
    'New York, US',
    'Tokyo, Japan',
  ]),
];

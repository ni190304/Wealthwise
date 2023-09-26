
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chart.dart';
import 'details.dart';
import 'exp_list.dart';
import 'expense.dart';

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 40,
    ),
  );
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void showOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Details(onAddExpense: onAddExpens),
    );
  }

  void onAddExpens(Expense expense) {
    setState(() {
      _regexpenses.add(expense);
    });
  }

  void onRemoveExpens(Expense expense) {
    final ExpenseIndex = _regexpenses.indexOf(expense);
    setState(() {
      _regexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Deleted expense'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _regexpenses.insert(ExpenseIndex, expense);
          });
        },
      ),
    ));
  }

  final List<Expense> _regexpenses = [
    Expense(
        title: 'Restaurant',
        amount: 20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Cinema',
        amount: 27.99,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    Widget mainContent = const Center(child: Text('No expenses added'));

    if (_regexpenses.isNotEmpty) {
      mainContent =
          ExpensesList(expenses: _regexpenses, removeExpense: onRemoveExpens);
    }
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Text(
            'Expense tracker',
            style: _getTextStyle2(),
          ),
        ),
        actions: [IconButton(onPressed: showOverlay, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: width < 600 ? Column(
          children: [
            Chart(expenses: _regexpenses),
            Expanded(child: mainContent),
          ],
        ) : Row(
          children: [
            Expanded(child: Chart(expenses: _regexpenses)),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}

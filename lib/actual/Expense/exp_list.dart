
import 'package:flutter/material.dart';

import 'exp_tile.dart';
import 'expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
                color: Theme.of(context).colorScheme.error,
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                    vertical: Theme.of(context).cardTheme.margin!.vertical)),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            child: Exptile(expense: expenses[index])));
  }
}


import 'package:flutter/material.dart';

import 'expense.dart';

class Exptile extends StatelessWidget {
  const Exptile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
           ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}',style: Theme.of(context).textTheme.titleSmall,),
              const Spacer(),
              Row(
                children: [
                  Icon(CategoryIcons[expense.category]),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(expense.formdate),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          // Text(expense.id),
        ],
      ),
    ));
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense.dart';

final formatter = DateFormat.yMd();

class Details extends StatefulWidget {
  const Details({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // var _enteredtitle = '';

  // void saveChanges(String inputvalue) {
  //   _enteredtitle = inputvalue;
  // }

  final _titlecontroller = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    final picked_date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = picked_date;
    });
  }

  void submitData() {
    final amount = double.tryParse(_amountController.text);
    final amountisinv = amount == null || amount <= 0;

    if (_titlecontroller.text == null || amountisinv || _selectedDate == null) {
      if (Platform.isIOS) {
        showCupertinoDialog(context: context, builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
                content: Text('Please make sure to enter all fields'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Icon(Icons.thumb_up_sharp))
                ],
        ));
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid input'),
                content: Text('Please make sure to enter all fields'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Icon(Icons.thumb_up_sharp)) 
                ],
              ));
      }
      return;
    }

    widget.onAddExpense(Expense(
        title: _titlecontroller.text,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  void dispose1() {
    _titlecontroller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    children: [
                      TextField(
                        controller: _titlecontroller,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titlecontroller,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toLowerCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    const SizedBox(
                      width: 0.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(_titlecontroller.text);
                          print(_amountController.text);
                          submitData();
                        },
                        child: Text('Save Expense'))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

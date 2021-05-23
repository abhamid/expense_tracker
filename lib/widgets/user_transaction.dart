import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './addtransaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<UserTransaction> {
  final List<Transaction> _usersTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 66.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shirts',
      amount: 100.00,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Trouser',
      amount: 89.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'New Glass',
      amount: 10.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'New Item1',
      amount: 12.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New Item2',
      amount: 11.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'New Item3',
      amount: 10.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'New Item4',
      amount: 9.99,
      dateTime: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double amount) {
    var transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateTime: DateTime.now());
    setState(() {
      _usersTransactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddTransaction(
          addTransaction: _addTransaction,
        ),
        TransactionList(
          usersTransactions: _usersTransactions,
        ),
      ],
    );
  }
}

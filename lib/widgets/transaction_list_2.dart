import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './trasanction_item.dart';

class TransactionList2 extends StatelessWidget {
  final List<Transaction> usersTransactions;
  final Function deleteTransaction;

  TransactionList2({this.usersTransactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return usersTransactions.isNotEmpty
        // ? ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       return TrasanctionItem(
        //           usersTransaction: usersTransactions[index],
        //           deleteTransaction: deleteTransaction);
        //     },
        //     itemCount: usersTransactions.length,
        //   )
        ? ListView(
            children: usersTransactions
                .map((transaction) => TrasanctionItem(
                    key: ValueKey(transaction.id),
                    usersTransaction: transaction,
                    deleteTransaction: deleteTransaction))
                .toList())
        : LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transaction added yet!!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          });
  }
}

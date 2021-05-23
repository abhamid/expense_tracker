import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var dailyAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        var transAmt = recentTransactions[i].amount;
        var transDate = recentTransactions[i].dateTime;
        if (transDate.year == weekDay.year &&
            transDate.month == weekDay.month &&
            transDate.day == weekDay.day) {
          dailyAmount += transAmt;
        }
      }
      //print('Week Day: $weekDay Amount: $dailyAmount');
      return {'day': DateFormat.E().format(weekDay), 'amount': dailyAmount};
    }).reversed.toList();
  }

  double _calculateSpendingPerOfTotal(double dailyAmtSpent) {
    final maxSpending = recentTransactions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);

    if (maxSpending > 0) {
      return dailyAmtSpent / maxSpending;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionvalues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                spendingInAmount: data['amount'],
                spendingPerOfTotal:
                    _calculateSpendingPerOfTotal(data['amount']),
                weekDay: data['day'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

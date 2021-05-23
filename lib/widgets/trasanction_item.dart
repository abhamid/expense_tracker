import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TrasanctionItem extends StatefulWidget {
  const TrasanctionItem({
    Key key,
    @required this.usersTransaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction usersTransaction;
  final Function deleteTransaction;

  @override
  _TrasanctionItemState createState() => _TrasanctionItemState();
}

class _TrasanctionItemState extends State<TrasanctionItem> {
  Color _bgColor;

  @override
  void initState() {
    const colors = [Colors.red, Colors.blue, Colors.green, Colors.purple];
    _bgColor = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '\$${widget.usersTransaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.usersTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
            widget.usersTransaction.dateTime,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTransaction(
                  widget.usersTransaction.id,
                ),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.deleteTransaction(
                  widget.usersTransaction.id,
                ),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';

import './widgets/addtransaction.dart';
import './widgets/transaction_list_2.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _usersTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 66.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 66.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 66.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 66.99,
    //   dateTime: DateTime.now(),
    // ),
  ];

  var _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addTransaction(String title, double amount, DateTime dateTime) {
    var transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateTime: dateTime);
    setState(() {
      _usersTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      _usersTransactions.removeWhere((element) => element.id == transactionId);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddTransaction(
            addTransaction: _addTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    final recentTransDate = DateTime.now().subtract(Duration(days: 7));

    final recentTransactions = _usersTransactions
        .where((trans) => trans.dateTime.isAfter(recentTransDate))
        .toList();

    return recentTransactions;
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
  ) {
    final _availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return <Widget>[
      Container(
        height: _availableHeight * 0.10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Show Chart:",
              style: Theme.of(context).textTheme.title,
            ),
            Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              },
            ),
          ],
        ),
      ),
      _showChart
          ? Container(
              height: _availableHeight * 0.90,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            )
          : Container(
              height: _availableHeight * 0.90,
              child: TransactionList2(
                usersTransactions: _usersTransactions,
                deleteTransaction: _deleteTransaction,
              ),
            ),
    ];
  }

  List<Widget> _buildPotraitContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
  ) {
    final _availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return [
      Container(
        height: _availableHeight * 0.30,
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
      Container(
        height: _availableHeight * 0.70,
        child: TransactionList2(
          usersTransactions: _usersTransactions,
          deleteTransaction: _deleteTransaction,
        ),
      ),
    ];
  }

  PreferredSizeWidget _buildIOSNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddTransaction(context),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddTransaction(context),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildIOSNavigationBar() : _buildAndroidAppBar();

    final _availableHeight = _mediaQuery.size.height -
        appBar.preferredSize.height -
        _mediaQuery.padding.top;

    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              ..._buildLandscapeContent(
                _mediaQuery,
                appBar,
              ),
            if (!_isLandscape)
              ..._buildPotraitContent(
                _mediaQuery,
                appBar,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddTransaction(context),
                  ),
          );
  }
}

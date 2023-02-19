import 'dart:io';

import 'package:expenses_app/widgets/transaction_chart/transaction_chart.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

void main() { 
  // Ensure the app does not allow landscape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const ExpensesApp()); 
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const CupertinoApp(
      title: 'Expenses App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemIndigo,
        primaryContrastingColor: CupertinoColors.systemYellow,
        scaffoldBackgroundColor: CupertinoColors.secondarySystemBackground,
        textTheme: CupertinoTextThemeData (
          textStyle: TextStyle(fontFamily: 'Quicksand'),
          navTitleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      home: HomePage(),
    ) : MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSwatch(primarySwatch: Colors.deepPurple)
          .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontFamily: 'OpenSans', fontSize: 16, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // textButtonTheme: const TextButtonThemeData(style: ButtonStyle(
        //   foregroundColor: MaterialStatePropertyAll(Colors.white),
        //   backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
        // )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showTransactionChart = false;
  
  final List<Transaction> _transactions = [
    Transaction(
      id: "t1", 
      title: "DS",
      amount: 450.05,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: "t2", 
      title: "GameCube",
      amount: 9999.99,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toIso8601String(), 
      title: title, 
      amount: amount,
      date: date
    );

    // log.i(newTransaction.toString());
    setState(() { _transactions.add(newTransaction); });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) { return transaction.id == id; });
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (builder) {
      return TransactionForm(addNewTransaction: _addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recalculated for every time flutter rebuilds the UI
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: const Text('Expenses App'), // AppBar title property
      trailing: Row(
        mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
          // No IconButton for IOS, we have to make a custom Widget
          GestureDetector(
            onTap: () { _startAddNewTransaction(context); },
            child: const Icon(CupertinoIcons.add),
          )
      ],
      ), // AppBar actions property
    ) 
    : AppBar(
      title: const Text('Expenses App'),
      actions: [
        IconButton(onPressed: () => _startAddNewTransaction(context), icon: const Icon(Icons.add))
      ],
    ) as PreferredSizeWidget;
    
    final double availableSpace = 
      mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;
    
    final SizedBox transactionList = SizedBox(
      height: availableSpace * (isLandscape ? 0.8 : 0.7),
      child: TransactionList(transactions: _transactions, deleteTransaction: _deleteTransaction)
    );
    
    final SizedBox transactionChart = SizedBox(
      height: availableSpace * (isLandscape ? 0.8 : 0.3),
      child: TransactionChart(recentTransactions: _recentTransactions)
    );

    final Widget scaffoldBody = SafeArea( // Avoids operating system interfaces (useful on IOS)
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) SizedBox(
              height: availableSpace * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart', style: Theme.of(context).textTheme.titleLarge,),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showTransactionChart, onChanged: (value) {
                    setState(() { _showTransactionChart = value; });
                  }),
                ],
              ),
            ),
            if(isLandscape) _showTransactionChart ? transactionChart : transactionList,
            if(!isLandscape) transactionChart,
            if(!isLandscape) transactionList,            
          ]
        ),
      ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(
      child: scaffoldBody) 
      : Scaffold(
        appBar: appBar,
        body: scaffoldBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Platform.isIOS ? const SizedBox() :
        FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
        ),
    );
  }
}
import 'package:expenses_app/widgets/transaction_chart/transaction_chart.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
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
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSwatch(primarySwatch: Colors.deepPurple)
          .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
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
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final AppBar appBar = AppBar(
      title: const Text('Expenses App'),
      actions: [
        IconButton(onPressed: () => _startAddNewTransaction(context), icon: const Icon(Icons.add))
      ],
    );
    
    final double availableSpace = 
      MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    
    final SizedBox transactionList = SizedBox(
      height: availableSpace * (isLandscape ? 0.8 : 0.7),
      child: TransactionList(transactions: _transactions, deleteTransaction: _deleteTransaction)
    );
    
    final SizedBox transactionChart = SizedBox(
      height: availableSpace * (isLandscape ? 0.8 : 0.3),
      child: TransactionChart(recentTransactions: _recentTransactions)
    );


    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) SizedBox(
              height: availableSpace * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Show Chart'),
                  Switch(value: _showTransactionChart, onChanged: (value) {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester/data/shared_prefs.dart';
import 'package:tester/widget/chart.dart';
import 'package:tester/widget/new_transactions.dart';
import 'package:tester/widget/transaction_list.dart';

import 'models/transaction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //init Shared Prefs
  SharedPref sharedPref = SharedPref();

  void loadSharedPrefs() async {
    try {
      List<Transaction> transactions = await sharedPref.read();
      setState(() {
        _userTransactions.addAll(transactions);
      });
    } catch (Excepetion) {
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }


  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Groceries',
    //     amount: 16.52,
    //     date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
            (tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) async {
    try{
      final newTx = Transaction(id: DateTime.now().toString(),
          title: txTitle,
          amount: txAmount,
          date: txDate);
      await sharedPref.save(newTx.id, newTx);
      // Scaffold.of(context).showSnackBar(SnackBar(
      //     content: new Text("Saved!"),
      //     duration: const Duration(milliseconds: 500)));
      setState(() {
        _userTransactions.add(newTx);
      });
    }
    catch (e){
      print("$e");
    }
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction);
    });
  }

  void _deleteTransaction(String id) async {
    await sharedPref.remove(id);
    setState((){
      _userTransactions.removeWhere((tx) => tx.id == id );
      });
  }

  @override
  Widget build(BuildContext context) {
    print(_userTransactions);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker App'),

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tester/models/transaction.dart';

class SharedPref {
  Future<List<Transaction>> read() async {
    final prefs = await SharedPreferences.getInstance();
    var allEntries = prefs.getKeys();
    List<Transaction> storedTx = [];
    for (String entry in allEntries) {
     print("map values ${entry}");
     var value = prefs.getString(entry);
     Transaction tx = Transaction.fromJson(jsonDecode(value!));
     storedTx.add(tx);
    }
    return storedTx;
  }

  save(String id, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(id, json.encode(value));
  }

  remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(id);
  }
}
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    // late String titleInput;
    // late String amountInput;
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value){
              //   titleInput = value;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
            ),
            FlatButton(child: Text('Add Transaction'), onPressed: () {
              addNewTransaction(titleController.text, double.parse(amountController.text));
            }, textColor: Colors.purple,)
          ],
        ),
      ),
    );
  }
}

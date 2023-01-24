import './new_Transaction.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: 387,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text('${transactions[index].title}'),
              subtitle: Text(
                  '${DateFormat.yMMMEd().format(transactions[index].date)}'),
              trailing: IconButton(
                onPressed: (() => deleteTx(transactions[index].id)),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

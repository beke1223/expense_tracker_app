import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function? addTx;
  final Function? delTx;
  const NewTransaction({super.key, this.addTx, this.delTx});
  // NewTransaction.deleting();

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  Future _showCustomDialog(String msg, Widget? add) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('$msg'),
            actions: [
              Container(child: add),
              TextButton(
                  onPressed: (() => Navigator.pop(context)), child: Text("Ok"))
            ],
          );
        });
  }

  _Submitdate() async {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;

    if (enteredTitle.isEmpty &&
        enteredAmount.isEmpty &&
        _selectedDate == null) {
      _showCustomDialog("Title Amount and Date needed", null);
    } else if (enteredTitle.isEmpty &&
        enteredAmount.isNotEmpty &&
        _selectedDate != null) {
      _showCustomDialog(
          "What are You going to Buy",
          TextField(
            controller: _titleController,
          ));
    } else if (enteredTitle.isNotEmpty &&
        enteredAmount.isEmpty &&
        _selectedDate != null) {
      _showCustomDialog(
          "How much is $enteredTitle",
          TextField(
            controller: _amountController,
          ));
    } else if (enteredTitle.isNotEmpty &&
        enteredAmount.isNotEmpty &&
        _selectedDate == null) {
      _showCustomDialog(
          "When are You going to buy ?",
          TextButton(
              onPressed: _presentDatePicker, child: Text('Select Date')));
    } else {
      widget.addTx!(enteredTitle, double.parse(enteredAmount), _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onFieldSubmitted: (_) => _Submitdate(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: _amountController,
                validator: (value) =>
                    value == null ? 'how much is $_titleController' : null,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) => _Submitdate(),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(_selectedDate == null
                          ? 'No Date Choosen !'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate!)}')),
                  Expanded(
                      child: TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text('Choose Date'))),
                  FittedBox(
                      child: TextButton(
                          onPressed: _Submitdate,
                          child: const Text("Add Transaction"))),
                ],
              )
            ],
          ),
        ));
  }
}

//TODO:  Add Validator to The input fields
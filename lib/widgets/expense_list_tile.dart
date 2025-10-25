import 'package:flutter/material.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  final String name;
  final String amount;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
      trailing: Text(
        amount,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

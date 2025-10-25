import 'package:expense_tracker/bar_graph/my_bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyExpenseSummary extends StatelessWidget {
  const MyExpenseSummary({super.key, required this.startOfWeek});
  final DateTime startOfWeek;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return SizedBox(
          height: 200.h,
          child: MyBarGraph(
            satAmount: 10,
            sunAmount: 20,
            monAmount: 30,
            tueAmount: 40,
            wedAmount: 50,
            thurAmount: 60,
            friAmount: 70,
            maxY: 100,
          ),
        );
      },
    );
  }
}

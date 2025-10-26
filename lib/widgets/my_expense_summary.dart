import 'package:expense_tracker/bar_graph/my_bar_graph.dart';
import 'package:expense_tracker/data/date_time_helper.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyExpenseSummary extends StatelessWidget {
  const MyExpenseSummary({super.key, required this.startOfWeek});
  final DateTime startOfWeek;
  @override
  Widget build(BuildContext context) {
    String saturday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 0)),
    );
    String sunday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 1)),
    );
    String monday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 2)),
    );
    String tuesday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 3)),
    );
    String wednesday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 4)),
    );
    String thursday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 5)),
    );
    String friday = DateTimeHelper().convertDateTimeToString(
      startOfWeek.add(Duration(days: 6)),
    );
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return SizedBox(
          height: 200.h,
          child: MyBarGraph(
            satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
            monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
            tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
            wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
            thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
            friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
            maxY: 100,
          ),
        );
      },
    );
  }
}

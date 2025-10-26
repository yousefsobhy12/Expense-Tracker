import 'package:expense_tracker/data/date_time_helper.dart';
import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/widgets.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseModel> overallExpenseList = [];

  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // get expense list
  List<ExpenseModel> getAllExpenses() {
    return overallExpenseList;
  }

  // add new expenses
  void addExpense(ExpenseModel newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(ExpenseModel expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (Sat, Sun, Mon, etc...) from a date time object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Sat';
      case 2:
        return 'Sun';
      case 3:
        return 'Mon';
      case 4:
        return 'Tue';
      case 5:
        return 'Wed';
      case 6:
        return 'Thu';
      case 7:
        return 'Fri';
      default:
        return '';
    }
  }

  // get the date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sat') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = DateTimeHelper().convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}

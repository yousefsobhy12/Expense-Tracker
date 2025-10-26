import 'package:expense_tracker/models/expense_model.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;

class HiveDatabase {
  // reference to my box
  final myBox = Hive.box('expenses_database');

  void saveData(List<ExpenseModel> allExpenses) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpenses) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];

      allExpensesFormatted.add(expenseFormatted);
    }
    myBox.put('all_expenses', allExpensesFormatted);
  }

  List<ExpenseModel> readData() {
    List savedExpenses = myBox.get('all_expenses') ?? [];
    List<ExpenseModel> allExpenses = [];

    for (var i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseModel expense = ExpenseModel(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}

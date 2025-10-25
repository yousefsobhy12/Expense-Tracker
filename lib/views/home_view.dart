import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Add new Expense',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              hint: 'Enter expense name',
              controller: expenseNameController,
            ),
            SizedBox(height: 4),
            CustomTextFormField(
              hint: 'Enter the amount',
              controller: expenseAmountController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                CustomElevatedButton(
                  onPressed: save,
                  title: 'Save',
                  backgroundColor: Colors.black,
                  titleColor: Colors.white,
                ),

                SizedBox(width: 8),
                CustomElevatedButton(
                  onPressed: cancel,
                  title: 'Cancel',
                  backgroundColor: Colors.white,
                  titleColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    ExpenseModel newExpense = ExpenseModel(
      name: expenseNameController.text,
      amount: expenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    expenseNameController.clear();
    expenseAmountController.clear();
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text('Expense Tracker')),
          body: ListView.builder(
            itemCount: value.overallExpenseList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value.getAllExpenses()[index].name),
                subtitle: Text(
                  value.getAllExpenses()[index].dateTime.toString(),
                ),
                trailing: Text('${value.getAllExpenses()[index].amount} L.E'),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: Icon(Icons.add_rounded, size: 30, color: Colors.white),
          ),
        );
      },
    );
  }
}

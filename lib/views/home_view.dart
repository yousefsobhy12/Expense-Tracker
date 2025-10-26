import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_text_form_field.dart';
import 'package:expense_tracker/widgets/expense_list_tile.dart';
import 'package:expense_tracker/widgets/my_expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    super.initState();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Add new Expense',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                hint: 'Enter expense name',
                controller: expenseNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expense name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 6),
              CustomTextFormField(
                hint: 'Enter the amount',
                controller: expenseAmountController,
                isNumeric: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
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
      ),
    );
  }

  void deleteExpense(ExpenseModel expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    if (expenseNameController.text.isEmpty ||
        expenseAmountController.text.isEmpty) {
      return;
    }

    try {
      double.parse(expenseAmountController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid number for amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
          body: ListView(
            children: [
              MyExpenseSummary(startOfWeek: value.startOfWeekDate()),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.overallExpenseList.length,
                itemBuilder: (context, index) {
                  return ExpenseListTile(
                    name: value.getAllExpenses()[index].name,
                    amount: '${value.getAllExpenses()[index].amount} L.E',
                    dateTime: value.getAllExpenses()[index].dateTime,
                    onDelete: (unnamed) {
                      deleteExpense(value.getAllExpenses()[index]);
                    },
                  );
                },
              ),
            ],
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

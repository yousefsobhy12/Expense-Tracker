import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(hint: 'Enter expense name'),
            SizedBox(height: 4),
            CustomTextFormField(hint: 'Enter the amount'),
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

  void save() {}
  void cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Expense Tracker')),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        backgroundColor: Colors.black,
        child: Icon(Icons.add_rounded, size: 30, color: Colors.white),
      ),
    );
  }
}

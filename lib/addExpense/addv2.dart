// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:myapp/addExpense/addExpenseServices.dart';

// class AddExpenseScreen extends StatefulWidget {
//   final Function(String, String, String) onAddExpense;

//   const AddExpenseScreen({super.key, required this.onAddExpense});

//   @override
//   _AddExpenseScreenState createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _amountController = TextEditingController();
//   final ExpenseService _expenseService = ExpenseService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Expense'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Expense Name'),
//             ),
//             TextField(
//               controller: _categoryController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Category'),
//             ),
//             TextField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final name = _nameController.text;
//                 final category = (_categoryController.text);
//                 final amount = (_amountController.text);

//                 log("calling On Pressed");
//                 if (name.isNotEmpty || category.isNotEmpty || amount.isEmpty) {
//                   log("calling add expense");
//                   var status =
//                       await _expenseService.addExpense(name, category, amount);
//                   log("Value of status is $status");
//                   if (status == true) {
//                     log("calling add expense");

//                     widget.onAddExpense(name, category, amount);
//                   }
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text('Add Expense'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//1111111111111111111111111111111111111
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:myapp/addExpense/addExpenseServices.dart';

// class AddExpenseScreen extends StatefulWidget {
//   final Function(String, String, String, String) onAddTransaction;

//   const AddExpenseScreen({super.key, required this.onAddTransaction});

//   @override
//   _AddExpenseScreenState createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _amountController = TextEditingController();
//   final ExpenseService _expenseService = ExpenseService();
//   String _transactionType = 'expense'; // Default to expense

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Transaction'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _transactionType = 'income';
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _transactionType == 'income'
//                         ? Colors.green
//                         : Colors.grey,
//                   ),
//                   child: const Text('Income'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _transactionType = 'expense';
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _transactionType == 'expense'
//                         ? Colors.red
//                         : Colors.grey,
//                   ),
//                   child: const Text('Expense'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Transaction Name'),
//             ),
//             TextField(
//               controller: _categoryController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Category'),
//             ),
//             TextField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final name = _nameController.text;
//                 final category = _categoryController.text;
//                 final amount = _amountController.text;

//                 log("calling On Pressed");
//                 if (name.isNotEmpty || category.isNotEmpty || amount.isEmpty) {
//                   log("calling add transaction");
//                   var status = await _expenseService.addExpense(
//                       name, category, amount, _transactionType);
//                   log("Value of status is $status");
//                   if (status == true) {
//                     widget.onAddTransaction(name, category, amount, _transactionType);
//                   }
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text('Add Transaction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //2222222222222222222222222222222222
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AddExpenseScreen extends StatefulWidget {
//   final Function(String title, String category, String amount, String type, DateTime dateTime) onAddTransaction;

//   const AddExpenseScreen({super.key, required this.onAddTransaction});

//   @override
//   _AddExpenseScreenState createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
  
//   DateTime? selectedDateTime;
//   String transactionType = 'expense'; // Default type

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Expense'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Toggle between Income and Expense
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ChoiceChip(
//                   label: const Text('Expense'),
//                   selected: transactionType == 'expense',
//                   onSelected: (selected) {
//                     if (selected) {
//                       setState(() {
//                         transactionType = 'expense';
//                       });
//                     }
//                   },
//                 ),
//                 ChoiceChip(
//                   label: const Text('Income'),
//                   selected: transactionType == 'income',
//                   onSelected: (selected) {
//                     if (selected) {
//                       setState(() {
//                         transactionType = 'income';
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Title Field
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//             ),
//             const SizedBox(height: 16),
//             // Category Field
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category'),
//             ),
//             const SizedBox(height: 16),
//             // Amount Field
//             TextField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16),
//             // Date and Time Picker
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: _selectDateTime,
//                   child: Column(
//                     children: [
//                       const Icon(Icons.calendar_today),
//                       Text(selectedDateTime == null
//                           ? 'Select Date'
//                           : DateFormat('yyyy-MM-dd').format(selectedDateTime!)),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: _selectDateTime,
//                   child: Column(
//                     children: [
//                       const Icon(Icons.access_time),
//                       Text(selectedDateTime == null
//                           ? 'Select Time'
//                           : DateFormat('hh:mm a').format(selectedDateTime!)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Submit Button
//             ElevatedButton(
//               onPressed: _addTransaction,
//               child: const Text('Add Transaction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDateTime() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDateTime ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null) {
//       TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   void _addTransaction() {
//     String title = _titleController.text.trim();
//     String category = _categoryController.text.trim();
//     String amount = _amountController.text.trim();

//     if (title.isNotEmpty && category.isNotEmpty && amount.isNotEmpty && selectedDateTime != null) {
//       widget.onAddTransaction(title, category, amount, transactionType, selectedDateTime!);
//       Navigator.pop(context); // Close the screen
//     } else {
//       // Handle validation error (e.g., show a snackbar)
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields and select a date/time.')),
//       );
//     }
//   }
// }

// 33333333333333333333333333333333333

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  final Function(String title, String category, String amount, String type, DateTime dateTime) onAddTransaction;

  const AddExpenseScreen({super.key, required this.onAddTransaction});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  DateTime? selectedDateTime;
  String transactionType = 'expense'; // Default type
  String? selectedCategory;
  
  // List of categories for the dropdown
  final List<String> categories = [
    'Food',
    'Stationary',
    'Grocery',
    'Entertainment',
    'Transport',
    'Rent',
    'Utilities',
    'Healthcare',
    'Education',
    'Miscellaneous',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle between Income and Expense
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  label: const Text('Expense'),
                  selected: transactionType == 'expense',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        transactionType = 'expense';
                      });
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Income'),
                  selected: transactionType == 'income',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        transactionType = 'income';
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Title Field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Amount Field
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            // Date and Time Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _selectDateTime,
                  child: Column(
                    children: [
                      const Icon(Icons.calendar_today),
                      Text(selectedDateTime == null
                          ? 'Select Date'
                          : DateFormat('yyyy-MM-dd').format(selectedDateTime!)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _selectDateTime,
                  child: Column(
                    children: [
                      const Icon(Icons.access_time),
                      Text(selectedDateTime == null
                          ? 'Select Time'
                          : DateFormat('hh:mm a').format(selectedDateTime!)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Submit Button
            ElevatedButton(
              onPressed: _addTransaction,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _addTransaction() {
    String title = _titleController.text.trim();
    String category = selectedCategory ?? '';
    String amount = _amountController.text.trim();

    if (title.isNotEmpty && category.isNotEmpty && amount.isNotEmpty && selectedDateTime != null) {
      widget.onAddTransaction(title, category, amount, transactionType, selectedDateTime!);
      Navigator.pop(context); // Close the screen
    } else {
      // Handle validation error (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields and select a date/time.')),
      );
    }
  }
}

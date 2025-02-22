// import 'package:flutter/material.dart';
// import 'models.dart';
// import 'create_expense_screen.dart';
//
// class GroupDetailsScreen extends StatefulWidget {
//   final Group group;
//
//   GroupDetailsScreen({required this.group});
//
//   @override
//   _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
// }
//
// class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.group.name),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Theme.of(context).primaryColor, Colors.teal.shade100],
//           ),
//         ),
//         child: widget.group.expenses.isEmpty
//             ? Center(
//           child: Text(
//             'No expenses yet. Add one!',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         )
//             : ListView.builder(
//           itemCount: widget.group.expenses.length,
//           itemBuilder: (context, index) {
//             final expense = widget.group.expenses[index];
//             return Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 title: Text(
//                   expense.title,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 subtitle: Text(
//                   'Paid by: ${expense.paidBy}',
//                   style: Theme.of(context).textTheme.titleSmall,
//                 ),
//                 trailing: Text(
//                   '\$${expense.amount.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).hintColor,
//                   ),
//                 ),
//                 onTap: () {
//                   _showExpenseDetails(expense);
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addNewExpense();
//         },
//         child: Icon(Icons.add),
//         tooltip: 'Add New Expense',
//       ),
//     );
//   }
//
//   void _addNewExpense() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CreateExpenseScreen(members: widget.group.members),
//       ),
//     );
//
//     if (result != null) {
//       setState(() {
//         widget.group.expenses.add(result);
//       });
//     }
//   }
//
//   void _showExpenseDetails(Expense expense) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 expense.title,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Total Amount: \$${expense.amount.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Paid by: ${expense.paidBy}',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Splits:',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               ...expense.splits.entries.map((entry) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(entry.key),
//                       Text('\$${entry.value.toStringAsFixed(2)}'),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'gruop_satus_board.dart';
import 'models.dart';
import 'create_expense_screen.dart';
import 'gruop_satus_board.dart';

class GroupDetailsScreen extends StatefulWidget {
  final Group group;

  GroupDetailsScreen({required this.group});

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupStatusBoard(group: widget.group),
                ),
              );
            },
            tooltip: 'View Status Board',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor, Colors.teal.shade100],
          ),
        ),
        child: widget.group.expenses.isEmpty
            ? Center(
          child: Text(
            'No expenses yet. Add one!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
            : ListView.builder(
          itemCount: widget.group.expenses.length,
          itemBuilder: (context, index) {
            final expense = widget.group.expenses[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Paid by: ${expense.paidBy}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  _showExpenseDetails(expense);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewExpense();
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Expense',
      ),
    );
  }

  void _addNewExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateExpenseScreen(members: widget.group.members),
      ),
    );

    if (result != null) {
      setState(() {
        widget.group.expenses.add(result);
      });
    }
  }

  void _showExpenseDetails(Expense expense) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(
                'Total Amount: \$${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Paid by: ${expense.paidBy}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Splits:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ...expense.splits.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text('\$${entry.value.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:myapp/addExpense/addExpenseServices.dart';
// import 'package:myapp/auth/auth_service.dart';
// import 'package:myapp/addExpense/addv2.dart';
// import 'package:myapp/homeScreen/homeScreenServices.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double expenses = 0;
//   double income = 0;
//   double balance = 0;
//   final _auth = AuthService();
//   final HomeService _homeService = HomeService();
//   final ExpenseService _expenseService = ExpenseService();
//   final UserService _userService = UserService();

//   List<Map<String, dynamic>> transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     _loadExpensesFromFirebase();
//   }

//   Future<void> _loadUserData() async {
//     Map<String, dynamic>? userData = await _userService.getUserData();
//     print("userData = $userData");

//     // Ensure print statements are formatted correctly
//     if (userData != null) {
//       print("User Data Balance = ${userData['balance']}");

//       setState(() {
//         balance = double.parse( userData['balance']);
//         print("User Data Balance = $balance");
//         income = (userData['income'] as num).toDouble();
//       });
//     } else {
//       print("User data is null.");
//     }
//   }

//   Future<void> _loadExpensesFromFirebase() async {
//     List<Map<String, dynamic>> fetchedExpenses =
//         await _homeService.fetchUserExpenses();

//     double totalExpenses = 0;
//     for (var expense in fetchedExpenses) {
//       var amount = expense['amount'];
//       if (amount is num) {
//         totalExpenses += amount.toDouble();
//       } else if (amount is String) {
//         totalExpenses += double.parse(amount);
//       }
//     }

//     setState(() {
//       transactions = fetchedExpenses;
//       expenses = totalExpenses;
//       balance -= totalExpenses;
//     });
//   }

//   void _addExpense(String title, String category, String amount) async {
//     await _expenseService.addExpense(title, category, amount);
//     double expenseAmount = double.parse(amount);
//     setState(() {
//       transactions
//           .add({'title': title, 'category': category, 'amount': expenseAmount});
//       expenses += expenseAmount;
//       balance -= expenseAmount;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 8, 141, 202),
//         leading: const Icon(Icons.currency_rupee_sharp, color: Colors.white),
//         title: const Text(
//           'Rupees',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white70),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout_rounded,
//                 color: Color.fromARGB(179, 229, 56, 53)),
//             onPressed: () {
//               _auth.signout();
//             },
//           ),
//         ],
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[700]!, Colors.blue[900]!],
//           ),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
//             _buildBalanceCard(),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = transactions[index];
//                   return _buildTransactionCard(
//                     transaction['title'],
//                     transaction['category'].toString(),
//                     transaction['amount'].toString(),
//                     Colors.green,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           await Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => AddExpenseScreen(onAddExpense: _addExpense),
//           ));
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add new'),
//         backgroundColor: Colors.blue,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assessment),
//             label: 'Report',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Widget _buildBalanceCard() {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               'Current Balance',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '₹${balance.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 24, color: Colors.green),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildSummaryItem('Income', income, Colors.blue),
//                 _buildSummaryItem('Expenses', expenses, Colors.red),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryItem(String label, double amount, Color color) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 14),
//         ),
//         SizedBox(height: 4),
//         Text(
//           '₹${amount.toStringAsFixed(2)}',
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.bold, color: color),
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionCard(
//       String title, String subtitle, String amount, Color iconColor) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor,
//           child: const Icon(Icons.shopping_cart, color: Colors.white),
//         ),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: Text(
//           '-₹$amount',
//           style:
//               const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
// 1111111111111111111111111111111111111111111111111111111111111111111111

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/addExpense/addExpenseServices.dart';
// import 'package:myapp/auth/auth_service.dart';
// import 'package:myapp/addExpense/addv2.dart'; // Importing the updated AddExpenseScreen
// import 'package:myapp/homeScreen/homeScreenServices.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double expenses = 0;
//   double income = 0;
//   double balance = 0;
//   final _auth = AuthService();
//   final HomeService _homeService = HomeService();
//   final ExpenseService _expenseService = ExpenseService();
//   final UserService _userService = UserService();

//   List<Map<String, dynamic>> transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     _loadExpensesFromFirebase();
//     _loadIncomeFromFirebase();
//     _sortTransactionsByTime(transactions);
//   }

//   Future<void> _loadUserData() async {
//     Map<String, dynamic>? userData = await _userService.getUserData();
//     print("userData = $userData");

//     if (userData != null) {
//       setState(() {
//         balance = double.parse(userData['balance']);
//       });
//     } else {
//       print("User data is null.");
//     }
//   }

//   Future<void> _loadExpensesFromFirebase() async {
//     List<Map<String, dynamic>> fetchedExpenses =
//         await _homeService.fetchUserExpenses();

//     double totalExpenses = 0;
//     for (var expense in fetchedExpenses) {
//       var amount = expense['amount'];
//       if (amount is num) {
//         totalExpenses += amount.toDouble();
//       } else if (amount is String) {
//         totalExpenses += double.parse(amount);
//       }
//     }

//     setState(() {
//       transactions = fetchedExpenses;
//       expenses = totalExpenses;
//       balance -= totalExpenses;
//     });
//   }

//   Future<void> _loadIncomeFromFirebase() async {
//     List<Map<String, dynamic>> fetchedIncome = await _homeService
//         .fetchUserIncome(); // Assuming you have fetchUserIncome implemented

//     double totalIncome = 0;
//     for (var income in fetchedIncome) {
//       var amount = income['amount'];
//       if (amount is num) {
//         totalIncome += amount.toDouble();
//       } else if (amount is String) {
//         totalIncome += double.parse(amount);
//       }
//     }

//     setState(() {
//       transactions.addAll(
//           fetchedIncome); // Adding income transactions to the list of transactions
//       income = totalIncome;
//       balance += totalIncome; // Updating balance by adding income
//     });
//   }

//   void _sortTransactionsByTime(List<Map<String, dynamic>> transactions) {
//     transactions.sort((a, b) {
//       DateTime dateA = (a['timestamp'] as Timestamp).toDate();
//       DateTime dateB = (b['timestamp'] as Timestamp).toDate();
//       return dateB.compareTo(dateA); // Sort in descending order (latest first)
//     });
//   }

//   void _addTransaction(String title, String category, String amount,
//       String type, DateTime dateTime) async {
//     await _expenseService.addExpense(title, category, amount, type, dateTime);
//     double transactionAmount = double.parse(amount);

//     setState(() {
//       transactions.add({
//         'title': title,
//         'category': category,
//         'amount': transactionAmount,
//         'timestamp': dateTime // Adding the date and time to the transaction
//       });

//       if (type == 'expense') {
//         expenses += transactionAmount;
//         balance -= transactionAmount;
//       } else if (type == 'income') {
//         income += transactionAmount;
//         balance += transactionAmount;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 8, 141, 202),
//         leading: const Icon(Icons.currency_rupee_sharp, color: Colors.white),
//         title: const Text(
//           'Rupees',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout_rounded,
//                 color: Color.fromARGB(179, 229, 56, 53)),
//             onPressed: () {
//               _auth.signout();
//             },
//           ),
//         ],
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[700]!, Colors.blue[900]!],
//           ),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
//             _buildBalanceCard(),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = transactions[index];
//                   return _buildTransactionCard(
//                     transaction['title'],
//                     transaction['category'].toString(),
//                     transaction['amount'].toString(),
//                     transaction['timestamp'].toString(), // Retrieving the date,
//                     Colors.green,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           await Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => AddExpenseScreen(
//                 onAddTransaction:
//                     _addTransaction), // Passing _addTransaction with DateTime
//           ));
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add new'),
//         backgroundColor: Colors.blue,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assessment),
//             label: 'Report',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Widget _buildBalanceCard() {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               'Current Balance',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '₹${balance.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 24, color: Colors.green),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildSummaryItem('Income', income, Colors.blue),
//                 _buildSummaryItem('Expenses', expenses, Colors.red),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryItem(String label, double amount, Color color) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           '₹${amount.toStringAsFixed(2)}',
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.bold, color: color),
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionCard(String title, String subtitle, String amount,
//       String timestamp, Color iconColor) {
//     // String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(timestamp)); // Formatting the timestamp
//     String formattedDate = timestamp; // Formatting the timestamp
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor,
//           child: const Icon(Icons.shopping_cart, color: Colors.white),
//         ),
//         title: Text(title),
//         subtitle: Text('$subtitle\n$formattedDate'), // Showing the date
//         trailing: Text(
//           '-₹$amount',
//           style:
//               const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tt/addExpense/addExpenseServices.dart';
import 'package:tt/auth/auth_service.dart';
import 'package:tt/addExpense/addv2.dart';
// ignore: unused_import
import 'package:tt/group/group_home_screen.dart';
import 'package:tt/homeScreen/homeScreenServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double expenses = 0;
  double income = 0;
  double balance = 0;
  final _auth = AuthService();
  final HomeService _homeService = HomeService();
  final ExpenseService _expenseService = ExpenseService();
  final UserService _userService = UserService();

  List<Map<String, dynamic>> transactions = [];
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadExpensesFromFirebase();
    _sortTransactionsByTime(transactions);
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await _userService.getUserData();
    if (userData != null) {
      setState(() {
        balance = double.parse(userData['balance']);
        username = userData['username'];
      });
    }
  }

  Future<void> _loadExpensesFromFirebase() async {
    List<Map<String, dynamic>> fetchedExpenses =
        await _homeService.fetchUserExpenses();

    double totalExpense = 0;
    double totalIncome = 0;
    for (var expense in fetchedExpenses) {
      var amount = expense['amount'];
      if (expense['type'] == 'expense') {
        if (amount is num) {
          totalExpense += amount.toDouble();
        } else if (amount is String) {
          totalExpense += double.parse(amount);
        }
      } else {
        if (amount is num) {
          totalIncome -= amount.toDouble();
        } else if (amount is String) {
          totalIncome -= double.parse(amount);
        }
      }
    }

    setState(() {
      transactions.addAll(fetchedExpenses);
      expenses = totalExpense;
      balance -= totalExpense;
      balance += totalIncome;
      income = totalIncome;
    });
  }

  void _sortTransactionsByTime(List<Map<String, dynamic>> transactions) {
    transactions.sort((a, b) {
      DateTime dateA = (a['timestamp'] as Timestamp).toDate();
      DateTime dateB = (b['timestamp'] as Timestamp).toDate();
      return dateB.compareTo(dateA);
    });
  }

  Future<void> _addTransaction(String title, String category, String amount,
      String type, DateTime dateTime) async {
    await _expenseService.addExpense(title, category, amount, type, dateTime);
    double transactionAmount = double.parse(amount);
    List<Map<String, dynamic>> fetchedExpenses =
        await _homeService.fetchUserExpenses();

    setState(() {
      transactions = fetchedExpenses;
      if (type == 'expense') {
        expenses += transactionAmount;
        balance -= transactionAmount;
      } else {
        income += transactionAmount;
        balance += transactionAmount;
      }
    });
  }

  // Function to delete a transaction from Firebase
  Future<void> _deleteTransaction(String id, int index) async {
    await _homeService
        .deleteExpense(id); // Implement this in your service layer

    // Remove the transaction from the list after deletion
    setState(() {
      if (transactions[index]['type'] == 'expense') {
        expenses -= transactions[index]['amount'];
        balance += transactions[index]['amount'];
      } else {
        income -= transactions[index]['amount'];
        balance -= transactions[index]['amount'];
      }
      transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 141, 202),
        leading: const Icon(Icons.currency_rupee_sharp, color: Colors.white),
        title: const Text(
          'Rupees',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                username != null ? username! : 'Guest',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded,
                color: Color.fromARGB(179, 229, 56, 53)),
            onPressed: () {
              _auth.signout();
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[900]!],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildBalanceCard(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildTransactionCard(
                    transaction['id'], // Add ID for deletion
                    transaction['title'],
                    transaction['category'].toString(),
                    transaction['amount'].toString(),
                    transaction['type'].toString(),
                    transaction['timestamp'].toString(),
                    index, // Pass the index for removing from the list
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AddExpenseScreen(onAddTransaction: _addTransaction),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add new'),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group',
          ),
        ],
        // onTap: (index) {
        //   if (index == 0) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ReportPage()),
        //     );
        //   }
        // },
        // onTap: (index) {
        //   if (index == 2) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => groupHomeScreen()), // Group Screen
        //     );
        //   }
        // },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Current Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Income', income, Colors.green),
                _buildSummaryItem('Expenses', expenses, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(
    String id,
    String title,
    String subtitle,
    String amount,
    String type,
    String timestamp,
    int index,
  ) {
    String formattedDate = timestamp;
    Color textColor = type == 'expense' ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: textColor,
          child: const Icon(Icons.shopping_cart, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text('$subtitle\n$formattedDate'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '₹$amount',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await _deleteTransaction(id, index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

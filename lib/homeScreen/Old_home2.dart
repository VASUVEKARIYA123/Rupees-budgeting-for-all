// import 'package:flutter/material.dart';
// import 'package:myapp/addExpense/addv2.dart';
// import 'package:myapp/homeScreen/homeScreenServices.dart';
// import 'package:myapp/addExpense/addExpenseServices.dart';

// import 'package:myapp/auth/auth_service.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double expenses = 0;
//   int income = 50000;
//   double balance = 0;
//   final _auth = AuthService();
//   final HomeService _homeScreenService = HomeService();
//   final ExpenseService _expenseService = ExpenseService();

//   List<Map<String, dynamic>> transactions = [];

//   // Category mapping
//   Map<int, Map<String, dynamic>> categoryMap = {
//     0: {
//       'name': 'Groceries',
//       'icon': Icons.shopping_cart,
//       'color': Colors.green,
//     },
//     1: {
//       'name': 'Health',
//       'icon': Icons.local_hospital,
//       'color': Colors.red,
//     },
//     2: {
//       'name': 'Food',
//       'icon': Icons.fastfood,
//       'color': Colors.orange,
//     },
//     3: {
//       'name': 'Transport',
//       'icon': Icons.directions_car,
//       'color': Colors.blue,
//     },
//     4: {
//       'name': 'Entertainment',
//       'icon': Icons.movie,
//       'color': Colors.purple,
//     },
//     // Add more categories as needed
//   };

//   @override
//   void initState() {
//     super.initState();
//     _loadExpensesFromFirebase();
//   }

//   Future<void> _loadExpensesFromFirebase() async {
//     // Fetch expenses from Firestore
//     List<Map<String, dynamic>> fetchedExpenses =
//         await _homeScreenService.fetchUserExpenses();

//     // Calculate total expenses and balance
//     double totalExpenses = 0;
//     for (var expense in fetchedExpenses) {
//       var amount = expense['amount'];

//       // Ensure amount is handled as an int
//       if (amount is int) {
//         totalExpenses += amount;
//       } else if (amount is String) {
//         totalExpenses += int.parse(amount);
//       }
//     }

//     setState(() {
//       transactions = fetchedExpenses;
//       expenses = totalExpenses;
//       balance = balance - totalExpenses;
//     });
//   }

//   void _addExpense(String title, int category, double amount) async {
//     await _expenseService.addExpense(title, category, amount);
//     setState(() {
//       transactions
//           .add({'title': title, 'category': category, 'amount': amount});
//       expenses += (amount);
//       balance -= (amount);
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
//             Expanded(
//               child: ListView.builder(
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = transactions[index];

//                   // Since `transaction['category']` is already an integer, no need to parse
//                   int categoryNumber = transaction['category'];

//                   // Get category details
//                   var categoryDetails = categoryMap[categoryNumber] ??
//                       {
//                         'name': 'Unknown',
//                         'icon': Icons.help_outline,
//                         'color': Colors.grey,
//                       };

//                   return _buildTransactionCard(
//                     transaction['title'],
//                     categoryDetails['name'],
//                     transaction['amount'].toString(),
//                     categoryDetails['color'],
//                     categoryDetails['icon'],
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

//   Widget _buildTransactionCard(String title, String subtitle, String amount,
//       Color iconColor, IconData icon) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor,
//           child: Icon(icon, color: Colors.white),
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

// /* class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double expenses = 0;
//   double income = 50000;
//   double balance = 0;
//   String userName = "User"; // Placeholder for the user's name
//   final _auth = AuthService();
//   final ExpenseService _expenseService = ExpenseService();
//   final HomeService _HomeService = HomeService();

//   List<Map<String, dynamic>> transactions = [];

//   // Category mapping
//   Map<int, Map<String, dynamic>> categoryMap = {
//     0: {
//       'name': 'Groceries',
//       'icon': Icons.shopping_cart,
//       'color': Colors.green,
//     },
//     1: {
//       'name': 'Health',
//       'icon': Icons.local_hospital,
//       'color': Colors.red,
//     },
//     2: {
//       'name': 'Food',
//       'icon': Icons.fastfood,
//       'color': Colors.orange,
//     },
//     3: {
//       'name': 'Transport',
//       'icon': Icons.directions_car,
//       'color': Colors.blue,
//     },
//     4: {
//       'name': 'Entertainment',
//       'icon': Icons.movie,
//       'color': Colors.purple,
//     },
//   };

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _loadExpensesFromFirebase();
//   // }
//   final UserService _userService = UserService();

//   Future<void> _loadUserData() async {
//     // Fetch user data
//     Map<String, dynamic>? userData = await _userService.getUserData();

//     if (userData != null) {
//       setState(() {
//         userName = userData['displayName'];
//         balance = userData['balance'];
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadExpensesFromFirebase();
//     _loadUserData();
//   }

//   Future<void> _loadExpensesFromFirebase() async {
//     // Fetch expenses from Firestore
//     List<Map<String, dynamic>> fetchedExpenses =
//         await _HomeService.fetchUserExpenses();

//     // Calculate total expenses and balance
//     double totalExpenses = 0;
//     for (var expense in fetchedExpenses) {
//       var amount = expense['amount'];

//       // Ensure amount is handled as an int
//       if (amount is int) {
//         totalExpenses += amount;
//       } else if (amount is String) {
//         totalExpenses += int.parse(amount);
//       }
//     }

//     setState(() {
//       transactions = fetchedExpenses;
//       expenses = totalExpenses;
//       balance = balance - totalExpenses;
//     });
//   }

//   void _addExpense(String title, int category, double amount) async {
//     await _expenseService.addExpense(title, category, amount);
//     setState(() {
//       transactions
//           .add({'title': title, 'category': category, 'amount': amount});
//       expenses += amount;
//       balance -= amount;
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
//             _buildCreditCard(userName, balance), // Display Credit Card widget
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = transactions[index];

//                   // Since `transaction['category']` is already an integer, no need to parse
//                   int categoryNumber = transaction['category'];

//                   // Get category details
//                   var categoryDetails = categoryMap[categoryNumber] ??
//                       {
//                         'name': 'Unknown',
//                         'icon': Icons.help_outline,
//                         'color': Colors.grey,
//                       };

//                   return _buildTransactionCard(
//                     transaction['title'],
//                     categoryDetails['name'],
//                     transaction['amount'].toString(),
//                     categoryDetails['color'],
//                     categoryDetails['icon'],
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

//   // Function to build Credit Card-like widget
//   Widget _buildCreditCard(String userName, double balance) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         height: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             colors: [Colors.blue[300]!, Colors.blue[600]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Current Balance',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '₹$balance',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 userName,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionCard(String title, String subtitle, String amount,
//       Color iconColor, IconData icon) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor,
//           child: Icon(icon, color: Colors.white),
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
// */
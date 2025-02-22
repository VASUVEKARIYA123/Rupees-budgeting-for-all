// import 'package:flutter/material.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});
  
//   @override
//   _ReportPageState createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   DateTime selectedMonth = DateTime.now();
//   List<Map<String, dynamic>> monthlyExpenses = [];
//   double totalMonthlyExpenses = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadMonthlyExpenses(selectedMonth);
//   }

//   Future<void> _loadMonthlyExpenses(DateTime date) async {
//     List<Map<String, dynamic>> fetchedExpenses =
//         await .fetchMonthlyExpenses(date);

//     setState(() {
//       monthlyExpenses = fetchedExpenses;

//       // Calculate total monthly expenses
//       totalMonthlyExpenses = monthlyExpenses.fold(0, (sum, item) {
//         return sum + (item['amount'] is num
//             ? item['amount'].toDouble()
//             : double.parse(item['amount']));
//       });
//     });
//   }

//   void _toggleMonth(int offset) {
//     setState(() {
//       selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + offset);
//       _loadMonthlyExpenses(selectedMonth);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Monthly Report'),
//         backgroundColor: const Color.fromARGB(255, 8, 141, 202),
//       ),
//       body: Column(
//         children: [
//           _buildMonthSelector(),
//           const SizedBox(height: 16),
//           _buildStatsCard(),
//           const SizedBox(height: 16),
//           _buildExpensesList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMonthSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => _toggleMonth(-1),
//         ),
//         Text(
//           '${selectedMonth.month}/${selectedMonth.year}',
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_forward),
//           onPressed: () => _toggleMonth(1),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsCard() {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               'Total Expenses',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '₹${totalMonthlyExpenses.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 24, color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpensesList() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: monthlyExpenses.length,
//         itemBuilder: (context, index) {
//           final expense = monthlyExpenses[index];
//           return _buildExpenseCard(
//             expense['title'],
//             expense['category'],
//             expense['amount'].toString(),
//             expense['timestamp'].toDate(),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildExpenseCard(String title, String category, String amount, DateTime timestamp) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text('$category\n${timestamp.toLocal()}'),
//         trailing: Text('₹$amount', style: const TextStyle(color: Colors.red)),
//       ),
//     );
//   }
// }

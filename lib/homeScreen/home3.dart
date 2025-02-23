// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/homeScreen/homeScreenServices.dart';

class HomeScreen extends StatelessWidget {
  final String userId = 'L0NyCIHU2WNKD42Q8g03do5RBQH2';

  const HomeScreen({super.key}); // Example user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Financial Dashboard'),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fetch user balance from Firestore
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final UserService userService = UserService();
                  var balance = 130.5;
                  () async {
                    Map<String, dynamic>? userData =
                        await userService.getUserData();
                    balance = userData?['balance'];
                  };
                  var userDoc = snapshot.data!;

                  return _buildDashboardCard(balance);
                },
              ),
              const SizedBox(height: 16),

              // Fetch user transaction count from Firestore
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var userDoc = snapshot.data!;
                  var transactionCount = userDoc['transactionCount'] ?? 0;

                  return _buildWelcomeCard(transactionCount);
                },
              ),

              const SizedBox(height: 16),

              // Recent Transactions Header
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 8),

              // Fetch recent transactions from Firestore
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('transactions')
                    .orderBy('timestamp', descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var transactions = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = transactions[index];
                      return _buildTransactionTile(transaction);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for building the dashboard card with the user's balance
  Widget _buildDashboardCard(double balance) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.blue[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${balance.toStringAsFixed(1)}k',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  icon: Icons.call_made,
                  label: 'Withdraw',
                  backgroundColor: Colors.blue[700]!,
                  iconColor: Colors.white,
                ),
                _buildActionButton(
                  icon: Icons.call_received,
                  label: 'Deposit',
                  backgroundColor: Colors.green[300]!,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building the welcome card with user's transaction count
  Widget _buildWelcomeCard(int transactionCount) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, User 1',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$transactionCount',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            Text(
              'This month',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building each transaction tile
  Widget _buildTransactionTile(DocumentSnapshot transaction) {
    var amount = transaction['amount'];
    var category = transaction['category'];
    var isExpense = transaction['isExpense'];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[700],
        child: const Icon(
          Icons.account_balance_wallet,
          color: Colors.white,
        ),
      ),
      title: Text('Category: $category'),
      subtitle: Text(isExpense ? 'Expense' : 'Income'),
      trailing: Text(
        '${isExpense ? '-' : '+'} \$${amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: isExpense ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Action button widget for Withdraw and Deposit
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

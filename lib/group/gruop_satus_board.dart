import 'package:flutter/material.dart';
import 'models.dart';

class GroupStatusBoard extends StatelessWidget {
  final Group group;

  const GroupStatusBoard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    Map<String, double> balances = group.balances;
    List<MapEntry<String, double>> sortedBalances = balances.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text('${group.name} Status'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor, Colors.blue.shade300],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Group Balance Summary',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...sortedBalances.map((entry) => _buildBalanceRow(context, entry.key, entry.value)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Suggested Settlements',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ..._calculateSettlements(balances).map((settlement) => _buildSettlementRow(context, settlement)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceRow(BuildContext context, String name, double balance) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          Text(
            balance.toStringAsFixed(2),
            style: TextStyle(
              color: balance >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettlementRow(BuildContext context, Map<String, dynamic> settlement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(text: settlement['from'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' pays '),
                  TextSpan(text: settlement['to'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Text(
            '${settlement['amount'].toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _calculateSettlements(Map<String, double> balances) {
    List<MapEntry<String, double>> debtors = balances.entries.where((e) => e.value < 0).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    List<MapEntry<String, double>> creditors = balances.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<Map<String, dynamic>> settlements = [];

    int i = 0, j = 0;
    while (i < debtors.length && j < creditors.length) {
      double amount = min(-debtors[i].value, creditors[j].value);
      settlements.add({
        'from': debtors[i].key,
        'to': creditors[j].key,
        'amount': amount,
      });

      debtors[i] = MapEntry(debtors[i].key, debtors[i].value + amount);
      creditors[j] = MapEntry(creditors[j].key, creditors[j].value - amount);

      if (debtors[i].value.abs() < 0.01) i++;
      if (creditors[j].value < 0.01) j++;
    }

    return settlements;
  }

  double min(double a, double b) => a < b ? a : b;
}
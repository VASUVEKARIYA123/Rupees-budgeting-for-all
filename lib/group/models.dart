class Group {
  final String name;
  final List<String> members;
  final List<Expense> expenses;

  Group({required this.name, required this.members, List<Expense>? expenses})
      : expenses = expenses ?? [];

  double get totalExpenses {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  Map<String, double> get balances {
    Map<String, double> balances = {for (var member in members) member: 0};

    for (var expense in expenses) {
      balances[expense.paidBy] = (balances[expense.paidBy] ?? 0) + expense.amount;
      for (var split in expense.splits.entries) {
        balances[split.key] = (balances[split.key] ?? 0) - split.value;
      }
    }

    return balances;
  }
}

class Expense {
  final String title;
  final double amount;
  final String paidBy;
  final Map<String, double> splits;

  Expense({
    required this.title,
    required this.amount,
    required this.paidBy,
    required this.splits,
  });

  factory Expense.evenSplit(String title, double amount, String paidBy, List<String> members) {
    double splitAmount = amount / members.length;
    return Expense(
      title: title,
      amount: amount,
      paidBy: paidBy,
      splits: {for (var member in members) member: splitAmount},
    );
  }
}
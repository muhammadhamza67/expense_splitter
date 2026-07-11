import 'expense.dart';

class Dashboard {
  final int totalPeople;
  final int totalExpenses;
  final double totalAmount;
  final List<Expense> recentExpenses;

  Dashboard({
    required this.totalPeople,
    required this.totalExpenses,
    required this.totalAmount,
    required this.recentExpenses,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      totalPeople: json["totalPeople"] ?? 0,
      totalExpenses: json["totalExpenses"] ?? 0,
      totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      recentExpenses: (json["recentExpenses"] ?? [])
          .map<Expense>((e) => Expense.fromJson(e))
          .toList(),
    );
  }
}
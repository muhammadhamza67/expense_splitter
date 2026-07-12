import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../services/api_service.dart';
import 'add_expense_screen.dart';

class ExpenseHistoryScreen extends StatefulWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  State<ExpenseHistoryScreen> createState() => _ExpenseHistoryScreenState();
}

class _ExpenseHistoryScreenState extends State<ExpenseHistoryScreen> {
  final ApiService apiService = ApiService();
  static const primaryColor = Color(0xFF4CAF50);

  List<Expense> expenses = [];
  List<Expense> filteredExpenses = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    setState(() => isLoading = true);

    try {
      final data = await apiService.getExpenses();

      // Newest first (Mongo ObjectIds sort chronologically)
      data.sort((a, b) => (b.id ?? "").compareTo(a.id ?? ""));

      setState(() {
        expenses = data;
        applyFilter();
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load expenses")),
        );
      }
    }
  }

  void applyFilter() {
    filteredExpenses = expenses.where((expense) {
      final query = searchQuery.toLowerCase();
      return expense.title.toLowerCase().contains(query) ||
          expense.paidBy.toLowerCase().contains(query) ||
          expense.category.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> confirmDelete(Expense expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Delete Expense"),
        content: Text("Are you sure you want to delete \"${expense.title}\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && expense.id != null) {
      final success = await apiService.deleteExpense(expense.id!);

      if (success) {
        setState(() {
          expenses.removeWhere((e) => e.id == expense.id);
          applyFilter();
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Expense deleted")),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete expense")),
        );
      }
    }
  }

  // Maps a category name to an icon + color so cards keep the same
  // visual style as before, but now driven by real data.
  ({IconData icon, Color color}) styleForCategory(String category) {
    final key = category.toLowerCase();

    if (key.contains("food") || key.contains("dinner") || key.contains("lunch")) {
      return (icon: Icons.restaurant, color: Colors.green);
    } else if (key.contains("shop")) {
      return (icon: Icons.shopping_bag, color: Colors.orange);
    } else if (key.contains("taxi") ||
        key.contains("transport") ||
        key.contains("uber")) {
      return (icon: Icons.local_taxi, color: Colors.blue);
    } else if (key.contains("movie") || key.contains("entertain")) {
      return (icon: Icons.movie, color: Colors.purple);
    } else if (key.contains("trip") || key.contains("travel")) {
      return (icon: Icons.flight, color: Colors.teal);
    } else if (key.contains("coffee")) {
      return (icon: Icons.coffee, color: Colors.brown);
    } else if (key.contains("bill")) {
      return (icon: Icons.receipt_long, color: Colors.indigo);
    } else {
      return (icon: Icons.attach_money, color: primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        title: const Text("Expense History"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffF7F9FC),
        surfaceTintColor: Colors.transparent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadExpenses,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search expenses...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(applyFilter);
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: filteredExpenses.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                const SizedBox(height: 80),
                                Icon(
                                  Icons.receipt_long_rounded,
                                  size: 60,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 14),
                                Center(
                                  child: Text(
                                    expenses.isEmpty
                                        ? "No expenses yet"
                                        : "No matching expenses",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: filteredExpenses.length,
                              itemBuilder: (context, index) {
                                final expense = filteredExpenses[index];
                                final style = styleForCategory(expense.category);

                                return expenseCard(
                                  icon: style.icon,
                                  title: expense.title,
                                  subtitle: "Paid by ${expense.paidBy}",
                                  amount:
                                      "Rs ${expense.amount.toStringAsFixed(0)}",
                                  color: style.color,
                                  onEdit: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Editing not available yet",
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () => confirmDelete(expense),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  static Widget expenseCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        isThreeLine: false,
        minVerticalPadding: 12,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.edit, color: Colors.blue, size: 18),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.delete, color: Colors.red, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
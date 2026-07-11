class Expense {
  final String? id;
  final String title;
  final double amount;
  final String paidBy;
  final List<String> splitBetween;
  final String category;
  final String notes;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.paidBy,
    required this.splitBetween,
    required this.category,
    required this.notes,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json["id"]?.toString(),
      title: json["title"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
      paidBy: json["paid_by"] ?? "",
      splitBetween: List<String>.from(json["split_between"] ?? []),
      category: json["category"] ?? "",
      notes: json["notes"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "title": title,
      "amount": amount,
      "paid_by": paidBy,
      "split_between": splitBetween,
      "category": category,
      "notes": notes,
    };
  }
}
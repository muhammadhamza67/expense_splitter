class Summary {
  final double totalExpense;
  final int totalPeople;
  final int totalExpenses;
  final List<PersonBalance> balances;

  Summary({
    required this.totalExpense,
    required this.totalPeople,
    required this.totalExpenses,
    required this.balances,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalExpense: (json["totalExpense"] as num).toDouble(),
      totalPeople: json["totalPeople"],
      totalExpenses: json["totalExpenses"],
      balances: (json["balances"] as List)
          .map((e) => PersonBalance.fromJson(e))
          .toList(),
    );
  }
}

class PersonBalance {
  final String name;
  final double paid;
  final double share;
  final double balance;

  PersonBalance({
    required this.name,
    required this.paid,
    required this.share,
    required this.balance,
  });

  factory PersonBalance.fromJson(Map<String, dynamic> json) {
    return PersonBalance(
      name: json["name"],
      paid: (json["paid"] as num).toDouble(),
      share: (json["share"] as num).toDouble(),
      balance: (json["balance"] as num).toDouble(),
    );
  }
}
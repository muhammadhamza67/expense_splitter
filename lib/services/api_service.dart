import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/person.dart';
import '../models/expense.dart';
import '../models/dashboard.dart';
import '../models/summary.dart';
class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static const String peopleUrl = "$baseUrl/people";
  static const String expensesUrl = "$baseUrl/expenses";
  static const String dashboardUrl = "$baseUrl/dashboard";
  static const String summaryUrl = "$baseUrl/summary";
  static const String resetUrl = "$baseUrl/reset";

  // Get all people
  Future<List<Person>> getPeople() async {
    final response = await http.get(Uri.parse(peopleUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception("Failed to load people");
    }
  }

  // Add person
  Future<bool> addPerson(String name) async {
    final response = await http.post(
      Uri.parse(peopleUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // Delete person
  Future<bool> deletePerson(String id) async {
    final response = await http.delete(
      Uri.parse("$peopleUrl/$id"),
    );

    return response.statusCode == 200;
  }
  // Get all expenses
Future<List<Expense>> getExpenses() async {
  final response = await http.get(
    Uri.parse(expensesUrl),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    return data
        .map((expense) => Expense.fromJson(expense))
        .toList();
  } else {
    throw Exception("Failed to load expenses");
  }
} 
// Add Expense
Future<bool> addExpense(Expense expense) async {
  final response = await http.post(
    Uri.parse(expensesUrl),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "title": expense.title,
      "amount": expense.amount,
      "paid_by": expense.paidBy,
      "split_between": expense.splitBetween,
      "category": expense.category,
      "notes": expense.notes,
    }),
  );

  return response.statusCode == 200 ||
      response.statusCode == 201;
}
// Update Expense
Future<bool> updateExpense(String id, Expense expense) async {
  final response = await http.put(
    Uri.parse("$expensesUrl/$id"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "title": expense.title,
      "amount": expense.amount,
      "paid_by": expense.paidBy,
      "split_between": expense.splitBetween,
      "category": expense.category,
      "notes": expense.notes,
    }),
  );

  return response.statusCode == 200;
}
// Delete Expense
Future<bool> deleteExpense(String id) async {
  final response = await http.delete(
    Uri.parse("$expensesUrl/$id"),
  );

  return response.statusCode == 200;
}
// Get Dashboard
Future<Dashboard> getDashboard() async {
  final response = await http.get(
    Uri.parse(dashboardUrl),
  );

  if (response.statusCode == 200) {
    return Dashboard.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to load dashboard");
  }
}
// Get Summary
Future<Summary> getSummary() async {
  final response = await http.get(
    Uri.parse(summaryUrl),
  );

  if (response.statusCode == 200) {
    return Summary.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to load summary");
  }
}
// Reset Database
Future<bool> resetDatabase() async {
  final response = await http.delete(
    Uri.parse(resetUrl),
  );

  return response.statusCode == 200;
}
}
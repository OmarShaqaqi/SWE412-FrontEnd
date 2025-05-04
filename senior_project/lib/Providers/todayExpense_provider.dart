import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/config.dart';

final todayExpensesProvider = FutureProvider<List<Expense>>((ref) async {
  final token = ref.read(tokenProvider); // must not be null
  final url = Uri.parse('$baseUrl/expenses/today');

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    print("Today Expenses Response: ${response.body}");
    print(data);
    final List<Expense> expenses = data.map((json) => Expense.fromJson(json)).toList();
       print("Parsed Today Expenses:");
    for (var exp in expenses) {
      print(exp);
    }
    return expenses;
  } else {
    throw Exception('Failed to load today\'s expenses');
  }
});


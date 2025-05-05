import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/config.dart';
import 'package:senior_project/models/expense_model.dart';
import 'dart:convert';
import './token_provider.dart';

class ExpensesProvider extends StateNotifier<List<Expense>> {
  final Ref ref;
  bool _isLoading = false;  // Add a loading state

  ExpensesProvider(this.ref) : super([]);

  bool get isLoading => _isLoading;  // Expose loading state

  Future<void> fetchExpenses(int groupId) async {
    _isLoading = true;
    state = []; // Clear state before fetching
    final token = ref.read(tokenProvider);
    final Uri url = Uri.parse('$baseUrl/expenses/list/$groupId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Expense> expenses = data.map((json) => Expense.fromJson(json)).toList();

        state = expenses; // Update state with fetched expenses
        print(expenses); // Debugging line to check fetched expenses
      } else {
        print('Failed to fetch expenses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching expenses: $e');
    }

    _isLoading = false; // Mark loading as complete
  }
}

final expensesProvider = StateNotifierProvider<ExpensesProvider, List<Expense>>((ref) {
  return ExpensesProvider(ref);
});

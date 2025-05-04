import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/config.dart';
import 'dart:convert';
import './token_provider.dart';

class DateTypeExpensesNotifier extends StateNotifier<Map<String, double>> {
  final Ref ref;
  bool _isLoading = false;

  DateTypeExpensesNotifier(this.ref) : super({});

  bool get isLoading => _isLoading;

  Future<void> fetchDailyExpenses(String dateType) async {
    try {
      // Mark loading AFTER microtask to avoid build conflict
      await Future.delayed(Duration.zero);
      _isLoading = true;

      final token = ref.read(tokenProvider);
      final Uri url = Uri.parse('$baseUrl/expenses/$dateType');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, double> parsed = data.map((key, value) =>
            MapEntry(key, (value as num).toDouble()));

        state = parsed;
      } else {
        print('Failed to fetch daily expenses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching daily expenses: $e');
    } finally {
      _isLoading = false;
    }
  }
}

final dailyExpensesProvider =
    StateNotifierProvider<DateTypeExpensesNotifier, Map<String, double>>((ref) {
  return DateTypeExpensesNotifier(ref);
});

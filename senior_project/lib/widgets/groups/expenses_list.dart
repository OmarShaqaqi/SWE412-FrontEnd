import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:senior_project/Providers/categories_provider.dart";
import "package:senior_project/Providers/expenses_provider.dart";
import "package:senior_project/Providers/groups_provider.dart";
import "package:senior_project/Providers/users_provider.dart"; // ✅ Import user provider
import "package:senior_project/config.dart";
import "package:senior_project/models/expense_model.dart";
import "./expense_row.dart";
import "../dialog_utils.dart"; // ✅ Ensure this contains addExpenseDialog()
import "../../Providers/token_provider.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpensesList extends ConsumerStatefulWidget {
  const ExpensesList({super.key});

  @override
  ConsumerState<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends ConsumerState<ExpensesList> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final groupId = ref.read(selectedGroupIdProvider);
      if (groupId != null) {
        ref.read(expensesProvider.notifier).fetchExpenses(groupId);
      }
    });
  }

  Future<void> _updateExpenseStatus(int expenseId, String status, String? jwtToken) async {
    final url = Uri.parse("$baseUrl/expenses/$status?expenseId=$expenseId"); // ✅ Pass as query param

    print("Sending request to: $url"); // ✅ Debugging log

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    print("Response Status: ${response.statusCode}"); // ✅ Debugging log
    print("Response Body: ${response.body}"); // ✅ Debugging log

    if (response.statusCode == 200) {
      ref.read(expensesProvider.notifier).fetchExpenses(ref.read(selectedGroupIdProvider)!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update expense: ${response.body}")),
      );
    }
  }

  void _showAddExpenseDialog(String? jwtToken, int groupId, List<String> categories) {
  addExpenseDialog(
    context,
    selectedDate,
    (DateTime newDate) {
      setState(() {
        selectedDate = newDate;
      });
    },
    jwtToken,
    groupId,
    categories
  ).then((_) {
    ref.read(expensesProvider.notifier).fetchExpenses(groupId);
  });
}

@override
Widget build(BuildContext context) {
  final jwtToken = ref.watch(tokenProvider);
  final groupId = ref.watch(selectedGroupIdProvider);
  final isLeader = ref.watch(userRoleProvider);

  if (groupId == null) {
    return const Center(child: Text("No group selected"));
  }

  final expenses = ref.watch(expensesProvider);
  final categoriesState = ref.watch(categoriesProvider);

  // ✅ Convert List<Category> to List<String>
  final List<String> categories = categoriesState.map((category) => category.categoryName).toList();

  // ✅ Ensure expenses list is never null
  List<Expense> filteredExpenses = [];

  if (isLeader) {
    // ✅ Leaders see all expenses, with pending ones first
    filteredExpenses = List.from(expenses)
      ..sort((a, b) {
        if (a == null || b == null) return 0; // ✅ Ensure a & b are not null

        String statusA = a.status?.toLowerCase() ?? ""; // ✅ Handle nullable status
        String statusB = b.status?.toLowerCase() ?? "";

        if (statusA == "pending" && statusB != "pending") return -1;
        if (statusA != "pending" && statusB == "pending") return 1;
        return 0;
      });
  } else {
    // ✅ Normal participants do NOT see pending expenses
    filteredExpenses = expenses
        .where((expense) => (expense.status?.toLowerCase() ?? "") != "pending")
        .toList();
  }
 


  return RefreshIndicator(
    onRefresh: () async {
      ref.refresh(expensesProvider.notifier).fetchExpenses(groupId);
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Submitted Expenses",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: filteredExpenses.isEmpty
                ? const Center(child: Text("No expenses found"))
                : ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = filteredExpenses[index];
                      return GestureDetector(
                        onTap: () {
                         expenseDetails(context, expense);
                        },
                        child: ExpenseRow(
                          expense: expense,
                          isLeader: isLeader,
                          onUpdateStatus: (expenseId, status) {
                            _updateExpenseStatus(expenseId, status, jwtToken);
                          },
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 208, 158),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              _showAddExpenseDialog(jwtToken, groupId, categories);
            },
            child: const Text(
              "Add Expense",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  
}


}

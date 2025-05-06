import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/todayExpense_provider.dart';
import 'package:senior_project/Providers/user_provider.dart';
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/screens/home/NewExpense.dart';
import 'package:senior_project/screens/home/groupExpense.dart';
import 'package:senior_project/templates/custom_body_group.dart';
import "package:senior_project/templates/custom_scaffold.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayExpenses = ref.watch(todayExpensesProvider);

    return CustomScaffold(
      title: "Home",
      content: CustomBodyGroup(
        content:
         RefreshIndicator(
  onRefresh: () async {
    ref.refresh(todayExpensesProvider);
  },
  child: SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(), // Ensures pull works even with few items
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        todayExpenses.when(
          data: (expenses) {
            if (expenses.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'No expenses available.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: expenses.map((expense) {
                  return ExpenseCard(
                    amount: expense.amount,
                    title: expense.categoryName,
                    date: expense.date,
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error loading expenses: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    ),
  ),
),

      ),
    );
  }
}

// SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 child: Text(
//                   "Recent Transactions",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               todayExpenses.when(
//                 data: (expenses) {
//                   if (expenses.isEmpty) {
//                     return const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: Text(
//                           'No expenses available.',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     );
//                   }

//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 5),
//                     child: Column(
//                       children: expenses.map((expense) {
//                         return ExpenseCard(
//                           amount: expense.amount,
//                           title: expense.categoryName,
//                           date: expense.date,
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 },
//                 loading: () =>
//                     const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) => Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'Error loading expenses: $error',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
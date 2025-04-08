// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:senior_project/Providers/todayExpense_provider.dart';
// import 'package:senior_project/screens/home/NewExpense.dart';
// import 'package:senior_project/screens/home/groupExpense.dart';
// import 'package:senior_project/templates/custom_body_group.dart';
// import "package:senior_project/templates/custom_scaffold.dart";

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       title: "Home",
//       content: CustomBodyGroup(
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("Recent Transactions",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black)),
//                 ],
//               ),
//               SingleChildScrollView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//                 child: Column(
//                     // add the expense cards here
//                     children: [
//                       ExpenseCard(
//                         amount: 42.75,
//                         title: "Coffee with team",
//                         date: DateTime.now(),
//                       ),
//                       ExpenseCard(
//                         amount: 42.75,
//                         title: "Family",
//                         date: DateTime.now(),
//                       ),
//                     ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final asyncExpenses = ref.watch(todayExpensesProvider);
//     print(asyncExpenses);

//     return CustomScaffold(
//       title: "Home",
//       content: CustomBodyGroup(
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 15),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Text("Recent Transactions",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black)),
//               ),
//               asyncExpenses.when(
//                 data: (expenses) => Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//                   child: Column(
//                     children: expenses.map((expense) {
//                       return ExpenseCard(
//                         amount: expense.amount,
//                         title: expense.categoryName,
//                         date: expense.date,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () =>
//                     const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/todayExpense_provider.dart';
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Recent Transactions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              todayExpenses.when(
                data: (expenses) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    children: expenses.map((expense) {
                      return ExpenseCard(
                        amount: expense.amount,
                        title: expense.categoryName,
                        date: expense.date,
                      );
                    }).toList(),
                  ),
                ),
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
    );
  }
}


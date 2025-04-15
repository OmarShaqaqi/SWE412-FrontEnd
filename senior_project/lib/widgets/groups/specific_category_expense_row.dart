import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/widgets/price_widget.dart';// Ensure this path is correct

class SpecificCategoryExpenseRow extends StatelessWidget {
  final Expense expense; // 🔹 Add Expense parameter

  const SpecificCategoryExpenseRow({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // 🔹 Category Icon Box
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.food_bank_outlined, // You can customize this based on category
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),

              // 🔹 Expense Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.categoryName, // Display category name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('MMM dd').format(expense.date), // Format date
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 🔹 Expense Amount
          // Text(
          //   "SAR ${expense.amount.toStringAsFixed(2)}", // Format as currency
          //   style: const TextStyle(
          //     fontSize: 18,
          //     color: Colors.blue,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          PriceWidget(price: expense.amount), // Use PriceWidget for formatted price
        ],
      ),
    );
  }
}

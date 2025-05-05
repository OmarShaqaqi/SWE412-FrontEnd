import 'package:flutter/material.dart';
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/widgets/price_widget.dart';

class ExpenseRow extends StatelessWidget {
  final Expense expense;
  final bool isLeader;
  final Function(int, String) onUpdateStatus; // ✅ Callback for approval/rejection

  const ExpenseRow({
    Key? key,
    required this.expense,
    required this.isLeader,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // ✅ Get screen width
    double iconSize = screenWidth * 0.08; // ✅ Responsive icon size
    double textSize = screenWidth * 0.04; // ✅ Responsive text size
    double buttonSize = screenWidth * 0.1; // ✅ Responsive button size

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // ✅ Circular icon for participant
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(iconSize / 2),
            ),
            child: Icon(
              Icons.layers,
              color: Colors.white,
              size: iconSize * 0.6,
            ),
          ),
          const SizedBox(width: 10),

          // ✅ Expanded Participant info & Amount
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.actor,
                  style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "\$${expense.amount.toStringAsFixed(2)}",
                //   style: TextStyle(fontSize: textSize * 0.9, color: Colors.blue, fontWeight: FontWeight.bold),
                // ),
                PriceWidget(price: expense.amount, size: 15,),
              ],
            ),
          ),

          // ✅ Green separator
          Container(height: iconSize * 0.6, width: 1, color: Colors.green),
          const SizedBox(width: 10),

          // ✅ Expanded Category Name
          Expanded(
            flex: 2,
            child: Text(
              expense.categoryName,
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // ✅ Green separator
          Container(height: iconSize * 0.6, width: 1, color: Colors.green),
          const SizedBox(width: 10),

          // ✅ Approval/Rejection Buttons (Leader Only)
          if (isLeader && expense.status.toLowerCase() == "pending") ...[
            _buildActionButton(Icons.check, Colors.green, buttonSize, () => onUpdateStatus(expense.id, "approve")),
            const SizedBox(width: 10),
            _buildActionButton(Icons.close, Colors.red, buttonSize, () => onUpdateStatus(expense.id, "reject")),
          ] ,
        ],
      ),
    );
  }

  // ✅ Helper method for building action buttons
  Widget _buildActionButton(IconData icon, Color color, double size, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: size * 0.6),
      ),
    );
  }
}

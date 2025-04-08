import 'package:flutter/material.dart';
import 'package:senior_project/widgets/price_widget.dart';
import 'package:intl/intl.dart'; // for formatting the date

class ExpenseCard extends StatelessWidget {
  final double amount;
  final String title;
  final DateTime date;

  const ExpenseCard({
    Key? key,
    required this.amount,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(date); // e.g., Apr 7, 2025

    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const Categorization()));
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 89,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
              top: 5,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(88, 204, 176, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36.0),
                topRight: Radius.circular(36.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceWidget(price: amount),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 104, 255, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 10,
          )
        ],
      ),
    );
  }
}

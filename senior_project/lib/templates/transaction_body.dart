import 'package:flutter/material.dart';

class CustomBodyGroup extends StatelessWidget {
  final String? selectedFilter;
  final ValueChanged<String?> onFilterChanged;
  final Widget content;
  final VoidCallback onCalendarPressed;
  final double totalExpenses;

  const CustomBodyGroup({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.content,
    required this.onCalendarPressed,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Centered Total Expenses Box - Bigger Size with More Gap
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 24), // Increased space
          child: Center(
            child: Container(
              width: 360, // Made wider
              height: 110, // Made taller
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28), // Slightly more rounded
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Expenses',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18, // Slightly larger
                      color: Color(0xFF093030),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${totalExpenses.toStringAsFixed(2)} SAR',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 30, // Larger font size
                      color: Color(0xFF0068FF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Transaction List (Scrollable Content)
        Expanded(
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.only(
                  top: 48, // Increased gap
                  left: 16,
                  right: 16,
                  bottom: kBottomNavigationBarHeight,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 241, 255, 243),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: content,
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Image.asset(
                    'assets/Calendar.png',
                    width: 34,
                    height: 34,
                  ),
                  onPressed: onCalendarPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/calendar_dialog.dart';

class CustomBodyGroup extends StatefulWidget {
  final Widget content;
  final String? selectedFilter;
  final Function(String?) onFilterChanged;


  const CustomBodyGroup({
    super.key,
    required this.content,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  State<CustomBodyGroup> createState() => _CustomBodyGroupState();
}

class _CustomBodyGroupState extends State<CustomBodyGroup> {
  void _showCalendarDialog() {
    showDialog(
      context: context,
      builder: (context) => const CalendarDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 0, 208, 158),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Total Balance Card
                    Container(
                      width: 357,
                      height: 75,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 255, 243),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Stack(
                        children: const [
                          Positioned(
                            left: 127,
                            top: 11,
                            child: SizedBox(
                              width: 104,
                              height: 23,
                              child: Text(
                                "Total Balance",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 22.5 / 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 118,
                            top: 34,
                            child: SizedBox(
                              width: 117,
                              height: 36,
                              child: Text(
                                "${7783.00} SAR",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 36 / 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Income & Expense Cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white, // Change this to match your design
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.5),
                                Text(
                                  "${1187.40} SAR",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 104, 255),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "38% left",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  // Modified Content Container with expanded constraints
                  Container(
                    constraints: const BoxConstraints.expand(),
                    padding: const EdgeInsets.only(
                      top: 32,
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
                    child: widget.content,
                  ),
                  // Calendar Icon
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/Calendar.png',
                        width: 30,
                        height: 30,
                      ),
                      onPressed: _showCalendarDialog,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMoneyCard({
    required String title,
    required String amount,
    required double amountLeft,
    required bool isIncome,
    required bool isSelected,
  }) {
    final Color backgroundColor = isSelected ? const Color(0xFF0068FF) : Colors.white;
    final Color contentColor = isSelected ? const Color(0xFFF1FFF3) :
    isIncome ? const Color(0xFF00D09E) : const Color(0xFF0068FF);
    final Color textColor = isSelected ? const Color(0xFFF1FFF3) : Colors.black;

    return GestureDetector(
      onTap: () => widget.onFilterChanged(isIncome ? 'income' : 'expense'),
      child: Container(
        width: 171,
        height: 101,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Positioned(
              left: (171 - 32) / 2,
              top: 20,
              child: Transform.rotate(
                angle: isIncome ? 45 * 3.1415926535 / 180 : 135 * 3.1415926535 / 180,
                child: Icon(
                  Icons.arrow_upward,
                  size: 32,
                  color: contentColor,
                ),
              ),
            ),
            Positioned(
              left: (171 - 57) / 2,
              top: 50,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 22.5 / 15,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              left: (171 - 95) / 2,
              top: 72,
              child: SizedBox(
                width: 95,
                height: 22,
                child: Text(
                  amount,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 22 / 20,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
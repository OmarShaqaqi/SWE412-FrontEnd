import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatelessWidget {
  const CalendarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: 372,
        height: 340,  // Adjusted height for better spacing
        decoration: BoxDecoration(
          color: const Color(0xFFDFF7E2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Move Calendar to the very top with 2px padding
            Positioned(
              top: 2,
              left: 10,
              right: 10,
              child: TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: DateTime.now(),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronPadding: EdgeInsets.only(left: 8),
                  rightChevronPadding: EdgeInsets.only(right: 8),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.grey[600]),
                  todayDecoration: BoxDecoration(
                    color: const Color(0xFF00D09E),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: const Color(0xFF0068FF),
                    shape: BoxShape.circle,
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

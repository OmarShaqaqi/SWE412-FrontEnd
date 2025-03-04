import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({super.key});

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: 372,
        height: 435,
        decoration: BoxDecoration(
          color: const Color(0xFFDFF7E2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              left: 10,
              right: 10,
              bottom: 60,
              child: TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onPageChanged: (focusedDay) {
                  setState(() => _focusedDay = focusedDay);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  leftChevronPadding: EdgeInsets.only(left: 8),
                  rightChevronPadding: EdgeInsets.only(right: 8),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.grey[600]),
                  todayDecoration: const BoxDecoration(
                    color: Color(0xFF00D09E),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF0068FF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0068FF),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context,
                          DateTime(_focusedDay.year, _focusedDay.month, 1));
                    },
                    child: const Text('Select Month/Year'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0068FF),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_selectedDate != null) {
                        Navigator.pop(context, _selectedDate);
                      }
                    },
                    child: const Text('Select Day'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
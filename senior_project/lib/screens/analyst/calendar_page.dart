import 'package:flutter/material.dart';
import 'package:senior_project/templates/custom_body_search.dart';
import 'package:senior_project/templates/custom_bottom_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:collection';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool showSpends = true;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> mockData = {
    DateTime.utc(2025, 1, 1): [
      {"category": "Groceries", "time": "17:00", "amount": -100.00},
      {"category": "Others", "time": "17:00", "amount": 120.00},
    ],
    DateTime.utc(2025, 1, 2): [
      {"category": "Transport", "time": "10:30", "amount": -15.00},
      {"category": "Entertainment", "time": "20:00", "amount": -50.00},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Column(
        children: [
          // Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xff00d09e),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Toggle Buttons for Spends and Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _toggleButton("Spends", showSpends),
              _toggleButton("Categories", !showSpends),
            ],
          ),
          const SizedBox(height: 16),

          // Spends or Categories Content
          showSpends ? _buildSpendsList() : _buildPieChart(),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calendar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff00d09e),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xff00d09e), // Match app's color scheme
        child: CustomBodySearch(content: content),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _toggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showSpends = text == "Spends";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff00d09e) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSpendsList() {
    List<Map<String, dynamic>> spends = mockData[_selectedDay] ?? [];
    return Column(
      children: spends.map((spend) {
        return _spendItem(
            spend["category"],
            spend["time"],
            spend["amount"].toString(),
            spend["amount"] < 0 ? Colors.red : Colors.green);
      }).toList(),
    );
  }

  Widget _spendItem(String title, String time, String amount, Color color) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(Icons.shopping_bag, color: Colors.white)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time),
      trailing: Text(amount,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _buildPieChart() {
    Map<String, double> categoryTotals = {};
    List<Map<String, dynamic>> spends = mockData[_selectedDay] ?? [];

    for (var spend in spends) {
      String category = spend["category"];
      double amount = spend["amount"].toDouble().abs();
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }

    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: categoryTotals.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,
              title: entry.key,
              radius: 50,
              titlePositionPercentageOffset: 1.5,
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}

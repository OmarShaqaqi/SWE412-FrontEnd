import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/Providers/dateType_expense_provider.dart';
import 'package:senior_project/screens/analyst/calendar_page.dart';
import 'package:senior_project/screens/analyst/search_page.dart';
import 'package:senior_project/templates/custom_appbar.dart';
import 'package:senior_project/templates/custom_bottom_navigation_bar.dart';
import 'package:senior_project/templates/custom_body_analysis.dart';

class AnalysisPage extends ConsumerStatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends ConsumerState<AnalysisPage> {
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Future.microtask(() {
      ref
          .read(dailyExpensesProvider.notifier)
          .fetchDailyExpenses("day", formattedDate);
    });
  }

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final rawExpenses = ref.watch(dailyExpensesProvider);
    final expenses = rawExpenses.values.toList(); // List<double>
    final sortedDates = rawExpenses.keys.toList()..sort();

    final content = SingleChildScrollView(
      child: Column(
        //print(ref.read(dailyExpensesProvider.notifier).fetchDailyExpenses().toString());
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Selector
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Set the border radius
            child: Container(
              color: const Color(0xffdff7e2), // Set the background color
              padding: const EdgeInsets.all(8.0), // Add some padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    ['Daily', 'Monthly', 'Yearly'].asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                        _updateExpenses(); // Update expenses based on the selected tab
                      });
                    },
                    child: Chip(
                      label: Text(label),
                      backgroundColor: selectedTab == index
                          ? const Color(0xff00d09e)
                          : const Color(0xffdff7e2),
                      labelStyle: TextStyle(
                        color:
                            selectedTab == index ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Graph Section
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Set the border radius
            child: Container(
              color: Color(
                  0xffdff7e2), // Set the background color of the graph section
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Income & Expenses",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff093030),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (selectedDate != null) {
                                setState(() {
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                  // index = selectedTab;
                                });

                                _updateExpenses(); // 🔁 refresh chart with new date
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Bar Graph
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: _buildBarGroups(rawExpenses),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  final index = value.toInt();
                                  if (index >= sortedDates.length)
                                    return const Text('');

                                  final key = sortedDates[index];
                                  switch (selectedTab) {
                                    case 0: // Daily: format as weekday
                                      try {
                                        final date = DateTime.parse(key);
                                        // ref.read(dailyExpensesProvider.notifier).fetchDailyExpenses("day",formatted);
                                        return Text([
                                          'Sun',
                                          'Mon',
                                          'Tue',
                                          'Wed',
                                          'Thu',
                                          'Fri',
                                          'Sat'
                                        ][date.weekday % 7]);
                                      } catch (_) {
                                        return const Text("");
                                      }

                                    case 1: // Monthly: use "MMM"
                                      try {
                                        final parts =
                                            key.split('-'); // e.g. 2025-04
                                        final month = int.parse(parts[1]);
                                        const monthNames = [
                                          'Jan',
                                          'Feb',
                                          'Mar',
                                          'Apr',
                                          'May',
                                          'Jun',
                                          'Jul',
                                          'Aug',
                                          'Sep',
                                          'Oct',
                                          'Nov',
                                          'Dec'
                                        ];
                                        // ref.read(dailyExpensesProvider.notifier).fetchDailyExpenses("month",formatted);
                                        return Text(monthNames[month - 1]);
                                      } catch (_) {
                                        return const Text('');
                                      }

                                    case 2: // Yearly
                                      // ref.read(dailyExpensesProvider.notifier).fetchDailyExpenses("year",formatted);
                                      return Text(key); // year is the key

                                    default:
                                      return const Text('');
                                  }
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: const CustomAppbar(title: "Analysis"),
      body: Container(
        color: const Color(0xff00d09e), // Match app's color scheme
        child: CustomBodyAnalysis(content: content),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  List<BarChartGroupData> _buildBarGroups(Map<String, double> rawExpenses) {
    final sortedEntries = rawExpenses.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.asMap().entries.map((entry) {
      final index = entry.key;
      final amount = entry.value.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: amount,
            color: const Color(0xff00d09e),
            width: 16,
          ),
        ],
      );
    }).toList();
  }

  // Update expenses dynamically based on the selected tab
//   void _updateExpenses() {
//     final notifier = ref.read(dailyExpensesProvider.notifier);

//     switch (selectedTab) {
//       case 0:
//         notifier.fetchDailyExpenses("day","2025-05-05");
//         break;
//       case 1:
//         notifier.fetchDailyExpenses("month","2025-05");
//         break;
//       case 2:
//         notifier.fetchDailyExpenses("year","2025");
//         break;
//     }
//   }
// }
  void _updateExpenses() {
    final notifier = ref.read(dailyExpensesProvider.notifier);

    switch (selectedTab) {
      case 0:
        notifier.fetchDailyExpenses("day", formattedDate);
        break;
      case 1:
        notifier.fetchDailyExpenses(
            "month", formattedDate.substring(0, 7)); // yyyy-MM
        break;
      case 2:
        notifier.fetchDailyExpenses(
            "year", formattedDate.substring(0, 4)); // yyyy
        break;
    }
  }
}

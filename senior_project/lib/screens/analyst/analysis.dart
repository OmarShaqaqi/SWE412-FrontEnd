// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Import bar chart library
// import 'package:senior_project/screens/analyst/calendar_page.dart';
// import 'package:senior_project/screens/analyst/search_page.dart';
// import 'package:senior_project/templates/custom_appbar.dart';
// import 'package:senior_project/templates/custom_bottom_navigation_bar.dart';
// import 'package:senior_project/templates/custom_body_analysis.dart';

// class AnalysisPage extends StatefulWidget {
//   const AnalysisPage({Key? key}) : super(key: key);

//   @override
//   State<AnalysisPage> createState() => _AnalysisPageState();
// }

// class _AnalysisPageState extends State<AnalysisPage> {
//   int selectedTab = 0; // Track active tab (0: Daily, 1: Weekly, etc.)
//   List<double> expenses = [50, 100, 75, 30, 90, 120, 60]; // Example expenses

//   @override
//   Widget build(BuildContext context) {
//     final content = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Tab Selector
//         ClipRRect(
//           borderRadius: BorderRadius.circular(16.0), // Set the border radius
//           child: Container(
//             color: Color(0xffdff7e2), // Set the background color
//             padding: const EdgeInsets.all(8.0), // Add some padding
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: ['Daily', 'Weekly', 'Monthly', 'Yearly']
//                   .asMap()
//                   .entries
//                   .map((entry) {
//                 int index = entry.key;
//                 String label = entry.value;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedTab = index;
//                       _updateExpenses(); // Update expenses based on the selected tab
//                     });
//                   },
//                   child: Chip(
//                     label: Text(label),
//                     backgroundColor: selectedTab == index
//                         ? const Color(0xff00d09e)
//                         : const Color(0xffdff7e2),
//                     labelStyle: TextStyle(
//                       color: selectedTab == index ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),

//         const SizedBox(height: 16),

//         // Graph Section
//         Column(
//           children: [
//             // Graph Header with Search and Schedule Icons
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Container(
//                 color: const Color(0xffdff7e2),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Income & Expenses",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff093030),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.search),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SearchPage(),
//                                   ),
//                                 );
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.calendar_today),
//                               onPressed: () {
//                                 // Navigate to Calendar Page
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SchedulePage(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     // Bar Graph
//                     SizedBox(
//                       height: 200,
//                       child: BarChart(
//                         BarChartData(
//                           barGroups: _buildBarGroups(),
//                           borderData: FlBorderData(show: false),
//                           titlesData: FlTitlesData(show: true),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );

//     return Scaffold(
//       appBar: const CustomAppbar(title: "Analysis"),
//       body: Container(
//         color: const Color(0xff00d09e), // Set the background color of the page
//         child: CustomBodyAnalysis(content: content),
//       ),
//       bottomNavigationBar: const CustomBottomNavigationBar(),
//     );
//   }

//   // Helper method to build bar groups for the graph
//   List<BarChartGroupData> _buildBarGroups() {
//     return expenses
//         .asMap()
//         .entries
//         .map(
//           (entry) => BarChartGroupData(
//             x: entry.key,
//             barRods: [
//               BarChartRodData(
//                 toY: entry.value,
//                 color: const Color(0xff00d09e),
//                 width: 16,
//               )
//             ],
//           ),
//         )
//         .toList();
//   }

// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(dailyExpensesProvider.notifier).fetchDailyExpenses("day");
    });
  }

  int selectedTab = 0; // Track active tab (0: Daily, 1: Weekly, etc.)
  // List<double> expenses = [50, 100, 75, 30, 90, 120, 60]; // Example expenses

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
                            onPressed: () {
                              // Navigate to Calendar Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SchedulePage(),
                                ),
                              );
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
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value.toInt() >= sortedDates.length)
                                  return const Text('');

                                final date =
                                    DateTime.parse(sortedDates[value.toInt()]);
                                switch (selectedTab) {
                                  case 0:
                                    return Text(
                                      [
                                        'Sun',
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat'
                                      ][date.weekday % 7],
                                    );
                                  case 1:
                                    return Text('${date.day}/${date.month}');
                                  case 2:
                                    return Text('${date.year}');
                                  default:
                                    return const Text('');
                                }
                              },
                            ),
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

  // Helper method to build bar groups for the graph
// List<BarChartGroupData> _buildBarGroups(List<double> expenses) {
//   return expenses.asMap().entries.map(
//     (entry) => BarChartGroupData(
//       x: entry.key,
//       barRods: [
//         BarChartRodData(
//           toY: entry.value,
//           color: const Color(0xff00d09e),
//           width: 16,
//         )
//       ],
//     ),
//   ).toList();
// }

//
  List<BarChartGroupData> _buildBarGroups(Map<String, double> rawExpenses) {
    final sortedEntries = rawExpenses.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key)); // Sort by date string

    return sortedEntries.asMap().entries.map((entry) {
      final index = entry.key;
      final dateStr = entry.value.key;
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
  void _updateExpenses() {
    final notifier = ref.read(dailyExpensesProvider.notifier);

    switch (selectedTab) {
      case 0:
        notifier.fetchDailyExpenses("day");
        break;
      case 1:
        notifier.fetchDailyExpenses("month");
        break;
      case 2:
        notifier.fetchDailyExpenses("year");
        break;
    }
  }
}

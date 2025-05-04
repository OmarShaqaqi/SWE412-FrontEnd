import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/config.dart';
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/templates/transaction_body.dart';
import 'package:senior_project/widgets/calendar_dialog.dart';
import 'package:senior_project/widgets/expense_details_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/token_provider.dart';


class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  DateTime? _selectedDate;
  // List<Expense> allExpense = [];
  List<Expense> allExpense = [];

  @override
  void initState() {
    super.initState();
    _initializeExpenses();
  }

  Future<void> _initializeExpenses() async {
    final expenses = await _fetchExpensesByDate(DateTime.now().toString());
    setState(() {
      allExpense = expenses;
    });
  }
  // groups/personal

void _openCalendar() async {
  final selectedDateString = await showDialog<String>(
    context: context,
    builder: (context) => const CalendarDialog(),
  );

  if (selectedDateString != null) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(selectedDateString)); // keep as DateTime
    final expenses = await _fetchExpensesByDate(selectedDateString);
    setState(() {
      // _selectedDate = date;
      allExpense = expenses;
    });
  }
}
Future<List<Expense>> _fetchExpensesByDate(String date) async {
  final token = ref.read(tokenProvider);
  final url = Uri.parse('$baseUrl/expenses/date/$date'); // Replace with your real API
  final response = await http.get(    
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
    );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Expense.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load expenses');
  }
}



  List<Expense> get filteredTransactions {
    final filtered = allExpense.where((t) {
      final bool dateMatch = _selectedDate == null ? true :
      (_selectedDate!.day == 1
          ? t.date.month == _selectedDate!.month && t.date.year == _selectedDate!.year
          : t.date == _selectedDate);
      return dateMatch;
    }).toList();
    // Sort by date descending (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  Map<String, List<Expense>> _groupTransactions() {
    final Map<String, List<Expense>> groups = {};
    for (final transaction in filteredTransactions) {
      final key = _selectedDate?.day == 1 || _selectedDate == null
          ? '${_getMonthName(transaction.date.month)} ${transaction.date.year}'
          : _formatTime(transaction.date);
      groups.putIfAbsent(key, () => []).add(transaction);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final transactionGroups = _groupTransactions();
    final double totalExpenses = filteredTransactions.fold(
        0.0,
            (sum, transaction) => sum + transaction.amount.abs()
    );

    return CustomScaffold(
      title: 'Expenses',
      content: CustomBodyGroup(
        selectedFilter: null,
        onFilterChanged: (String? string) {},
        onCalendarPressed: _openCalendar,
        totalExpenses: totalExpenses, // Pass the value here
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...transactionGroups.entries.map((entry) {
                return _buildTransactionSection(
                  title: entry.key,
                  allexpenses: entry.value,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSection({
    required String title,
    required List<Expense> allexpenses,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 208, 158),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: allexpenses.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final expense = allexpenses[index];
              return ListTile(
                onTap: () => (),
                
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    ("assets/salary_pressed.png"),
                    width: 60,
                    height: 60,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    expense.categoryName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    _formatTime(expense.date),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 104, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          expense.categoryName,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/Saudi_Riyal_Symbol.png',
                              height: 16, // Adjust size as needed
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '- ${expense.amount.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 104, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime date) {
    //'${date.day.toString().padLeft(2, '0')}:${date.month.toString().padLeft(2, '0')}';
    return DateFormat('d MMMM yyyy').format(date); 
  }

  String _getMonthName(int month) {
    return const [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ][month - 1];
  }

  
}


    // Expense(
    //   id: 0,
    //   status: "Approved",
    //   date: DateTime(2025, 2, 1),
    //   categoryName: "asdf",
    //   actor: 'Group A',
    //   amount: 1000.0,
    //   description: 'Salary for the month',
    // ),
    
    // Expense(
    //   id: 1,
    //   status: "Pending",
    //   date: DateTime.now(),
    //   categoryName: "Groceries",
    //   actor: 'Group B',
    //   amount: 200.0,
    //   description: 'Weekly groceries',
    // ),
    // Expense(
    //   id: 2,
    //   status: "Rejected",
    //   date: DateTime.now(),
    //   categoryName: "Rent",
    //   actor: 'Group C',
    //   amount: 1500.0,
    //   description: 'Monthly rent payment',
    // ),
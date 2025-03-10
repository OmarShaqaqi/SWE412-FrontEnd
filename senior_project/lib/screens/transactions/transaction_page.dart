import 'package:flutter/material.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/templates/transaction_body.dart';
import 'package:senior_project/widgets/calendar_dialog.dart';
import 'package:senior_project/widgets/expense_details_dialog.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  DateTime? _selectedDate;
  List<TransactionItem> allTransactions = [
    TransactionItem(
      date: DateTime(2024, 11, 5, 9, 15),
      category: Category.groceries,
      group: 'Family',
      amount: -150.00,
    ),
    TransactionItem(
      date: DateTime(2024, 12, 20, 12, 30),
      category: Category.rent,
      group: 'Shared',
      amount: -700.00,
    ),
    TransactionItem(
      date: DateTime(2024, 4, 24, 17, 0),
      category: Category.transport,
      group: 'Personal',
      amount: -45.00,
    ),
    TransactionItem(
      date: DateTime(2024, 4, 15, 8, 30),
      category: Category.food,
      group: 'Personal',
      amount: -25.50,
    ),
    TransactionItem(
      date: DateTime(2025, 1, 10, 14, 0),
      category: Category.medical,
      group: 'Family',
      amount: -120.00,
    ),
    TransactionItem(
      date: DateTime(2025, 2, 14, 19, 45),
      category: Category.movie,
      group: 'Entertainment',
      amount: -50.00,
    ),
  ];

  void _openCalendar() async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) => const CalendarDialog(),
    );
    if (selectedDate != null) {
      setState(() => _selectedDate = selectedDate);
    }
  }

  List<TransactionItem> get filteredTransactions {
    final filtered = allTransactions.where((t) {
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

  Map<String, List<TransactionItem>> _groupTransactions() {
    final Map<String, List<TransactionItem>> groups = {};
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
                  transactions: entry.value,
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
    required List<TransactionItem> transactions,
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
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ExpenseDetailsDialog(
                    transaction: transaction,
                    onSave: (updatedTransaction) {
                      setState(() {
                        final index = allTransactions.indexOf(transaction);
                        allTransactions[index] = updatedTransaction;
                      });
                    },
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    _getIconForCategory(transaction.category),
                    width: 60,
                    height: 60,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    transaction.category.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    _formatTime(transaction.date),
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
                          transaction.group,
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
                              '- ${transaction.amount.abs().toStringAsFixed(2)}',
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
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getMonthName(int month) {
    return const [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ][month - 1];
  }

  String _getIconForCategory(Category category) {
    switch (category) {
      case Category.salary:
        return 'assets/salary_pressed.png';
      case Category.groceries:
        return 'assets/groc_pressed.png';
      case Category.rent:
        return 'assets/rent_pressed.png';
      case Category.transport:
        return 'assets/transport_pressed.png';
      case Category.food:
        return 'assets/food_pressed.png';
      case Category.travel:
        return 'assets/travel_pressed.png';
      case Category.medical:
        return 'assets/med_pressed.png';
      case Category.movie:
        return 'assets/movie_pressed.png';
      case Category.wedding:
        return 'assets/wedding_pressed.png';
      case Category.gift:
        return 'assets/gift_pressed.png';
      case Category.house:
        return 'assets/house_pressed.png';
    }
  }
}

enum Category {
  salary('Salary'),
  groceries('Groceries'),
  rent('Rent'),
  transport('Transport'),
  food('Food'),
  travel('Travel'),
  medical('Medical'),
  movie('Movie'),
  wedding('Wedding'),
  gift('Gift'),
  house('House');

  final String displayName;
  const Category(this.displayName);
}

class TransactionItem {
  final DateTime date;
  final Category category;
  final String group;
  final double amount;
  final String? details;

  const TransactionItem({
    required this.date,
    required this.category,
    required this.group,
    required this.amount,
    this.details,
  });
}
import 'package:flutter/material.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/templates/transaction_body.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? _selectedFilter;

  void _handleFilterChange(String? filterType) {
    setState(() {
      _selectedFilter = _selectedFilter == filterType ? null : filterType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Transactions',
      content: CustomBodyGroup(
        selectedFilter: _selectedFilter,
        onFilterChanged: _handleFilterChange,
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTransactionSection(
                title: 'April 2024',
                transactions: _filterTransactions([
                  TransactionItem(
                    date: DateTime(2024, 4, 30, 18, 27),
                    category: Category.salary,
                    group: 'Personal',
                    amount: 4000.00,
                  ),
                  TransactionItem(
                    date: DateTime(2024, 4, 24, 17, 0),
                    category: Category.groceries,
                    group: 'Family',
                    amount: -100.00,
                  ),
                  TransactionItem(
                    date: DateTime(2024, 4, 15, 8, 30),
                    category: Category.rent,
                    group: 'Shared',
                    amount: -674.40,
                  ),
                  TransactionItem(
                    date: DateTime(2024, 4, 8, 9, 30),
                    category: Category.transport,
                    group: 'Brothers',
                    amount: -4.13,
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              _buildTransactionSection(
                title: 'March 2024',
                transactions: _filterTransactions([
                  TransactionItem(
                    date: DateTime(2024, 3, 31, 19, 30),
                    category: Category.food,
                    group: 'Personal',
                    amount: -70.40,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TransactionItem> _filterTransactions(List<TransactionItem> transactions) {
    if (_selectedFilter == 'income') {
      return transactions.where((t) => t.amount > 0).toList();
    } else if (_selectedFilter == 'expense') {
      return transactions.where((t) => t.amount < 0).toList();
    }
    return transactions;
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
                    _formatDate(transaction.date),
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
                        Text(
                          '${transaction.amount < 0 ? '-' : ''} ${transaction.amount.abs().toStringAsFixed(2)} SAR',
                          style: TextStyle(
                            color: transaction.amount > 0
                                ? const Color.fromARGB(255, 9, 48, 48)
                                : const Color.fromARGB(255, 0, 104, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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

  String _formatDate(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${_getMonthName(date.month)} ${date.day}';
  }

  String _getMonthName(int month) {
    return [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ][month - 1];
  }

  String _getIconForCategory(Category category) {
    switch (category) {
      case Category.salary:
        return 'assets/salary.png';
      case Category.groceries:
        return 'assets/groc.png';
      case Category.rent:
        return 'assets/rent.png';
      case Category.transport:
        return 'assets/transport.png';
      case Category.food:
        return 'assets/food.png';
      case Category.travel:
        return 'assets/travel.png';
      case Category.medical:
        return 'assets/med.png';
      case Category.movie:
        return 'assets/movie.png';
      case Category.wedding:
        return 'assets/wedding.png';
      case Category.gift:
        return 'assets/gift.png';
      case Category.house:
        return 'assets/house.png';
      default:
        return 'assets/groc.png';
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

  TransactionItem({
    required this.date,
    required this.category,
    required this.group,
    required this.amount,
  });
}
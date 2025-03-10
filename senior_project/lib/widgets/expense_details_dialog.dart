import 'package:flutter/material.dart';
import 'package:senior_project/screens/transactions/transaction_page.dart';

class ExpenseDetailsDialog extends StatefulWidget {
  final TransactionItem transaction;
  final Function(TransactionItem) onSave;

  const ExpenseDetailsDialog({
    super.key,
    required this.transaction,
    required this.onSave,
  });

  @override
  State<ExpenseDetailsDialog> createState() => _ExpenseDetailsDialogState();
}

class _ExpenseDetailsDialogState extends State<ExpenseDetailsDialog> {
  late bool _isEditing;
  late TextEditingController _amountController;
  late TextEditingController _detailsController;
  late String _selectedGroup;
  late Category _selectedCategory;

  final List<String> _groups = ['Family', 'Shared', 'Personal', 'Entertainment'];
  final List<Category> _categories = Category.values;

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _amountController = TextEditingController(
      text: widget.transaction.amount.abs().toStringAsFixed(2),
    );
    _detailsController = TextEditingController(
      text: widget.transaction.details ?? '',
    );
    _selectedGroup = widget.transaction.group;
    _selectedCategory = widget.transaction.category;
  }

  String _formatDate(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${_getMonthName(date.month)} ${date.day}';
  }

  String _getMonthName(int month) {
    return const [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ][month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 339,
        height: 492,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Title
            const Positioned(
              left: 89,
              top: 6,
              child: SizedBox(
                width: 162,
                height: 30,
                child: Center(
                  child: Text(
                    'Expense Details',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF0E3E3E),
                    ),
                  ),
                ),
              ),
            ),

            // Labels Column
            Positioned(
              left: 17,
              top: 44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Actor'),
                  const SizedBox(height: 10),
                  _buildLabel('Group'),
                  const SizedBox(height: 10),
                  _buildLabel('Category'),
                  const SizedBox(height: 10),
                  _buildLabel('Amount'),
                  const SizedBox(height: 10),
                  _buildLabel('Date'),
                  const SizedBox(height: 10),
                  _buildLabel('Details'),
                ],
              ),
            ),

            // Input Fields Column
            Positioned(
              left: 93,
              top: 44,
              child: Column(
                children: [
                  _buildActorField(),
                  const SizedBox(height: 10),
                  _buildGroupField(),
                  const SizedBox(height: 10),
                  _buildCategoryField(),
                  const SizedBox(height: 10),
                  _buildAmountField(),
                  const SizedBox(height: 10),
                  _buildDateField(),
                  const SizedBox(height: 10),
                  _buildDetailsField(),
                ],
              ),
            ),

            // Edit/Save Button
            Positioned(
              left: 85,
              bottom: 20,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return SizedBox(
      height: 34,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF0E3E3E),
          ),
        ),
      ),
    );
  }

  Widget _buildActorField() {
    return Container(
      width: 218,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          'Participant',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF0E3E3E),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupField() {
    return Container(
      width: 218,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: _isEditing
          ? DropdownButtonFormField<String>(
        value: _selectedGroup,
        items: _groups.map((group) => DropdownMenuItem(
          value: group,
          child: Text(
            group,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color(0xFF0E3E3E)),
          ),
        )).toList(),
        onChanged: (value) => setState(() => _selectedGroup = value!),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      )
          : Center(
        child: Text(
          _selectedGroup,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xFF0E3E3E)),
        ),
      ),
    );
  }

  Widget _buildCategoryField() {
    return Container(
      width: 218,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: _isEditing
          ? DropdownButtonFormField<Category>(
        value: _selectedCategory,
        items: _categories.map((category) => DropdownMenuItem(
          value: category,
          child: Text(
            category.displayName,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color(0xFF0E3E3E)),
          ),
        )).toList(),
        onChanged: (value) => setState(() => _selectedCategory = value!),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      )
          : Center(
        child: Text(
          _selectedCategory.displayName,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xFF0E3E3E)),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      width: 218,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: _isEditing
          ? TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: '0.00 SAR',
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xFF0E3E3E),
        ),
      )
          : Center(
        child: Text(
          '${widget.transaction.amount.abs().toStringAsFixed(2)} SAR',
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xFF0E3E3E)),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      width: 218,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          _formatDate(widget.transaction.date),
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xFF0E3E3E)),
        ),
      ),
    );

  }

  Widget _buildDetailsField() {
    return Container(
      width: 218,
      height: 133,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7E2),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(16),
      child: _isEditing
          ? TextField(
        controller: _detailsController,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter details...',
        ),
        style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xFF0E3E3E)),
      )
          : Text(
        _detailsController.text.isNotEmpty
            ? _detailsController.text
            : 'Details...',
        style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xFF0E3E3E)),
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      width: 169,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF00D09E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {
          if (_isEditing) {
            final updatedTransaction = TransactionItem(
              date: widget.transaction.date,
              category: _selectedCategory,
              group: _selectedGroup,
              amount: double.tryParse(_amountController.text) ?? widget.transaction.amount,
              details: _detailsController.text,
            );
            widget.onSave(updatedTransaction);
            Navigator.of(context).pop(); // Close the dialog after saving
          } else {
            setState(() => _isEditing = true);
          }
        },
        child: Text(
          _isEditing ? 'Save' : 'Edit',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF0E3E3E),
          ),
        ),
      ),
    );
  }
}
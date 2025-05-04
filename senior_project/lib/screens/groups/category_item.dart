import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/categories_provider.dart';
import 'package:senior_project/Providers/expenses_provider.dart';
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/config.dart';
import 'package:senior_project/templates/custom_body_groupItem.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/widgets/groups/specific_category_expense_row.dart';
import "../../widgets/dialog_utils.dart";
import 'package:senior_project/models/expense_model.dart';
import 'package:http/http.dart' as http;

class CategoryItemScreen extends ConsumerStatefulWidget {
  const CategoryItemScreen({super.key, required this.title});

  final String title;
  

  @override
  ConsumerState<CategoryItemScreen> createState() => _CategoryItemState();
}

class _CategoryItemState extends ConsumerState<CategoryItemScreen> {
  DateTime _selectedDate = DateTime.now();

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final token = ref.read(tokenProvider);
    final groupId = ref.read(selectedGroupIdProvider);
    final categoriesState = ref.watch(categoriesProvider);
    final List<String> categories = categoriesState.map((c) => c.categoryName).toList();
    final expenses = ref.watch(expensesProvider).where((expense) => expense.categoryName == widget.title || expense.isPending=="APPROVED").toList();
    final content = Column(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 0),
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) => SpecificCategoryExpenseRow(
                    expense: expenses[index], // Pass expense to row widget
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 16.0,
              bottom:
                  kBottomNavigationBarHeight*0.6,
              left: screenWidth * 0.10,    
                  ),
               // Add padding around the button
          child: SizedBox(
            width: MediaQuery.of(context).size.width, // Make the button take full width
            height: 30, // Set the height of the button
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    addExpenseDialog(context, _selectedDate, _updateSelectedDate,token,groupId!,categories);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Check this!
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Add Expense",
                  ),
                ),
                SizedBox(width: 10), // Add space between buttons
                ElevatedButton(
                  onPressed: () async{
                    // Delete category logic here
                     final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Category'),
                      content: const Text('Are you sure you want to delete this category?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final url = Uri.parse(
                      '$baseUrl/categories/delete?groupId=$groupId&categoryName=${Uri.encodeComponent(widget.title)}',
                    );

                    try {
                      final response = await http.get(
                        url,
                        headers: {
                          'Authorization': 'Bearer $token',
                        },
                      );

                      if (response.statusCode == 200) {
                        // Optionally show success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Category deleted successfully')),
                        );
                        ref.refresh(categoriesProvider);
                        
                        
                        Navigator.pop(context); // Go back after deletion
                        // Refresh categories
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete category: ${response.body}')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Check this!
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Delete Category",
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
    return CustomScaffold(
      title: widget.title,
      content: CustomBodyGroupItem(content: content),
    );
  }
}

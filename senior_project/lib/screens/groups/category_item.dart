import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/categories_provider.dart';
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/templates/custom_body_group.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/widgets/groups/specific_category_expense_row.dart';
import "../../widgets/dialog_utils.dart";

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
    final token = ref.read(tokenProvider);
    final groupId = ref.read(selectedGroupIdProvider);
    final categoriesState = ref.watch(categoriesProvider);
    final List<String> categories = categoriesState.map((c) => c.categoryName).toList();
    final content = Column(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 0),
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => SpecificCategoryExpenseRow(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0,
              bottom:
                  kBottomNavigationBarHeight), // Add padding around the button
          child: SizedBox(
            width: 150, // Make the button take full width
            height: 30, // Set the height of the button
            child: ElevatedButton(
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
          ),
        ),
      ],
    );
    return CustomScaffold(
      title: widget.title,
      content: CustomBodyGroup(content: content),
    );
  }
}

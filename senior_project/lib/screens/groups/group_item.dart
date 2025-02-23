import 'package:flutter/material.dart';
import 'package:senior_project/templates/custom_body_group.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import 'package:senior_project/widgets/groups/expenses_list.dart';
import '../../widgets/groups/members_list.dart';
import '../../widgets/groups/categories_list.dart';

class GroupItemScreen extends StatefulWidget {
  const GroupItemScreen({super.key, required this.name});

  final String name;

  @override
  State<GroupItemScreen> createState() => _GroupItemScreenState();
}

class _GroupItemScreenState extends State<GroupItemScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final content = PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index; // Track the current page index
        });
      },
      children: [
        MembersList(),
        CategoriesList(),
        ExpensesList(),
      ],
    );

    return CustomScaffold(
      title: widget.name,
      content: CustomBodyGroup(
        content: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 400,
              child: content,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 35,
              width: 180,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 208, 158),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3, // Number of screens
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

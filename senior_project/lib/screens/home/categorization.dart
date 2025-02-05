import 'package:flutter/material.dart';
import 'package:senior_project/data/groups_data.dart';
import 'package:senior_project/models/group.dart';
import 'package:senior_project/screens/home/NewExpense.dart';
import 'package:senior_project/screens/home/categroyUI_home.dart';
import 'package:senior_project/screens/home/gourpsUI_home.dart';
import 'package:senior_project/templates/custom_scaffold.dart';


class Categorization extends StatefulWidget {
  const Categorization({super.key});

  @override
  State<Categorization> createState() => _CategorizationState();
}

class _CategorizationState extends State<Categorization> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

    final content = Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  top: 16,
                  left: 20,
                  right: 16,
                  bottom: kBottomNavigationBarHeight),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 255, 243), // Light green
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpenseCard(),
                  GroupsUiHome(),
                  CategroyuiHome(),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return CustomScaffold(
      title: 'Label the payment',
      content: content,
    );
  }
}

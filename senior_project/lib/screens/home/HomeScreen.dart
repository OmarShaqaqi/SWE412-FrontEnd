import 'package:flutter/material.dart';
import 'package:senior_project/screens/home/NewExpense.dart';
import 'package:senior_project/screens/home/categroyUI_home.dart';
import 'package:senior_project/screens/home/gourpsUI_home.dart';
import 'package:senior_project/screens/home/groupExpense.dart';
import 'package:senior_project/widgets/price_widget.dart';
import "../../templates/custom_bottom_navigation_bar.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 0, 208, 158), // Dark green background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          title: const Text(
            "Hi, Welcome Back",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 208, 158),
          elevation: 0,
        ),
      ),
      extendBody: true,
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 208, 158),
            child: Column(
              children: [
                // Total balance & total expenses
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "Total balance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PriceWidget(price: 1000),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.white,
                      ),
                      const Column(
                        children: [
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PriceWidget(price: 1000),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 255, 243),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.3, // Adjust width based on percentage
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text("30%",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "30% of your expenses, looks good.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          // Group cards
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 255, 243), // Light green
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                  // add the expense cards here
                  children: [ExpenseCard(), ExpenseCard(),Groupexpense()]),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

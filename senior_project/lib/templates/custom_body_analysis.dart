import 'package:flutter/material.dart';

class CustomBodyAnalysis extends StatelessWidget {
  final Widget content;

  const CustomBodyAnalysis({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // Top Section (Balance and Expenses + Progress Bar)
        Container(
          height: screenHeight * 0.2,
          color: const Color.fromARGB(255, 0, 208, 158),
          child: Column(
            children: [
              // Total balance & total expenses
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
                        Text(
                          "1000 SAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
                        Text(
                          "1000 SAR",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Progress bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
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
              const SizedBox(height: 20),
              const Text(
                "30% of your expenses, looks good.",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        // Main Content Section
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
                bottom: kBottomNavigationBarHeight),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 255, 243), // Light green
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: content,
          ),
        ),
      ],
    );
  }
}

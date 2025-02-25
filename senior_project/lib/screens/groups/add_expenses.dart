import 'package:flutter/material.dart';

class AddExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void addGroup() {
    String groupName = groupNameController.text;
    String budget = budgetController.text;

    if (groupName.isEmpty || budget.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Perform action to add the group (e.g., API call)
    print("Adding group: $groupName with budget: $budget");

    // Clear input fields after submission
    groupNameController.clear();
    budgetController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Group Name"),
                  TextFormField(
                    controller: groupNameController,
                    decoration: const InputDecoration(
                      hintText: "New Group",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Budget"),
                  TextFormField(
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "\$8000",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addGroup,
                    child: const Text("Add Group"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

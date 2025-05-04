import 'package:flutter/material.dart';
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/Providers/users_provider.dart';
import 'package:senior_project/config.dart';
import 'package:senior_project/models/expense_model.dart';
import 'package:senior_project/models/participant_model.dart';
import 'package:senior_project/screens/authentication/login.dart';
import 'package:senior_project/widgets/category_icon.dart';
import "../Providers/categories_provider.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:senior_project/widgets/category_icon.dart';

Future<void> showLogoutDialog(BuildContext context, dynamic ref) {
  final token = ref.read(tokenProvider);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "End Session",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
          height: 80,
          child: const Column(children: [
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
        actions: <Widget>[
          Column(
            children: [
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    print("Session ended");
                    ref
                        .read(tokenProvider.notifier)
                        .removeToken(); // Remove the token from the provider
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);

                    // Add your logout logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Yes, End Session",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 48, 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    print("Cancelled");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 223, 247, 226),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 48, 48),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<String?> addParticipantDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        final particiapntNameController = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: const EdgeInsets.all(16),
          title: const Text(
            "Add Participant",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(children: [
              const Text(
                "Participant:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: particiapntNameController,
                decoration: const InputDecoration(
                  hintText: "enter participant name",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
          actions: <Widget>[
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle account deletion
                      if (particiapntNameController.text.isNotEmpty) {
                        print(particiapntNameController.text);
                        Navigator.of(context).pop(
                            particiapntNameController.text); // Close dialog
                      } else {
                        SnackBar snackBar = const SnackBar(
                          content: Text("Please enter a participant name"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 48, 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      print("canceld");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 223, 247, 226),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 48, 48),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}

Future<void> deleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: const EdgeInsets.all(16),
          title: const Text(
            "Delete Account",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 180,
            child: const Column(children: [
              Text(
                "Are you sure you want to delete your account?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "By deleting your account, you agree that you understand the consequences of this "
                  "action and that you agree to permanently delete your account and all associated data. ")
            ]),
          ),
          actions: <Widget>[
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle account deletion
                      Navigator.of(context).pop(); // Close dialog
                      print("Account deleted");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      "Yes, Delete my Account",
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 48, 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      print("canceld");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 223, 247, 226),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 48, 48),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}

Future<void> participantInfo(BuildContext context, Participant participant) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "Participant Information",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize:
              MainAxisSize.min, // Dynamically adapts to content height
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Phone"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.phone,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Paid"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.totalExpense.toString(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("isLeader"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.isLeader.toString(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> participantInfoWithDelete(
    BuildContext context,
    Participant participant,
    int groupId,
    WidgetRef ref,
    VoidCallback onDeleted) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "Participant Information",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize:
              MainAxisSize.min, // Dynamically adapts to content height
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Phone"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.phone,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Paid"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.totalExpense.toString(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("isLeader"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: participant.isLeader.toString(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 247, 226),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final token = ref.read(tokenProvider);
                  final url = Uri.parse(
                      '$baseUrl/participants/deleteParticipant?groupId=$groupId&participant_phone=${participant.phone}');

                  final response = await http.get(
                    url,
                    headers: {
                      'Authorization': 'Bearer $token',
                      'Content-Type': 'application/json',
                    },
                  );

                  if (response.statusCode == 200) {
                    onDeleted();
                    Navigator.of(context).pop(); // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Participant deleted successfully')),
                    );
                    print("Participant deleted");
                  } else {
                    Navigator.of(context).pop(); // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to delete: ${response.body}')),
                    );
                    print("Failed to delete participant: ${response.body}");
                  }
                } catch (e) {
                  Navigator.of(context).pop(); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                  print("Error deleting participant: $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text(
                "Delete Participant",
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 48, 48),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> expenseDetails(BuildContext context, Expense expense) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "Expenses Details",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Dynamically adapts to content height
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Actor"),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(expense.actor),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Category"),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(expense.categoryName),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Amount"),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(expense.amount.toString()),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date"),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(
                          "${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.day.toString().padLeft(2, '0')}"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Status"),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(expense.status.toString()),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the TextField at the top
                  children: [
                    Text("Details"),
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Text(expense.description),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                 
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Handle delete expense logic here
                    // final bool isLeader = ref.watch(userRoleProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Delete Expense",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 48, 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> addExpenseDialog(
  BuildContext context,
  DateTime selectedDate,
  void Function(DateTime) onDateSelected,
  String? jwtToken,
  int groupId,
  List<String> categories,
) async {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = categories.isNotEmpty ? categories[0] : "";

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(16.0),
            content: SingleChildScrollView(
              // ✅ Fix responsiveness
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Date"),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                        onDateSelected(picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}", // ✅ Correct date format
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Category"),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                    items: categories.isNotEmpty
                        ? categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList()
                        : [
                            const DropdownMenuItem(
                              value: null,
                              child: Text("No categories available"),
                            ),
                          ],
                    decoration: const InputDecoration(
                      hintText: "Select The Category",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("Amount"),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/Saudi_Riyal_Symbol.png',
                        height: 15, // Adjust symbol size relative to text
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Details"),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Enter Details",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              // ✅ Validate inputs
                              if (selectedCategory.isEmpty ||
                                  amountController.text.isEmpty ||
                                  descriptionController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please fill all required fields"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // ✅ Convert amount to BigDecimal format
                              final double? amount =
                                  double.tryParse(amountController.text);
                              if (amount == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Invalid amount"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // ✅ Prepare JSON payload
                              final Map<String, dynamic> expenseData = {
                                "groupId": groupId,
                                "categoryName": selectedCategory,
                                "amount":
                                    amount, // Backend expects BigDecimal (float in JSON)
                                "description": descriptionController.text,
                                "date":
                                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}", // ✅ Fixed Date Format
                              };

                              // ✅ Send API request to backend
                              final response = await http.post(
                                Uri.parse('$baseUrl/expenses/add'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $jwtToken',
                                },
                                body: jsonEncode(expenseData),
                              );

                              if (response.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Expense added successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context)
                                    .pop(); // ✅ Close dialog on success
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Failed to add expense: ${response.body}"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 208, 158),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const Text("Save",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 208, 158),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const Text("Cancel",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> addCategory(BuildContext context, WidgetRef ref) {
  final TextEditingController _categoryController = TextEditingController();
  CategoryIcon selectedIcon = CategoryIcon.food;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "Add Category",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Dynamically adapts to content height
              children: [
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    hintText: "Category name",
                    filled: true,
                    fillColor: Color.fromARGB(255, 223, 247, 226),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButton<CategoryIcon>(
                  value: selectedIcon,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (CategoryIcon? newIcon) {
                    if (newIcon != null) {
                      selectedIcon = newIcon;
                      (context as Element)
                          .markNeedsBuild(); // update dialog manually
                    }
                  },
                  items: CategoryIcon.values.map((icon) {
                    return DropdownMenuItem(
                      value: icon,
                      child: Row(
                        children: [
                          Icon(icon.icon, color: Colors.black),
                          const SizedBox(width: 10),
                          Text(icon.label),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String categoryName = _categoryController.text.trim();

                    if (categoryName.isNotEmpty) {
                      print("selected item name" + selectedIcon.name);
                      try {
                        await ref
                            .read(categoriesProvider.notifier)
                            .addCategory(categoryName, selectedIcon.name);
                        // Optionally, show a success message here.
                        Navigator.of(context).pop(); // Close the dialog
                      } catch (e) {
                        // Handle the error (e.g., show an error message)
                        print('Error adding category: $e');
                      }
                    } else {
                      // Show a message to inform the user to enter a category name
                      print('Category name cannot be empty');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 48, 48),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 48, 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:senior_project/screens/authentication/login.dart';

Future<void> showLogoutDialog(BuildContext context) {
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
                    Navigator.of(context).pop(); // Close dialog
                    print("Session ended");
                    // Navigate to login page and replace current screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                    // Add any additional logout logic (e.g., clearing user data)
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
          content: Container(
            height: 180,
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

Future<void> participantInfo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.all(16),
        title: const Text(
          "Participant Information",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Column(
          mainAxisSize:
              MainAxisSize.min, // Dynamically adapts to content height
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "your name",
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
                      hintText: "amount paid",
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
                const Text("Number"),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "contact number",
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

Future<void> expenseDetails(BuildContext context) {
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
                      child: const Text("Name"),
                      decoration: const BoxDecoration(
                        color: const Color.fromARGB(255, 223, 247, 226),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
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
                      child: const Text("Rent"),
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
                      child: const Text("\$130"),
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
                      child: const Text("11 Sep"),
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
                      child: const Text("Approved"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the TextField at the top
                  children: [
                    Text("Details"),
                    SizedBox(width: 10),
                    Expanded(
                      // Allow the TextField to take all remaining space in the Row
                      child: SizedBox(
                        height: 180, // Set the desired height for the TextField
                        child: TextField(
                          maxLines: null, // Allow multi-line input
                          expands: true, // Make the TextField expand vertically
                          decoration: InputDecoration(
                            hintText: "Details...",
                            filled: true,
                            fillColor: Color.fromARGB(255, 223, 247, 226),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                    "Save",
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
) async {
  // Controllers for the input fields
  final TextEditingController amountController = TextEditingController();
  final TextEditingController expenseTitleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String selectedCategory = "";

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(16.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Date"),
                  // Date Picker
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
                          selectedDate = picked; // Update local state
                        });
                        onDateSelected(picked); // Notify the parent widget
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
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate.toLocal().toString().split(' ')[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Category"),
                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedCategory.isNotEmpty ? selectedCategory : null,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                    items: ["Food", "Transport", "Shopping", "Other"]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      hintText: "Select The Category",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Amount"),
                  // Amount Field
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      prefixText: "\$",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Expense Title"),
                  // Expense Title Field
                  TextFormField(
                    controller: expenseTitleController,
                    decoration: const InputDecoration(
                      hintText: "Expense Title",
                      labelText: "Expense Title",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Details"),
                  // Optional Message Field
                  TextFormField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Enter Details",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform actions to save the expense
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 208, 158),
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
                              backgroundColor: const Color.fromARGB(255, 0, 208, 158),
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

  
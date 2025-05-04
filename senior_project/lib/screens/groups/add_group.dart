import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/screens/groups/add_participant.dart';
import 'package:senior_project/Providers/token_provider.dart';
import "package:senior_project/templates/custom_body.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import 'package:senior_project/widgets/group_icon.dart';

class AddGroup extends ConsumerStatefulWidget {
  const AddGroup({super.key});

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends ConsumerState<AddGroup> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  GroupIcon selectedIcon = GroupIcon.wallet;

  Future<void> addGroup() async {
    final name = groupNameController.text.trim();
    final budget = int.tryParse(budgetController.text.trim()) ?? 0;
     // Default icon


    if (name.isEmpty || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid group details.")),
      );
      return;
    }

    try {
      await ref.read(groupsProvider.notifier).addGroup(name, budget, selectedIcon.name , ref);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Group added successfully!")),
      );
      Navigator.pop(context); // Go back to the previous screen
      ref.refresh(groupsProvider); // Refresh the groups list
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddParticipant(),
        ),
      );

      // ✅ Go back to GroupsScreen after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding group: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Form(
          child: Column(
            //put the Icons to choose here
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Group Icon",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<GroupIcon>(
                value: selectedIcon,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 2,
                  color: Color.fromARGB(255, 0, 208, 158),
                ),
                onChanged: (GroupIcon? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedIcon = newValue;
                    });
                  }
                },
                items: GroupIcon.values.map((icon) {
                  return DropdownMenuItem<GroupIcon>(
                    value: icon,
                    child: Row(
                      children: [
                        Icon(icon.iconData, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(icon.label),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              
              const Text("Group name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
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

              Row(
                    children: [
                      SizedBox(width: 10),
                      const Text("Bugget",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(width: 10),
                      Image.asset(
                          'assets/Saudi_Riyal_Symbol.png',
                          height: 15, // Adjust symbol size relative to text
                        ),
                    ],
                  ),
              const SizedBox(height: 10),
              TextFormField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Group Budget",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: addGroup, // ✅ Call addGroup function
                  child: const Text(
                    "Add Group",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return CustomScaffold(
      title: "Groups",
      content: CustomBody(content: content),
    );
  }
}

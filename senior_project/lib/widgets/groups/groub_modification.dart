import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/config.dart';

class GroupModificationWidget extends ConsumerStatefulWidget {
  const GroupModificationWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<GroupModificationWidget> createState() =>
      _GroupModificationWidgetState();
}

class _GroupModificationWidgetState
    extends ConsumerState<GroupModificationWidget> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

   bool _isLoading = false;
   Future<void> _deleteGroup() async {
    final token = ref.read(tokenProvider);
    final groupId = ref.read(selectedGroupIdProvider);

    if (groupId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No group selected')),
      );
      return;
    }

    final url = Uri.parse('$baseUrl/groups/delete/$groupId');

    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ref.refresh(groupsProvider); // Refresh the groups list
        Navigator.pop(context); // Go back to the previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group deleted successfully')),
        );

        print('Group deleted successfully');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete group: ${response.body}')),
        );
        print('Failed to delete group: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('Error deleting group: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> _updateGroup() async {
  final token = ref.read(tokenProvider);
  final groupId = ref.read(selectedGroupIdProvider);

  if (groupId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No group selected')),
    );
    return;
  }

  final String groupName = groupNameController.text.trim();
  final String budgetText = budgetController.text.trim();

  if (groupName.isEmpty && budgetText.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a group name or budget')),
    );
    return;
  }

  Map<String, dynamic> body = {};

  if (groupName.isNotEmpty) {
    body['groupName'] = groupName;
  }
  if (budgetText.isNotEmpty) {
    final double? budget = double.tryParse(budgetText);
    if (budget != null) {
      body['budget'] = budget;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid budget number')),
      );
      return;
    }
  }

  final url = Uri.parse('$baseUrl/groups/update/$groupId');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group updated successfully')),
      );
      Navigator.pop(context); // Go back to the previous screen 
      ref.refresh(groupsProvider);
      print('Group updated successfully');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update group: ${response.body}')),
      );
      print('Failed to update group: ${response.body}');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    print('Error updating group: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Group Modification"),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Group Name"),
              SizedBox(height: 10),
              TextFormField(
                controller: groupNameController,
                decoration: const InputDecoration(
                  hintText: "New Group Name",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
          ],
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Budget"),
              SizedBox(height: 10),
              TextFormField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "New Budget",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
          ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
          onPressed: _updateGroup, // ✅ Call addGroup function
          child: Text(
            "Update Group",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 208, 158),
          ),
        ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content:
                          const Text('Are you sure you want to delete this group?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
              
                  if (confirm == true) {
                    await _deleteGroup();
                  }
                },
                child: Text("Delete Group"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          )
          // Add your group modification UI elements here
        ],
      ),
    ); // Replace with your widget implementation
  }
}

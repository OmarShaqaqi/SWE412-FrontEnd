import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/groups_provider.dart'; // Ensure correct import
import 'package:senior_project/token_provider.dart';
import "./dialog_utils.dart";

class ParticipantsList extends ConsumerStatefulWidget {
  @override
  _ParticipantsListState createState() => _ParticipantsListState();
}

class _ParticipantsListState extends ConsumerState<ParticipantsList> {
  List<String> participants = [];

  // ✅ Function to add a participant via API request
  Future<void> addParticipant() async {
    final groupId = ref.read(selectedGroupIdProvider); // ✅ Get selected groupId
    final token = ref.read(tokenProvider); // ✅ Get user token

    if (groupId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: No group selected")),
      );
      return;
    }

    final participant = await addParticipantDialog(context);
    if (participant == null) return; // If user cancels dialog, do nothing

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/participants/add"), // Replace with actual API endpoint
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "group_id": groupId, // ✅ Send the selected group ID
          "username": participant, // ✅ Send the entered username
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          participants.add(participant); // ✅ Add participant locally
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$participant added successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add participant: ${response.body}")),
        );
      }
    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred while adding participant")),
      );
    }
  }

  void removeParticipant(int index) {
    setState(() {
      participants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 191, 225, 195),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 247, 226),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: addParticipant, // ✅ Call addParticipant function
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Participants",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(participants[index] ?? ""),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    onPressed: () => removeParticipant(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

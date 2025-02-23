// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:senior_project/groups_provider.dart';
// import 'package:senior_project/token_provider.dart';
// import "package:senior_project/templates/custom_body.dart";
// import "package:senior_project/templates/custom_scaffold.dart";
// import "../../widgets/participants_list.dart";

// class AddParticipant extends ConsumerStatefulWidget {
//   const AddParticipant({super.key});

//   @override
//   _AddParticipantState createState() => _AddParticipantState();
// }

// class _AddParticipantState extends ConsumerState<AddParticipant> {
  
//   @override
//   Widget build(BuildContext context) {
//     final content = ParticipantsList();

//     return CustomScaffold(
//       title: "Add Participant",
//       content: CustomBody(content: content),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/groups_provider.dart'; // Ensure correct import
import "package:senior_project/templates/custom_body.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import "../../widgets/participants_list.dart";

class AddParticipant extends ConsumerStatefulWidget {
  const AddParticipant({super.key});

  @override
  _AddParticipantState createState() => _AddParticipantState();
}

class _AddParticipantState extends ConsumerState<AddParticipant> {
  @override
  Widget build(BuildContext context) {
    final groupId = ref.watch(selectedGroupIdProvider); 
    // ✅ Get the selected group ID
    print(groupId);
    return CustomScaffold(
      title: "Add Participant",
      content: CustomBody(
        content: Column(
          children: [
            if (groupId != null)
              Text("Adding participant to Group ID: $groupId"), // ✅ Show group ID for debugging
            const SizedBox(height: 20),
             ParticipantsList(),
          ],
        ),
      ),
    );
  }
}

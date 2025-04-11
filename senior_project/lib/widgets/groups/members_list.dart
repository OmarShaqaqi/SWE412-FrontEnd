// import 'package:flutter/widgets.dart';
// import "./participant_row.dart";
// import "../dialog_utils.dart";

// class MembersList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 16.0,
//         right: 8,
//         left: 8,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Group Leader"),
//               Text("Spending"),
//             ],
//           ),
//           ParticipantRow(),
//           const Text("Members"),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               shrinkWrap: true,
//               itemBuilder: (context, index) => GestureDetector(
//                   onTap: () {
//                     // participantInfo(context);
//                   },
//                   child: ParticipantRow()),
//             ),
//           ),
//         ],
//       ),
//     );

//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:senior_project/Providers/participants_provider.dart';
// import './participant_row.dart';
// import 'package:senior_project/models/participant_model.dart';

// class MembersList extends ConsumerWidget {
//   final int groupId; // Ensure groupId is passed

//   const MembersList({Key? key, required this.groupId}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final participantsGroup = ref.watch(participantsProvider.notifier).fetchParticipants(groupId); // Fetch from provider

//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 16.0,
//         right: 8,
//         left: 8,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Group Leader"),
//               Text("Spending"),
//             ],
//           ),
//           ParticipantRow(participant: participantsGroup[0],),
//           const Text("Members"),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               shrinkWrap: true,
//               itemBuilder: (context, index) => GestureDetector(
//                   onTap: () {
//                     // participantInfo(context);
//                   },
//                   child: ParticipantRow()),
//             ),
//           ),
//         ],
//       ),
//     );
// }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/models/participant_model.dart';
import 'package:senior_project/widgets/dialog_utils.dart';
import 'dart:convert';
import './participant_row.dart';

class MembersList extends ConsumerStatefulWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends ConsumerState<MembersList> {
  List<dynamic> participants = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchParticipants();
  }

  /// Fetch participants with token authentication
  Future<void> fetchParticipants() async {
    final token = ref.read(tokenProvider); // Get the token
    final groupId =
        ref.read(selectedGroupIdProvider); // Get the selected group ID

    if (groupId == null) {
      print("No group selected");
      setState(() {
        hasError = true;
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('http://10.0.2.2:8080/participants/get/$groupId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Include token in headers
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          participants = data;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load participants");
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Error fetching participants: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Group Leader"),
              Text("Spending"),
            ],
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (hasError)
            const Center(child: Text("Error loading participants"))
          else if (participants.isEmpty)
            const Center(child: Text("No participants found"))
          else ...[
            // Display Leader
            ParticipantRow(
              phone: participants.first['phone'] ?? 'Unknown',
              totalExpense:
                  (participants.first['totalExpense'] as num?)?.toDouble() ??
                      0.0,
              isLeader: participants.first['isLeader'] ?? false,
            ),
            const SizedBox(height: 8),
            const Text("Members"),

            // Display Other Members
            Expanded(
              child: ListView.builder(
                itemCount: participants.length - 1,
                itemBuilder: (context, index) {
                  final participant = participants[index + 1]; // Skip leader
                  return GestureDetector(
                    onTap: () {
                      participantInfo(context, Participant.fromJson(participant));
                    },
                    child: ParticipantRow(
                      phone: participant['phone'] ?? 'Unknown',
                      totalExpense:
                          (participant['totalExpense'] as num?)?.toDouble() ??
                              0.0,
                      isLeader: participant['isLeader'] ?? false,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ParticipantRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return  Padding(
//       padding:const EdgeInsets.all(8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: const Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               // Participant Name
//              const Text(
//                 "Participant",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),],
//           ),
//           const Text(
//             "\$${15}",
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:senior_project/models/participant_model.dart';


// class ParticipantRow extends StatelessWidget {
//   final Participant participant; // ✅ Accept Participant object

//   const ParticipantRow({Key? key, required this.participant}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               // Profile Icon (Blue Circle)
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: participant.isLeader ? Colors.orange : Colors.blue, // Leader gets orange color
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: const Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(width: 10),

//               // Participant Name
//               Text(
//                 participant.phone, // ✅ Display phone number
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),

//           // Total Expense
//           Text(
//             "SAR ${participant.totalExpense.toStringAsFixed(2)}", // ✅ Format amount
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senior_project/widgets/price_widget.dart';

class ParticipantRow extends StatelessWidget {
  final String phone;
  final double totalExpense;
  final bool isLeader;
  final image; // Nullable field for image

  const ParticipantRow({
    Key? key,
    required this.phone,
    required this.totalExpense,
    required this.isLeader,
    this.image, // Nullable field for image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Profile Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isLeader ? Colors.orange : Colors.blue, // Leader is orange
                  borderRadius: BorderRadius.circular(25),
                ),
                child: image != null
                    ? ClipOval(
                        child: Image.memory(
                           base64Decode(image),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
              const SizedBox(width: 10),

              // Participant Phone (or Name)
              Text(
                phone,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),

          // Total Expense
          // Text(
          //   "SAR ${totalExpense.toStringAsFixed(2)}",
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          // ),
          PriceWidget(price: totalExpense)
        ],
      ),
    );
  }
}


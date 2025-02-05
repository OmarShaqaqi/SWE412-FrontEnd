import 'package:flutter/material.dart';

// class CustomBodySearch extends StatelessWidget {
//   final Widget content;

//   const CustomBodySearch({Key? key, required this.content}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Column(
//       children: [
//         // Top Section for Header/Instructions
//         Container(
//           height: screenHeight * 0.1, // Adjust height as needed
//           color: const Color(0xFF00D09E), // Primary green
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     hintText: "Search...",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Main Content Section
//         Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(top: 20),
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               color: Color(0xFFF1FFF3), // Light green background
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40),
//                 topRight: Radius.circular(40),
//               ),
//             ),
//             child: content,
//           ),
//         ),
//       ],
//     );
//   }
// }
class CustomBodySearch extends StatelessWidget {
  final Widget content;
  final bool isCalendarPage;

  const CustomBodySearch(
      {Key? key, required this.content, this.isCalendarPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        if (!isCalendarPage) // Only show the search bar if it's not the calendar page
          Container(
            height: screenHeight * 0.1,
            color: const Color(0xFF00D09E),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Main Content Section
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF1FFF3),
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

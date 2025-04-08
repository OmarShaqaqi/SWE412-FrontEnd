// import 'package:flutter/material.dart';

// class PriceWidget extends StatelessWidget {
//   final double price;

//   const PriceWidget({Key? key, required this.price}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(
//           'assets/Saudi_Riyal_Symbol.png',
//           height: 18, // Adjust size as needed
//         ),
//         const SizedBox(width: 5), // Space between image and text
//         Text(
//           price.toStringAsFixed(2),
//           style: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w800,
//             fontSize: 25, // Larger font size
//             color: Color(0xFF0068FF),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double size; // Optional size parameter with default value

  const PriceWidget({
    Key? key,
    required this.price,
    this.size = 30, // Default size is 30 if not specified
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/Saudi_Riyal_Symbol.png',
          height: size * 0.67, // Adjust symbol size relative to text
        ),
        const SizedBox(width: 5), // Space between image and text
        Text(
          price.toStringAsFixed(2),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: size, // Use the dynamic size
            color: const Color(0xFF0068FF),
          ),
        ),
      ],
    );
  }
}

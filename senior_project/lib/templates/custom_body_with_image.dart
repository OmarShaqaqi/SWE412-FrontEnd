import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class CustomBodyWithImage extends StatelessWidget {
  final Widget content;
  final Widget profileWidget; // <-- accepts widget now

  const CustomBodyWithImage({
    super.key,
    required this.content,
    required this.profileWidget,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Light Green Section
        Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 255, 243),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: content,
        ),

        // Replace CircleAvatar with a custom widget
        Positioned(
          top: 36,
          left: (screenWidth / 2) - 50,
          child: profileWidget,
        ),
      ],
    );
  }
}

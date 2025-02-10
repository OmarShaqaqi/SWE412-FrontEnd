import 'package:flutter/material.dart';
import './custom_appbar.dart';
import './custom_body.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget content;

  const CustomScaffold({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
      appBar: CustomAppbar(title: title),
      extendBody: true,
      body: content, // Use the passed content as the body
    );
  }
}

import 'package:flutter/material.dart';
import './custom_appbar.dart';
import './custom_body.dart';
import './custom_bottom_navigation_bar.dart';

class CustomScaffoldToken extends StatelessWidget {
  final String title;
  final Widget content;
  final String token;

  const CustomScaffoldToken({super.key, required this.title, required this.content, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
      appBar: CustomAppbar(title: title),
      extendBody: true,
      body: content, // Use the passed content as the body
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); //needed from PreferredSizeWidget class
}

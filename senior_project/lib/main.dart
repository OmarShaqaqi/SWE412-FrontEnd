import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "screens/authentication/login.dart";
import "../screens/transactions/transaction_page.dart";

void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senior Project',
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import "package:senior_project/data/groups_data.dart";
import "package:senior_project/screens/groups/category_item.dart";
import "package:senior_project/screens/landingPage/landing_page.dart";
import "package:senior_project/screens/transactions/transaction_page.dart";
import "package:senior_project/widgets/groups/specific_category_expense_row.dart";
import "screens/authentication/signup.dart";
import "screens/authentication/login.dart";
import "screens/authentication/forgot_password.dart";
import "screens/profile/profile.dart";
import "screens/profile/profile_edit.dart";
import "screens/profile/profile_settings.dart";
import "screens/authentication/forgot_password.dart";
import "screens/profile/delete_account.dart";
import "screens/profile/profile_help.dart";
import "screens/groups/groups.dart";
import "screens/groups/add_group.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior Project',
      home: IntroPage(),
    );
  }
}

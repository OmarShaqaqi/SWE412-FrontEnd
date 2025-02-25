//delete later

import 'package:flutter/material.dart';
import "./category.dart";
class Group {
  final String name;
  final Icon icon;
  final List<String> participants ;
  final List<Category> categories ;
  final String groupLeader ;

  Group({required this.name, required this.icon, required this.groupLeader, required this.participants, required this.categories});
}
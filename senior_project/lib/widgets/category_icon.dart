import 'package:flutter/material.dart';
enum CategoryIcon {
  food,
  groceries,
  rent,
  health,
  entertainment,
  savings,
  transport,
  education,
  clothing,
  gifts,
}

extension CategoryIconExtension on CategoryIcon {
  String get label {
    switch (this) {
      case CategoryIcon.food:
        return 'Food';
      case CategoryIcon.groceries:
        return 'Groceries';
      case CategoryIcon.rent:
        return 'Rent';
      case CategoryIcon.health:
        return 'Health';
      case CategoryIcon.entertainment:
        return 'Entertainment';
      case CategoryIcon.savings:
        return 'Savings';
      case CategoryIcon.transport:
        return 'Transport';
      case CategoryIcon.education:
        return 'Education';
      case CategoryIcon.clothing:
        return 'Clothing';
      case CategoryIcon.gifts:
        return 'Gifts';
    }
  }

  IconData get icon {
    switch (this) {
      case CategoryIcon.food:
        return Icons.restaurant;
      case CategoryIcon.groceries:
        return Icons.shopping_bag;
      case CategoryIcon.rent:
        return Icons.home;
      case CategoryIcon.health:
        return Icons.local_hospital;
      case CategoryIcon.entertainment:
        return Icons.movie;
      case CategoryIcon.savings:
        return Icons.savings;
      case CategoryIcon.transport:
        return Icons.directions_car;
      case CategoryIcon.education:
        return Icons.menu_book;
      case CategoryIcon.clothing:
        return Icons.checkroom;
      case CategoryIcon.gifts:
        return Icons.card_giftcard;
    }
  }
}


CategoryIcon categoryIconFromString(String name) {
  return CategoryIcon.values.firstWhere(
    (e) => e.name == name,
    orElse: () => CategoryIcon.food,
  );
}
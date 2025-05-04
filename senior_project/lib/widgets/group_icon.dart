// import 'package:flutter/material.dart';


// enum GroupIcon {
//   wallet,
//   shopping,
//   travel,
//   food,
//   education,
//   health,
//   family,
//   friends,
// }

// extension GroupIconExtension on GroupIcon {
//   String get label {
//     switch (this) {
//       case GroupIcon.wallet:
//         return 'Wallet';
//       case GroupIcon.shopping:
//         return 'Shopping';
//       case GroupIcon.travel:
//         return 'Travel';
//       case GroupIcon.food:
//         return 'Food';
//       case GroupIcon.education:
//         return 'Education';
//       case GroupIcon.health:
//         return 'Health';
//       case GroupIcon.family:
//         return 'Family';
//       case GroupIcon.friends:
//         return 'Friends';
//     }
//   }

//   IconData get iconData {
//     switch (this) {
//       case GroupIcon.wallet:
//         return Icons.account_balance_wallet;
//       case GroupIcon.shopping:
//         return Icons.shopping_cart;
//       case GroupIcon.travel:
//         return Icons.flight;
//       case GroupIcon.food:
//         return Icons.restaurant;
//       case GroupIcon.education:
//         return Icons.school;
//       case GroupIcon.health:
//         return Icons.favorite;
//       case GroupIcon.family:
//         return Icons.family_restroom;
//       case GroupIcon.friends:
//         return Icons.group;
//     }
//   }
// }

// GroupIcon? groupIconFromString(String iconName) {
//   return GroupIcon.values.firstWhere(
//     (e) => e.name == iconName,
//     orElse: () => GroupIcon.wallet, // Fallback
//   );
// }
import 'package:flutter/material.dart';

/// Enum representing group icons
enum GroupIcon {
  wallet,
  family,
  friends,
  team,
  travel,
  work,
  study,
  personal,
}

extension GroupIconExtension on GroupIcon {
  /// Human-readable label
  String get label {
    switch (this) {
      case GroupIcon.wallet:
        return 'Wallet';
      case GroupIcon.family:
        return 'Family';
      case GroupIcon.friends:
        return 'Friends';
      case GroupIcon.team:
        return 'Team Project';    
      case GroupIcon.travel:
        return 'Travel';
      case GroupIcon.work:
        return 'Work';
      case GroupIcon.study:
        return 'Study Group';
      case GroupIcon.personal:
        return 'Personal';
    }
  }

  /// Icon for the group
  IconData get iconData {
    switch (this) {
      case GroupIcon.wallet:
        return Icons.account_balance_wallet;
      case GroupIcon.family:
        return Icons.family_restroom;
      case GroupIcon.friends:
        return Icons.people;
      case GroupIcon.team:
        return Icons.groups;     
      case GroupIcon.travel:
        return Icons.flight_takeoff;
      case GroupIcon.work:
        return Icons.work;
      case GroupIcon.study:
        return Icons.school;
      case GroupIcon.personal:
        return Icons.person;
    }
  }
}

/// Convert string to enum
GroupIcon groupIconFromString(String iconName) {
  return GroupIcon.values.firstWhere(
    (e) => e.name == iconName,
    orElse: () => GroupIcon.wallet,
  );
}

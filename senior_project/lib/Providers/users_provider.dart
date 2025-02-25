import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './token_provider.dart'; // Assuming you have a token provider

class UserRoleNotifier extends StateNotifier<bool> {
  final Ref ref;
  String? currentGroupId;  // This will store the groupId for which we are fetching the role

  UserRoleNotifier(this.ref) : super(false);

  // Load the user's role in a specific group from the backend
  Future<void> loadUserRole(String groupId) async {
    final token = ref.read(tokenProvider);  // Read JWT token from tokenProvider

    try {
      // API call to the backend to fetch user role for the current group
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/groups/$groupId/user-role'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final isLeader = json.decode(response.body);  // Parse response body


        // Update the state with the fetched role (leader or participant)
        state = isLeader;
        currentGroupId = groupId; // Store the group ID for which the role was fetched
      } else {
        throw Exception('Failed to load user role');
      }
    } catch (e) {
      throw Exception('Error fetching user role: $e');
    }
  }

  // Check if the role has been loaded for the current group
  bool hasRole() {
    return currentGroupId != null;
  }
}

final userRoleProvider = StateNotifierProvider<UserRoleNotifier, bool>((ref) {
  return UserRoleNotifier(ref);
});

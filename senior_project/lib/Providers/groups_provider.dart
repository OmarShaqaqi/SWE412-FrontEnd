import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/group_model.dart';
import 'token_provider.dart';

class GroupsNotifier extends StateNotifier<List<Group>> {
  final Ref ref;

  GroupsNotifier(this.ref) : super([]) {
    fetchGroups(); // Load initial data
  }

  Future<void> fetchGroups() async {
    final token = ref.read(tokenProvider);

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/groups/get'), // Replace with your actual API endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        state = jsonList.map((json) => Group.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load groups');
      }
    } catch (e) {
      throw Exception('Error fetching groups: $e');
    }
  }

Future<void> addGroup(String name, int budget, WidgetRef ref) async {
  final token = ref.read(tokenProvider);

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/groups/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'budget': budget,
      }),
    );

    if (response.statusCode == 200) {
      final newGroup = Group.fromJson(json.decode(response.body));
      state = [...state, newGroup]; // ✅ Update provider state with the new group

      // ✅ Save the groupId in selectedGroupIdProvider
      ref.read(selectedGroupIdProvider.notifier).state = newGroup.id;
      

      print("Selected Group ID: ${newGroup.id}");
    } else {
      throw Exception('Failed to add group');
    }
  } catch (e) {
    throw Exception('Error adding group: $e');
  }
}

}

// Define the provider
final groupsProvider =
    StateNotifierProvider<GroupsNotifier, List<Group>>((ref) {
  return GroupsNotifier(ref);
});


final selectedGroupIdProvider = StateProvider<int?>((ref) => null);

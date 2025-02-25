import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/Providers/groups_provider.dart';
import 'package:senior_project/models/category_model.dart';
import 'dart:convert';
import './token_provider.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  final Ref ref;
  bool _isLoading = false; // Loading state

  CategoriesNotifier(this.ref) : super([]);

  bool get isLoading => _isLoading; // Expose loading state

  Future<void> fetchCategories(int groupId) async {
    _isLoading = true;
    state = []; // Reset state before fetching
    final token = ref.read(tokenProvider);
    final Uri url = Uri.parse('http://10.0.2.2:8080/categories/list?groupId=$groupId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        state = jsonList.map((json) => Category.fromJson(json)).toList();
      } else {
        print('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }

    _isLoading = false; // Mark loading as complete
  }
  Future<void> addCategory(String categoryName) async {
    final token = ref.read(tokenProvider);  // Get the token from the token provider
    final selectedGroup = ref.read(selectedGroupIdProvider);  // Get the selected group ID from the provider

    final Uri url = Uri.parse('http://10.0.2.2:8080/categories/add');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body:json.encode({
        'groupId': selectedGroup,
        'categoryName': categoryName,
      }),
      );

      if (response.statusCode == 200) {
        state = [...state, Category(categoryName: categoryName, groupId : selectedGroup!)];
      } else {
        throw Exception('Failed to add category');
      }
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }
}

final categoriesProvider = StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
  return CategoriesNotifier(ref);
});

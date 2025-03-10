import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ✅ UserNotifier to manage username state
class UserNotifier extends StateNotifier<String> {
  UserNotifier() : super("Loading...") {
    _loadUsername();
  }

  // ✅ Load the username from persistent storage (SharedPreferences)
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString("username") ?? "Guest";
    state = storedName;
  }

  // ✅ Update username and store it persistently
  Future<void> updateUsername(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", newName);
    state = newName; // ✅ Automatically updates across all screens
  }
}

// ✅ Provide the username globally
final userProvider = StateNotifierProvider<UserNotifier, String>((ref) {
  return UserNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/config.dart';
import 'package:senior_project/models/participant_model.dart';
import 'dart:convert';
import './token_provider.dart';

class ParticipantsNotifier extends StateNotifier<List<Participant>> {
  final Ref ref;
  bool _isLoading = false; // Loading state

  ParticipantsNotifier(this.ref) : super([]);

  bool get isLoading => _isLoading; // Expose loading state

  Future<void> fetchParticipants(int groupId) async {
    _isLoading = true;
    state = []; // Reset state before fetching
    final token = ref.read(tokenProvider);
    final Uri url = Uri.parse('$baseUrl/participants/get/$groupId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Participant> participants= data.map((json) => Participant.fromJson(json)).toList();
          state = participants;

      } else {
        print('Failed to load participants: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching participants: $e');
    }

    _isLoading = false; // Mark loading as complete
  }
}

final participantsProvider = StateNotifierProvider<ParticipantsNotifier, List<Participant>>((ref) {
  return ParticipantsNotifier(ref);
});

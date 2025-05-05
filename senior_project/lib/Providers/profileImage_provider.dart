import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/config.dart';

import 'package:http/http.dart' as http;

final profileImageProvider = FutureProvider<Uint8List?>((ref) async {
  final token = ref.read(tokenProvider);
  final url = Uri.parse('$baseUrl/getProfilePicture');

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    print("json");
    final  data = json.decode(response.body);
    print(json.decode(response.body));
    final base65Image = base64Decode(data["image"]); 


    return base65Image; // image as Uint8List
  } else {
    throw Exception('Failed to fetch image');
  }
});

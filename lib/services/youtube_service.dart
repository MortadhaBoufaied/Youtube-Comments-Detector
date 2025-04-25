import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../config.dart'; // import your config

class YouTubeService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/youtube.readonly',
    ],
    serverClientId: AppConfig.serverClientId, // ✅ must be your Web client ID
    forceCodeForRefreshToken: true, // optional but useful
  );

  Future<List<dynamic>> fetchUserVideos() async {
    try {
      final account = await _googleSignIn.signIn();
      final authHeaders = await account!.authHeaders;
      final client = http.Client();

      final response = await client.get(
        Uri.parse('https://www.googleapis.com/youtube/v3/channels?part=snippet,contentDetails,statistics&mine=true'),
        headers: {
          'Authorization': authHeaders['Authorization']!,
        },
      );

      final data = json.decode(response.body);
      return data['items'];
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return [];
    }
  }
}

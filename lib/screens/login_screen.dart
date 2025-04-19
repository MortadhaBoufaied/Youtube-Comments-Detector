/// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'video_list_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Connexion YouTube')),
      body: Center(
        child: ElevatedButton(
          child: Text('Se connecter avec Google'),
          onPressed: () async {
            await auth.signIn();
            if (auth.user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => VideoListScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/video_list_screen.dart';
import 'screens/toxic_alerts_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YouTube Toxic Detector',
        theme: ThemeData(primarySwatch: Colors.red),

        // Initial route
        initialRoute: '/login',

        // Named routes
        routes: {
          '/login': (context) => LoginScreen(),
          '/videos': (context) => VideoListScreen(),
          '/alerts': (context) => ToxicAlertsScreen(),
        },
      ),
    );
  }
}

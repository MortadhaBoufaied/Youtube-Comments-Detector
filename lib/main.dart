import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/splashscreen.dart';

import 'screens/login_screen.dart';
import 'screens/video_list_screen.dart';
import 'screens/toxic_alerts_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ask for notification permission
  final status = await Permission.notification.request();


  if (status.isDenied) {
    print('Notification permission denied.');
  }
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
        // 👇 Set theme mode to system
        themeMode: ThemeMode.system,
        // 👇 Define light theme
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
            foregroundColor: Colors.black,
          ),
        ),
// 👇 Define dark theme
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.black26,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        // Initial route
        initialRoute: '/splash',

        // Named routes
        routes: {
          '/login': (context) => LoginScreen(),
          '/videos': (context) => VideoListScreen(),
          '/alerts': (context) => ToxicAlertsScreen(),
          '/splash': (context) => const SplachScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/profile_screens/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toxic_comments_detector_youtube/services/localization_service.dart';

import 'screens/splashscreen.dart';
import 'screens/login_screen.dart';
import 'screens/video_list_screen.dart';
import 'screens/toxic_alerts_screen.dart';
import 'services/auth_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final status = await Permission.notification.request();
  if (status.isDenied) {
    if (kDebugMode) {
      print('Notification permission denied.');
    }
  }

  await _initializeNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(
    const AndroidNotificationChannel(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 👈 Access the existing provider

    return MaterialApp(
      locale: themeProvider.locale,
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
        Locale('fr'), // French
        Locale('zh'), // Chinese
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'YouTube Toxic Detector',

      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black38,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),

      initialRoute: '/splash',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/videos': (context) => const VideoListScreen(),
        '/alerts': (context) => const ToxicAlertsScreen(),
        '/splash': (context) => const SplachScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/localization_service.dart';
import 'language_selector.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'theme_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = false;
  String selectedLanguage = 'en'; // default to English


  final languageLabels = {
    'en': 'English',
    'fr': 'Français',
    'ar': 'العربية',
    'zh': '中文',
  };
  final languageCodes = {
    'English': 'en',
    'Français': 'fr',
    'العربية': 'ar',
    '中文': 'zh',
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';
    });
  }

  Future<void> saveNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);

    if (!value) {
      await flutterLocalNotificationsPlugin.cancelAll();
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Notifications Enabled',
        'You will now receive alerts',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.15),
        toolbarHeight: 65,
        title: Text(
          AppLocalizations.of(context).translate('general'),
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            secondary: const FaIcon(Icons.notifications_active_outlined),
            title: Text(AppLocalizations.of(context).translate('notifications'), style: GoogleFonts.poppins()),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() {
                notificationsEnabled = val;
              });
              saveNotificationSetting(val);
            },
          ),
          const SizedBox(height: 10),

          SwitchListTile(
            secondary: const FaIcon(Icons.dark_mode_outlined),
            title: Text(AppLocalizations.of(context).translate('dark_mode'), style: GoogleFonts.poppins()),
            value: themeProvider.isDarkMode,
            onChanged: (val) {
              themeProvider.toggleTheme(val);
            },
          ),
          const SizedBox(height: 10),

          ListTile(
            leading: const FaIcon(Icons.language_outlined),
            title: Text(
              AppLocalizations.of(context).translate('language'),
              style: GoogleFonts.poppins(),
            ),
            subtitle: Text(
    languageLabels[selectedLanguage] ?? selectedLanguage.toUpperCase(),
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return LanguageSelector(
                    currentLanguage: selectedLanguage,
                    onLanguageSelected: (langName) async {
                      final langCode = languageCodes[langName]; // Get the code from name
                      if (langCode == null) return;

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedLanguage', langCode);

                      Provider.of<ThemeProvider>(context, listen: false).setLocale(Locale(langCode));

                      setState(() {
                        selectedLanguage = langCode;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),

          ListTile(
            leading: const FaIcon(Icons.cleaning_services_outlined),
            title: Text(AppLocalizations.of(context).translate('clear_cache'), style: GoogleFonts.poppins()),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              await DefaultCacheManager().emptyCache();
              PaintingBinding.instance.imageCache.clear();
              PaintingBinding.instance.imageCache.clearLiveImages();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context).translate('cache_cleared')),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

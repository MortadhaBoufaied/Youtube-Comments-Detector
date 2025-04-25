import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/profile_screens/theme_provider.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageSelected;

  LanguageSelector({super.key, required this.currentLanguage, required this.onLanguageSelected});

  final languages = {
    'English': 'en',
    'العربية': 'ar',
    'Français': 'fr',
    '中文': 'zh',
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: languages.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          onTap: () {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.setLocale(Locale(entry.value));

                      onLanguageSelected(entry.key);
          },
        );
      }).toList(),
    );
  }
}

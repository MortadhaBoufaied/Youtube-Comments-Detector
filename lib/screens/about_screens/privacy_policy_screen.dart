import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/localization_service.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('privacy_policy'),
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('pyp'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('ppt1'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('pp1'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('ppt2'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('pp2'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('ppt3'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('pp3'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('ppt4'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('pp4'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

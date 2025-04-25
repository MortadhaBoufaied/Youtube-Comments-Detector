import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/localization_service.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('terms_of_service'),
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
                AppLocalizations.of(context).translate('tys'), style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('tst1'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
                AppLocalizations.of(context).translate('ts1'), style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('tst2'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('ts2'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
                AppLocalizations.of(context).translate('tst3'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('ts3'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
                AppLocalizations.of(context).translate('tst4'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('ts4'), style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

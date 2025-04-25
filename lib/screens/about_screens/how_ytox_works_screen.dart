import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/localization_service.dart';

class HowYTOXWorksScreen extends StatelessWidget {
  const HowYTOXWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('how_works'), style: GoogleFonts.poppins()),
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
              AppLocalizations.of(context).translate('hyw1'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 24),

            Text(
              AppLocalizations.of(context).translate('hwt1'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('hw1'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),

            Text(
              AppLocalizations.of(context).translate('hwt2'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('hw2'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),

            Text(
              AppLocalizations.of(context).translate('hwt3'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('hw3'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),

            Text(
              AppLocalizations.of(context).translate('hwt4'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              AppLocalizations.of(context).translate('hw4'),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toxic_comments_detector_youtube/screens/about_screens/how_ytox_works_screen.dart';
import 'package:toxic_comments_detector_youtube/screens/about_screens/privacy_policy_screen.dart';
import 'package:toxic_comments_detector_youtube/screens/about_screens/terms_of_service_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/localization_service.dart';
import 'package:in_app_review/in_app_review.dart';

import 'theme_provider.dart';



class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});



  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {


  @override
  void initState() {
    super.initState();
  }
  void rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;

    try {
      final isAvailable = await inAppReview.isAvailable();
      if (isAvailable) {
        await inAppReview.requestReview();
      } else {
        await inAppReview.openStoreListing(); // fallback to store page
      }
    } catch (e) {
      debugPrint('Error during in-app review: $e');
      // Optional: show a snackbar or redirect to store
    }
  }
  void shareYTOX() {
    Share.share(
      '🛡️ Check out YTOX — an app that detects toxic YouTube comments using AI! Download it now: https://yourapp.link',
      subject: 'Try YTOX!',
    );
  }


  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.15),
        toolbarHeight: 65,
        title: Text(
          AppLocalizations.of(context).translate('about'),
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 40),

          // YTOX Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade400, Colors.red.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.shade900.withOpacity(0.5),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      offset: const Offset(-2, -2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  'YTOX',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              'v1.0.0',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ListTiles
          ListTile(
            leading: const FaIcon(Icons.privacy_tip_outlined),
            title: Text(AppLocalizations.of(context).translate('privacy_policy'), style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const PrivacyPolicyScreen(), // your target screen
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Slide from right
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(AppLocalizations.of(context).translate('terms_of_service'), style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const TermsOfServiceScreen(), // your target screen
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Slide from right
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(AppLocalizations.of(context).translate('how_works'), style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const HowYTOXWorksScreen(), // your target screen
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Slide from right
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),);
            },
          ),

          ListTile(
            leading: const Icon(Icons.star_border),
            title: Text(AppLocalizations.of(context).translate('rate_this_app'), style: GoogleFonts.poppins()),
            onTap: () => rateApp(),
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(AppLocalizations.of(context).translate('share'), style: GoogleFonts.poppins()),
            onTap: shareYTOX,
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: Text(AppLocalizations.of(context).translate('contact_support'), style: GoogleFonts.poppins()),
            subtitle: Text('ytox.app@gmail.com', style: GoogleFonts.poppins(fontSize: 12)),
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'support@ytox.app', // Replace with your support email
                queryParameters: {
                  'subject': 'Support Request - YTOX App',
                },
              );

              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(AppLocalizations.of(context).translate('error'))),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(AppLocalizations.of(context).translate('licenses'), style: GoogleFonts.poppins()),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
        ],
      ),

    );
  }
}

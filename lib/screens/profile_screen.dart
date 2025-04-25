/// screens/toxic_alerts_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/profile_screens/about_screen.dart';
import 'package:toxic_comments_detector_youtube/screens/profile_screens/general_screen.dart';
import 'package:toxic_comments_detector_youtube/screens/toxic_alerts_screen.dart';
import '../services/auth_service.dart';
import '../services/localization_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70), // Slightly larger for spacing
        child: AppBar(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.15), // Soft shadow

          leadingWidth: 50,
          toolbarHeight: 65, // More precise height

          actions: [
            Builder(
              builder: (context) {
                final auth = Provider.of<AuthService>(context, listen: false);
                final photoUrl = auth.user?.photoUrl;
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.solidBell,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ToxicAlertsScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.network(
                            photoUrl ?? '',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const FaIcon(Icons.account_circle_outlined,
                                  size: 32,);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          title: Text(
            AppLocalizations.of(context).translate('account'),
            style: GoogleFonts.poppins(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const FaIcon(Icons.settings_rounded),
            title: Text(AppLocalizations.of(context).translate('general'), style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const GeneralScreen(), // your target screen
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
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const FaIcon(Icons.info_outline_rounded),
            title: Text(AppLocalizations.of(context).translate('about'), style: GoogleFonts.poppins()),
            onTap: () {

              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const AboutScreen(), // your target screen
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
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const FaIcon(Icons.logout_rounded),
            title: Text(AppLocalizations.of(context).translate('sign_out'),
                style: GoogleFonts.poppins(color: Colors.redAccent)),
            onTap: () async {
              final auth = Provider.of<AuthService>(context, listen: false);
              await auth.signOut();
              // Navigate to login screen, replace as needed
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}

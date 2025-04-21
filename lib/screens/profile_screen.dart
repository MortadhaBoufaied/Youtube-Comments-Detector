/// screens/toxic_alerts_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/toxic_alerts_screen.dart';
import '../services/auth_service.dart';
import '../services/toxicity_service.dart';

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
          backgroundColor: Colors.white,
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
                          color: Colors.black,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ToxicAlertsScreen()),
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
                              return const Icon(Icons.account_circle,
                                  size: 32, color: Colors.black);
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
            'Account',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text("General", style: GoogleFonts.poppins()),
            onTap: () {
              // TODO: Navigate to General settings

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text("About", style: GoogleFonts.poppins()),
            onTap: () {
              // TODO: Navigate to About screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("About tapped")),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Sign Out",
                style: GoogleFonts.poppins(color: Colors.redAccent)),
            onTap: () async {
              final auth = Provider.of<AuthService>(context, listen: false);
              await auth.signOut();
              // Navigate to login screen, replace as needed
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toxic_comments_detector_youtube/screens/profile_screen.dart';
import '../services/auth_service.dart';
import '../services/toxicity_service.dart';
import '../services/localization_service.dart'; // Import for translations

class ToxicAlertsScreen extends StatefulWidget {
  const ToxicAlertsScreen({super.key});

  @override
  _ToxicAlertsScreenState createState() => _ToxicAlertsScreenState();
}

class _ToxicAlertsScreenState extends State<ToxicAlertsScreen> {
  List<Map<String, String>> _toxicComments = [];

  @override
  void initState() {
    super.initState();
    loadToxicComments();
  }

  Future<void> loadToxicComments() async {
    final comments = await ToxicityService().fetchToxicComments();
    setState(() {
      _toxicComments = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context).translate;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.15),
          leadingWidth: 50,
          toolbarHeight: 65,
          actions: [
            Builder(
              builder: (context) {
                final auth = Provider.of<AuthService>(context, listen: false);
                final photoUrl = auth.user?.photoUrl;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.solidBell,
                          color: Colors.black,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.network(
                              photoUrl ?? '',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.account_circle, size: 32);
                              },
                            ),
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
            t('notifications'),
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      body: _toxicComments.isEmpty
          ? Center(child: Text(t('no_toxic_comments')))
          : ListView.builder(
        itemCount: _toxicComments.length,
        itemBuilder: (context, index) {
          final comment = _toxicComments[index];
          return ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
            ),
            title: Text(
              comment['text']!,
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              comment['author'] ?? '',
              style: GoogleFonts.inter(color: Colors.grey.shade700),
            ),
            trailing: Text(
              comment['time'] ?? '',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600),
            ),
          );
        },
      ),
    );
  }
}

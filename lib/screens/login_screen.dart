import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'video_list_screen.dart';
import '../services/localization_service.dart'; // Make sure this is imported

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<IconData> backgroundIcons = [
    FontAwesomeIcons.youtube,
    FontAwesomeIcons.commentDots,
    FontAwesomeIcons.skullCrossbones,
    FontAwesomeIcons.ban,
  ];

  bool _isLoading = false;

  List<Widget> _buildRandomIcons(Size screenSize) {
    final random = Random();
    final usedPositions = <Offset>[];

    return List.generate(25, (index) {
      IconData icon = backgroundIcons[random.nextInt(backgroundIcons.length)];
      double iconSize = 40 + random.nextDouble() * 20;

      Offset position;
      int tries = 0;
      do {
        position = Offset(
          random.nextDouble() * (screenSize.width - iconSize),
          random.nextDouble() * (screenSize.height - iconSize),
        );
        tries++;
      } while (
      usedPositions.any((p) => (p - position).distance < iconSize + 20) &&
          tries < 100);

      usedPositions.add(position);

      return Positioned(
        left: position.dx,
        top: position.dy,
        child: FaIcon(
          icon,
          color: Colors.red.withOpacity(0.08),
          size: iconSize,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final screenSize = MediaQuery.of(context).size;
    final t = AppLocalizations.of(context).translate;

    return Scaffold(
      body: Stack(
        children: [
          ..._buildRandomIcons(screenSize),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t('app_title'),
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.red.shade200,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t('login_agreement'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.red.shade900,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.red.shade200,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      elevation: 10,
                      shadowColor: Colors.red.shade200,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: _isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Image.network(
                      'https://imgs.search.brave.com/lBtw7l3MhojeV-JYt7sjdC3YR7IeRPqIBsZV4cpJMiM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mcmVl/bG9nb3BuZy5jb20v/aW1hZ2VzL2FsbF9p/bWcvMTY1Nzk1MjQ0/MGdvb2dsZS1sb2dv/LXBuZy10cmFuc3Bh/cmVudC5wbmc',
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      t('sign_in_with_google'),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      await Future.delayed(const Duration(milliseconds: 600));

                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const VideoListScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
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
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

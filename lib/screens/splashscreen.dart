/// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toxic_comments_detector_youtube/screens/login_screen.dart';


class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(), // your target screen
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
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      shadows: [
                        const Shadow(
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
            const SizedBox(height: 20),
            SizedBox(
              width: 135,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade200.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [Colors.red.shade100, Colors.red.shade300],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _animation.value,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade600),
                      ),
                    ),
                  );
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}

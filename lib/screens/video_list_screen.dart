/// screens/video_list_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/youtube_service.dart';
import 'toxic_alerts_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final List<dynamic> _videos = [
    {
      'id': 'a1b2c3',
      'title': 'How to Learn Flutter Fast',
      'thumbnailUrl': 'https://i.ytimg.com/vi/fq4N0hgOWzU/mqdefault.jpg',
      'channelTitle': 'Flutter Academy',
      'publishedAt': '2024-04-15',
      'commentCount': '12345',
    },
    {
      'id': 'd4e5f6',
      'title': 'Understanding Dart in 10 Minutes',
      'thumbnailUrl': 'https://imgs.search.brave.com/oebPEJjRoM9oTSyFZsBgg4N46tT_ladIYYNeYSHiQXA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9idXJz/dC5zaG9waWZ5Y2Ru/LmNvbS9waG90b3Mv/aWNlLWNyYWNrcy1v/bi1hLWZyb3plbi1z/ZWEuanBnP3dpZHRo/PTEwMDAmZm9ybWF0/PXBqcGcmZXhpZj0w/JmlwdGM9MA',
      'channelTitle': 'CodeSimplify',
      'publishedAt': '2024-03-28',
      'commentCount': '8765',
    },
    {
      'id': 'g7h8i9',
      'title': 'Flutter UI Tutorial - Beautiful App Design',
      'thumbnailUrl': 'https://i.ytimg.com/vi/x0uinJvhNxI/mqdefault.jpg',
      'channelTitle': 'Design With Flutter',
      'publishedAt': '2024-02-10',
      'commentCount': '4567',
    },
  ];

  bool _loading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      setState(() {
        _loading = true;
        _hasError = false;
      });

      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        // No internet
        setState(() {
          _hasError = true;
          _loading = false;
        });
        return;
      }



      setState(() {

        _loading = false;
      });
    } catch (e) {
      print("❌ Error: $e");
      setState(() {
        _hasError = true;
        _loading = false;
      });
    }
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
          automaticallyImplyLeading: false,
          leadingWidth: 110,
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
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ToxicAlertsScreen(), // your target screen
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
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'logout') {
                            auth.signOut();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'profile',
                            child: Text('Profile'),
                          ),
                          const PopupMenuItem(
                            value: 'logout',
                            child: Text('Logout'),
                          ),
                        ],
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
                                return Icon(Icons.account_circle, size: 32, color: Colors.black);
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

          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  'YTOX',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),



      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.red,))
          : _hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_connection.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            Text(
              'No internet connection',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: fetchVideos,
              icon: const Icon(FontAwesomeIcons.refresh,color: Colors.white,),
              label: Text('Retry',style: GoogleFonts.inter(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
              ),
            ),
          ],
        ),
      )
      :ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          final toxicCount = video['toxicCommentCount'] ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    video['thumbnailUrl'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  video['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${video['commentCount']} Comments • ${video['publishedAt']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '$toxicCount',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Optional: Navigate to video details or handle tap
                },
              ),
            ),
          );
        },
      )



    );
  }
}

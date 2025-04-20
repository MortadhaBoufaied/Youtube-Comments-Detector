/// screens/video_list_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<dynamic> _videos = [
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 2,
        automaticallyImplyLeading: false,
        leadingWidth: 110,

        actions: [
           Builder(
            builder: (context) {
              final auth = Provider.of<AuthService>(context, listen: false);
              final photoUrl = auth.user?.photoUrl;
              return Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.bell,
                        color: Colors.red.shade400,
                        size: 30,
                      ),
                      onPressed: () {
                        // TODO: Handle notification logic
                      },
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'logout') {
                          auth.signOut();
                          // Optionally navigate back to login screen
                        }
                        // Handle other options if needed
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
                              return Center(

                              );
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'YTOX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
            const Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: fetchVideos,
              icon: const Icon(FontAwesomeIcons.refresh,color: Colors.white,),
              label: const Text('Retry',style: TextStyle(color: Colors.white),),
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
          return Padding(

            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    video['thumbnailUrl'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                // Video Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade300,

                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${video['viewCount']} Comments • ${video['publishedAt']}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Optionally handle menu actions
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),


    );
  }
}

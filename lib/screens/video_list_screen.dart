/// screens/video_list_screen.dart
import 'package:flutter/material.dart';
import '../services/youtube_service.dart';
import 'toxic_alerts_screen.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<dynamic> _videos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final videos = await YouTubeService().fetchUserVideos();
    setState(() {
      _videos = videos;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Vidéos')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return ListTile(
            title: Text(video['title']),
            subtitle: Text(video['id']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.warning),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ToxicAlertsScreen()),
          );
        },
      ),
    );
  }
}

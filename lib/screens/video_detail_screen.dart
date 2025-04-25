import 'package:flutter/material.dart';

class VideoDetailScreen extends StatefulWidget {
  final Map<String, dynamic> video;

  const VideoDetailScreen({super.key, required this.video});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    comments = [
      {'text': 'This is so dumb!', 'toxic': true, 'userAvatar': 'https://i.pravatar.cc/150?img=1'},
      {'text': 'Great content!', 'toxic': false, 'userAvatar': 'https://i.pravatar.cc/150?img=2'},
      {'text': 'Worst video ever!', 'toxic': true, 'userAvatar': 'https://i.pravatar.cc/150?img=3'},
    ];
    setState(() {});
  }

  void _deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }

  void _minimizeVideoAndGoBack() {
    // You can use Navigator.pop here and trigger floating player outside this screen
    Navigator.pop(context, widget.video);
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25,),
          Stack(
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.network(
                  video['thumbnailUrl'],
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _minimizeVideoAndGoBack,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                if (!comment['toxic']) return const SizedBox.shrink();
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment['userAvatar']),
                  ),
                  title: Text(comment['text']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => _deleteComment(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

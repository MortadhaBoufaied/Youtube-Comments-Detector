import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class VideoDetailScreen extends StatefulWidget {
  final Map<String, dynamic> video;

  const VideoDetailScreen({super.key, required this.video});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  List<Map<String, dynamic>> comments = [];
  int? translatingIndex;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<String> _translateText(String text, String targetLang) async {
    final translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: _getLanguageFromCode(targetLang),
    );
    final translatedText = await translator.translateText(text);
    await translator.close();
    return translatedText;
  }

  TranslateLanguage _getLanguageFromCode(String code) {
    switch (code) {
      case 'fr':
        return TranslateLanguage.french;
      case 'es':
        return TranslateLanguage.spanish;
      case 'de':
        return TranslateLanguage.german;
      default:
        return TranslateLanguage.english;
    }
  }

  void _loadComments() {
    comments = [
      {
        'text': 'This is so dumb!',
        'originalText': 'This is so dumb!', // keep original
        'toxic': true,
        'userAvatar': 'https://i.pravatar.cc/150?img=1'
      },
      {
        'text': 'Great content!',
        'originalText': 'Great content!',
        'toxic': false,
        'userAvatar': 'https://i.pravatar.cc/150?img=2'
      },
      {
        'text': 'Worst video ever!',
        'originalText': 'Worst video ever!',
        'toxic': true,
        'userAvatar': 'https://i.pravatar.cc/150?img=3'
      },
    ];
    setState(() {});
  }

  void _deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }

  void _minimizeVideoAndGoBack() {
    Navigator.pop(context, widget.video);
  }

  void _showLanguagePicker(int index) async {
    String? chosen = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Translate to French'),
              onTap: () => Navigator.pop(context, 'fr'),
            ),
            ListTile(
              title: const Text('Translate to Spanish'),
              onTap: () => Navigator.pop(context, 'es'),
            ),
            ListTile(
              title: const Text('Translate to German'),
              onTap: () => Navigator.pop(context, 'de'),
            ),
          ],
        );
      },
    );

    if (chosen != null) {
      setState(() {
        translatingIndex = index;
      });

      final translatedText = await _translateText(
        comments[index]['originalText'], // always translate the ORIGINAL text
        chosen,
      );

      setState(() {
        comments[index]['text'] = translatedText;
        translatingIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      translatingIndex == index
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : IconButton(
                        icon: const Icon(Icons.translate, color: Colors.blueAccent),
                        onPressed: () => _showLanguagePicker(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _deleteComment(index),
                      ),
                    ],
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

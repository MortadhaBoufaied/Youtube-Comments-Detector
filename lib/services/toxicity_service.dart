/// services/toxicity_service.dart
class ToxicityService {
  Future<List<Map<String, String>>> fetchToxicComments() async {
    // Simulate a network call with structured data
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'text': 'Ce contenu est nul !',
        'author': 'UtilisateurFâché',
        'time': '1h ago'
      },
      {
        'text': 'Tu es vraiment idiot.',
        'author': 'Anonyme77',
        'time': '3h ago'
      },
      {
        'text': 'Quel commentaire détestable.',
        'author': 'HaterPro',
        'time': '1d ago'
      },
    ];
  }
}

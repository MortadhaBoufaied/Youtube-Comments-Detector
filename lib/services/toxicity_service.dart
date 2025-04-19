/// services/toxicity_service.dart
class ToxicityService {
  Future<List<String>> fetchToxicComments() async {
    // ⚠️ Remplacer ce bloc avec une vraie analyse NLP (ML Kit, Perspective API, etc.)
    await Future.delayed(Duration(seconds: 2));
    return [
      "Ce contenu est nul !",
      "Tu es vraiment idiot.",
      "Quel commentaire détestable."
    ];
  }
}

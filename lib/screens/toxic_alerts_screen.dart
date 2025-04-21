/// screens/toxic_alerts_screen.dart
import 'package:flutter/material.dart';
import '../services/toxicity_service.dart';

class ToxicAlertsScreen extends StatefulWidget {
  @override
  _ToxicAlertsScreenState createState() => _ToxicAlertsScreenState();
}

class _ToxicAlertsScreenState extends State<ToxicAlertsScreen> {
  List<String> _toxicComments = [];

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
    return Scaffold(
      appBar: AppBar(title: Text('Alertes de toxicité')),
      body: ListView.builder(
        itemCount: _toxicComments.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.report, color: Colors.red),
          title: Text(_toxicComments[index]),
        ),
      ),
    );
  }
}

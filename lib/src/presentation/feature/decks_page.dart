import 'package:material_ui/material_ui.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});

  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Decks Page')));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_decks/src/app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode _selectedMode;
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() => _version = info.version);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = context.findAncestorStateOfType<FlutterDecksAppState>();
    _selectedMode = appState?.themeMode ?? ThemeMode.system;
  }

  void _onThemeChanged(ThemeMode? mode) {
    if (mode == null) return;
    final appState = context.findAncestorStateOfType<FlutterDecksAppState>();
    appState?.setThemeMode(mode);
    setState(() {
      _selectedMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<ThemeMode>(
              initialValue: _selectedMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: _onThemeChanged,
              decoration: const InputDecoration(
                labelText: 'Theme',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 12),
            Center(child: Text('About', style: textTheme.titleMedium)),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'FlutterDecks',
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (_version.isNotEmpty) ...[
              const SizedBox(height: 2),
              Center(
                child: Text(
                  'v$_version',
                  style: textTheme.bodySmall,
                ),
              ),
            ],
            const SizedBox(height: 4),
            Center(
              child: Text(
                'A modern flashcard learning app built with Flutter.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: InkWell(
                onTap: () => launchUrl(
                  Uri.parse('https://github.com/Bl4ckspell7/FlutterDecks'),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text(
                  'github.com/Bl4ckspell7/FlutterDecks',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

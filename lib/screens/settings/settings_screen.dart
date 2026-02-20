import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_localization/language/language_bloc.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return ListView(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.language),
                  subtitle: Text(_getLanguageName(state.locale.languageCode)),
                  leading: const Icon(Icons.language),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showLanguageDialog(context, state.locale),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, Locale currentLocale) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.english),
                trailing: currentLocale.languageCode == 'en' 
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(LanguageChanged(const Locale('en')));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.hindi),
                trailing: currentLocale.languageCode == 'hi' 
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(LanguageChanged(const Locale('hi')));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      default:
        return languageCode;
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static const _strings = <String, String>{
    'noDateMsg': "No Date Selected",
    'retry': "Retry",

    // Home screen
    'markDownNotesTitle': 'Markdown Notes',
    'activeToolTipMsg': 'Show active',
    'archivedTooTipMsg': 'Show archived',
    'pinSortToolTipMsg': 'Toggle pin sort'
  };

  // If string for "label" does not exist, will show "[LABEL]"
  static String _get(String label) =>
      _strings[label] ?? '[${label.toUpperCase()}]';

  String get noDateMsg => _get('noDateMsg');
  String get retryTitle => _get('retry');
  String get markDownNotesTitle => _get('markDownNotesTitle');
  String get activeToolTipMsg => _get('activeToolTipMsg');
  String get archiveToolTipMsg => _get('activeToolTipMsg');
  String get pinSortToolTipMsg => _get('pinSortToolTipMsg');
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture(AppLocalization());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}

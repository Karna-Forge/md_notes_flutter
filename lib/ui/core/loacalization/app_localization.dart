import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const _strings = <String, String>{
    // Common
    'noDateMsg': 'No Date Selected',
    'retry': 'Retry',

    // App / Home
    'markDownNotesTitle': 'Markdown Notes',
    'activeToolTipMsg': 'Show active',
    'archivedToolTipMsg': 'Show archived',
    'pinSortToolTipMsg': 'Toggle pin sort',
    'searchHint': 'Search notes…',
    'newNote': 'New note',
    'emptyNotesTitle': 'No notes yet',
    'emptyNotesSubtitle': 'Tap "New note" to create your first Markdown note.',

    // Editor
    'preview': 'Preview',
    'edit': 'Edit',
    'pin': 'Pin',
    'unpin': 'Unpin',
    'archive': 'Archive',
    'unarchive': 'Unarchive',
    'delete': 'Delete',
    'titleHint': 'Title',
    'contentHint': 'Write your note in Markdown…',
    'newNoteTitle': 'New note',
    'editNoteTitle': 'Edit note',
    'previewPlaceholder':
        '_Nothing to preview yet…_\n\nTry **bold**, *italic*, `code`, lists, and more.',

    // Toolbar
    'bold': 'Bold',
    'italic': 'Italic',
    'code': 'Code',
    'link': 'Link',
    'h1': 'H1',
    'h2': 'H2',
    'bulletList': '• List',
    'numberList': '1. List',
    'rule': 'Rule',
    'linkTitleDefault': 'title',

    // Misc
    'untitled': '(Untitled)',
  };

  // If string for "label" does not exist, will show "[LABEL]"
  static String _get(String label) =>
      _strings[label] ?? '[${label.toUpperCase()}]';

  // Common
  String get noDateMsg => _get('noDateMsg');
  String get retryTitle => _get('retry');

  // Home
  String get markDownNotesTitle => _get('markDownNotesTitle');
  String get activeToolTipMsg => _get('activeToolTipMsg');
  String get archiveToolTipMsg => _get('archivedToolTipMsg');
  String get pinSortToolTipMsg => _get('pinSortToolTipMsg');
  String get searchHint => _get('searchHint');
  String get newNote => _get('newNote');
  String get emptyNotesTitle => _get('emptyNotesTitle');
  String get emptyNotesSubtitle => _get('emptyNotesSubtitle');

  // Editor
  String get preview => _get('preview');
  String get edit => _get('edit');
  String get pin => _get('pin');
  String get unpin => _get('unpin');
  String get archive => _get('archive');
  String get unarchive => _get('unarchive');
  String get delete => _get('delete');
  String get titleHint => _get('titleHint');
  String get contentHint => _get('contentHint');
  String get newNoteTitle => _get('newNoteTitle');
  String get editNoteTitle => _get('editNoteTitle');
  String get previewPlaceholder => _get('previewPlaceholder');

  // Toolbar
  String get bold => _get('bold');
  String get italic => _get('italic');
  String get code => _get('code');
  String get link => _get('link');
  String get h1 => _get('h1');
  String get h2 => _get('h2');
  String get bulletList => _get('bulletList');
  String get numberList => _get('numberList');
  String get rule => _get('rule');
  String get linkTitleDefault => _get('linkTitleDefault');

  // Misc
  String get untitled => _get('untitled');
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

# Markdown Notes (Flutter)

A simple, fast, local-first notes app with Markdown editing + preview.

## Features
- 📝 Create, edit, delete notes
- ⭐ Pin / archive notes
- 🔎 Search notes by title or content
- ✍️ Markdown editor with quick toolbar and live preview
- 💾 Local JSON file storage (no backend)
- 🌓 Light/Dark theme support
- 🖥️ Desktop + Mobile friendly (responsive)

## Quick Start

> You can use this as a starter inside a new Flutter project.

```bash
# 1) Create a fresh project (choose your preferred name)
flutter create markdown_notes

# 2) Replace its lib/ and pubspec.yaml with the ones from this starter
cp -r ./lib ./markdown_notes/
cp pubspec.yaml markdown_notes/pubspec.yaml

# (Optional) If you want all platforms, inside project do:
cd markdown_notes
flutter create . --platforms=android,ios,web,macos,windows,linux

# 3) Get packages & run
flutter pub get
flutter run
```

## Project Structure
```
lib/
  main.dart
  models/note.dart
  services/storage_service.dart
  providers/notes_provider.dart
  pages/home_page.dart
  pages/editor_page.dart
  widgets/note_list_item.dart
  widgets/markdown_toolbar.dart
```

## Storage
Notes are stored as a single JSON file at `ApplicationDocumentsDirectory/notes.json`.

## License
MIT

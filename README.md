# Markdown Notes (Flutter)

Local‑first Markdown notes app with pin/archive, search, and a clean edit/preview experience. Built with Flutter, Provider, and GoRouter.

## Features
- 📝 Create, edit, delete notes
- ⭐ Pin and archive; sort by pinned first
- 🔎 Search title and content
- ✍️ Editor toolbar + live Markdown preview
- 💾 Local JSON storage (no backend)
- 🌓 Light/Dark themes
- 🧭 Type‑safe navigation via GoRouter
- ✅ Result<T> pattern for service/repo calls

## Tech Stack
- Flutter + Dart
- Provider (DI/state)
- GoRouter (navigation)
- Freezed + json_serializable (models, codegen)
- flutter_markdown (rendering)

## Architecture

Layers and directories follow a simple, testable structure:

```
lib/
  config/                 # DI wiring, global providers
  data/
    models/               # Note, NotesFilter (freezed/json)
    repositories/         # INotesRepository + implementation
    services/
      notes/              # INotesService + implementation
      storage/            # Local JSON storage abstraction
      navigation/         # INavigationService (GoRouter)
    utils/                # Result<T>, UX helpers
  routing/                # Routes, router, nav service impl
  ui/
    core/                 # base widgets, themes, localization
    edit/                 # editor screen + viewmodel
    home/                 # home screen + viewmodel
  widgets/                # app‑level reusable widgets
```

Data flow: UI (ViewModels) → Repository → Service → Storage. UI never talks to storage directly. Navigation is wrapped behind `INavigationService`.

### Result<T> pattern
All repository and service calls return `Future<Result<T>>` for consistent success/failure handling without throwing:

```dart
final res = await repo.listNotes(filter);
if (res.isSuccess) {
  final notes = res.data!;
} else {
  log(res.error);
}
```

`Result.success([T? data])` marks success (data optional for `void`), `Result.failure(String error)` carries error text.

### Navigation return values
Leaving the editor returns a `bool` via GoRouter pop to signal whether the home list should refetch. This is surfaced as `Result<bool>` from `INavigationService.gotoEditorPage`.

## Setup

```bash
flutter pub get
```

Run the app:

```bash
# Default main
flutter run

# Explicit targets
flutter run -t lib/main_development.dart
flutter run -t lib/main_staging.dart
```

Codegen (Freezed/JSON):

```bash
dart run build_runner build --delete-conflicting-outputs
# or watch during active development
dart run build_runner watch --delete-conflicting-outputs
```

Analyze and format:

```bash
flutter analyze
dart format --fix .
```

Tests:

```bash
flutter test
```

## Storage
Notes are persisted to `ApplicationDocumentsDirectory/notes.json` via `StorageService` and an `INotesStorage` implementation (`JsonNotesStorage`).

## Key Files
- `lib/data/models/note.dart` – immutable note model (freezed/json)
- `lib/data/repositories/notes_repository.dart` – domain operations
- `lib/data/services/notes/notes_service.dart` – filtering, updates, caching
- `lib/data/services/storage/storage_service.dart` – file IO
- `lib/data/utils/result.dart` – `Result<T>` wrapper
- `lib/ui/home/widgets/home_screen.dart` – list, search, actions
- `lib/ui/edit/widgets/editor_screen.dart` – editor + preview
- `lib/routing/router.dart` – GoRouter setup

## Contributing
Pull requests welcome! Please:
- Keep changes focused and add/update tests when behavior changes
- Follow Dart style (2‑space indent) and repository conventions
- Run: `flutter analyze`, `dart format --fix .`, and `flutter test`

## License
MIT

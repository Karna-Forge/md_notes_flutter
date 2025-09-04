import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/repositories/notes_repository.dart';
import 'package:markdown_notes/data/services/notes/notes_service.dart';
import 'package:markdown_notes/data/services/storage/storage_service.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '/routing/router.dart';
import '../data/services/logging/i_logging_service.dart';
import '../data/services/logging/local_logging_service.dart';

List<SingleChildWidget> _commonServices = [
  Provider(create: (context) => router()),
  Provider(
    create: (context) => StorageService(),
  ),
  Provider(
    create: (context) => NotesService(context.read()),
  )
];
List<SingleChildWidget> _commonRepositories = [
  Provider(
    create: (context) => NotesRepository(context.read()) as INotesRepository,
  )
];
List<SingleChildWidget> _commonViewmodels = [
  ChangeNotifierProvider(
    create: (context) => NotesProvider(context.read())..load(),
  )
];

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [..._commonServices, ..._commonRepositories, ..._commonViewmodels];
}

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.
List<SingleChildWidget> get providersLocal {
  return [
    ..._commonServices,
    Provider(create: (context) => LocalLoggingService() as ILoggingService),
    ..._commonRepositories,
    ..._commonViewmodels,
  ];
}

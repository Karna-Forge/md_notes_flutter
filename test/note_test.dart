import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_notes/data/models/note.dart';

void main() {
  test('Note json encode/decode', () {
    final n = Note.withDefaults(id: '1', title: 't', content: 'c');
    final raw = Note.encodeList([n]);
    final decoded = Note.decodeList(raw);
    expect(decoded.single.title, 't');
  });
}

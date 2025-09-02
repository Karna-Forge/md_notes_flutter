import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_notes/models/note.dart';

void main() {
  test('Note json encode/decode', () {
    final n = Note(id: '1', title: 't', content: 'c');
    final raw = Note.encodeList([n]);
    final decoded = Note.decodeList(raw);
    expect(decoded.single.title, 't');
  });
}

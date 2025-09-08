import 'package:flutter/material.dart';
import '../../../../data/models/note.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;
  const NoteListItem({super.key, required this.note, this.onTap});

  String _formatDate(DateTime dt) {
    // Simple date formatting without intl dependency.
    final d = dt.toLocal();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.pinned)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0, top: 2),
                  child: Icon(Icons.push_pin, size: 18),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title.isEmpty ? '(Untitled)' : note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      note.content.replaceAll('\n', '  ').trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(note.archived ? Icons.inventory_2 : Icons.note,
                            size: 14),
                        const SizedBox(width: 6),
                        Text(
                          _formatDate(note.updatedAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

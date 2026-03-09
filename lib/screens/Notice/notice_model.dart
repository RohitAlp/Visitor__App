// lib/models/notice.dart
class Notice {
  final String id;               // now optional
  final String title;
  final String date;
  final String timeAgo;
  final String description;
  // final List<String> imageUrls;  // add later if you bring images back

  Notice({
    this.id = '',                // ← changed: optional + default empty
    required this.title,
    required this.date,
    required this.timeAgo,
    required this.description,
    // this.imageUrls = const [],
  });
}
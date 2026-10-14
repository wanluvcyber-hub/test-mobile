class Todo {
  final int? id;          // nullable: ตอนสร้างใหม่ยังไม่มี id (DB สร้างให้)
  final String title;
  final bool done;

  const Todo({this.id, required this.title, this.done = false});

  // Dart -> Map สำหรับเขียนลง DB
  Map<String, Object?> toMap() => {
        if (id != null) 'id': id,        // ใส่ id เมื่อมีเท่านั้น
        'title': title,
        'done': done ? 1 : 0,            // bool -> 0/1
      };

  // Map ที่อ่านจาก DB -> Dart
  factory Todo.fromMap(Map<String, Object?> m) => Todo(
        id: m['id'] as int,
        title: m['title'] as String,
        done: (m['done'] as int) == 1,   // 0/1 -> bool
      );

  Todo copyWith({String? title, bool? done}) =>
      Todo(id: id, title: title ?? this.title, done: done ?? this.done);
}
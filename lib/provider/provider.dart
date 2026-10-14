import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../models/todo.dart';

class TodoController extends ChangeNotifier {
  final AppDatabase _db = AppDatabase.instance;

  List<Todo> _todos = [];
  bool _loading = true;

  List<Todo> get todos => List.unmodifiable(_todos);
  bool get loading => _loading;
  int get remaining => _todos.where((t) => !t.done).length;

  // อ่านทั้งหมดจาก DB แล้วแจ้งหน้าจอ
  Future<void> load() async {
    _todos = await _db.getAll();
    _loading = false;
    notifyListeners();
  }

  Future<void> add(String title) async {
    final text = title.trim();
    if (text.isEmpty) return;
    await _db.insert(Todo(title: text));
    await load();                          // เขียนแล้วโหลดใหม่
  }

  Future<void> toggle(Todo t) async {
    await _db.update(t.copyWith(done: !t.done));
    await load();
  }

  Future<void> remove(int id) async {
    await _db.delete(id);
    await load();
  }
}
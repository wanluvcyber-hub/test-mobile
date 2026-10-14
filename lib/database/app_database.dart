import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo.dart';

class AppDatabase {
  AppDatabase._();                                   // constructor private
  static final AppDatabase instance = AppDatabase._(); // ตัวเดียวทั้งแอป

  Database? _db;

  // เปิดครั้งแรกครั้งเดียว ครั้งต่อไปใช้ตัวเดิม
  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'todo.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // ทำครั้งเดียวตอนสร้างไฟล์ฐานข้อมูลใหม่
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            done INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  // Read
  Future<List<Todo>> getAll() async {
    final db = await database;
    final rows = await db.query('todos', orderBy: 'id DESC');
    return rows.map(Todo.fromMap).toList();
  }

  // Create: คืน id ของแถวที่เพิ่ม
  Future<int> insert(Todo t) async {
    final db = await database;
    return db.insert('todos', t.toMap());
  }

  // Update: คืนจำนวนแถวที่ถูกแก้
  Future<int> update(Todo t) async {
    final db = await database;
    return db.update('todos', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
  }

  // Delete: คืนจำนวนแถวที่ถูกลบ
  Future<int> delete(int id) async {
    final db = await database;
    return db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
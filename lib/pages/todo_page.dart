import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import '../widgets/add_todo_bar.dart';
import '../widgets/todo_tile.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // select: rebuild หน้านี้เฉพาะตอน remaining เปลี่ยน
    final remaining = context.select((TodoController c) => c.remaining);

    return Scaffold(
      appBar: AppBar(title: Text('งานที่เหลือ $remaining ชิ้น')),
      body: const Column(
        children: [
          AddTodoBar(),
          Expanded(child: _TodoList()),
        ],
      ),
    );
  }
}

// แยกส่วนที่เปลี่ยนบ่อยออกมาเป็น widget ของตัวเอง
class _TodoList extends StatelessWidget {
  const _TodoList();

  @override
    Widget build(BuildContext context) {
    final c = context.watch<TodoController>();

    if (c.loading) {
      return const Center(child: CircularProgressIndicator());   // เพิ่ม: สถานะกำลังโหลดจาก DB
    }
    if (c.todos.isEmpty) {
      return const Center(child: Text('ยังไม่มีงาน เพิ่มสักอันสิ'));
    }
    return ListView.builder(
      itemCount: c.todos.length,
      itemBuilder: (_, i) => TodoTile(todo: c.todos[i]),
    );
  }
}
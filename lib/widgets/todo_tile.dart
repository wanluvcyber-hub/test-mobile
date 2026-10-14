import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import '../models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TodoController>();

return Dismissible(
  key: ValueKey(todo.id),                           // id ตอนนี้เป็น int? ใช้เป็น key ได้เหมือนเดิม
  background: Container(color: Colors.red.shade200),
  onDismissed: (_) => controller.remove(todo.id!),  // ! คือยืนยันว่าแถวจาก DB มี id เสมอ
  child: CheckboxListTile(
    value: todo.done,
    onChanged: (_) => controller.toggle(todo),      // ส่งทั้ง Todo ไม่ใช่แค่ id
    title: Text(
      todo.title,
      style: TextStyle(decoration: todo.done ? TextDecoration.lineThrough : null),
    ),
  ),
);
  }
}
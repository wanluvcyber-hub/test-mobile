import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

// ต้องเป็น StatefulWidget เพราะมี TextEditingController ที่ต้องมี dispose
class AddTodoBar extends StatefulWidget {
  const AddTodoBar({super.key});

  @override
  State<AddTodoBar> createState() => _AddTodoBarState();
}

class _AddTodoBarState extends State<AddTodoBar> {
  final _input = TextEditingController();   // Controller ของ Flutter (คนละตัวกับของเรา)

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _submit() {
    // read: สั่งงานครั้งเดียว ไม่ต้องฟังการเปลี่ยนแปลง
    context.read<TodoController>().add(_input.text);
    _input.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _input,
              onSubmitted: (_) => _submit(),      // กด Enter บนคีย์บอร์ดก็เพิ่มได้
              decoration: const InputDecoration(
                hintText: 'เพิ่มงานใหม่...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilledButton(onPressed: _submit, child: const Text('เพิ่ม')),
        ],
      ),
    );
  }
}
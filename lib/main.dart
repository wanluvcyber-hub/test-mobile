import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/provider.dart';
import 'pages/todo_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoController()..load(),   // เปิดแอปมาก็โหลดจาก DB ทันที
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo SQLite',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const TodoPage(),
    );
  }
}
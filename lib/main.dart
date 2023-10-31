import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Taskk/todo_view.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initializeDatabase();
  runApp(MaterialApp(
    home: TodoApp(),
  ));
}


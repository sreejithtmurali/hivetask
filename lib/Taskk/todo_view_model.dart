import 'package:stacked/stacked.dart';
import 'package:hivetask/database_helper.dart';


import '../database_helper.dart';
import '../model/task_model.dart';

class TodoViewModel extends BaseViewModel {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Task> tasks = [];

  Future<void> loadTasks() async {
    setBusy(true);
    tasks = await _databaseHelper.getTasks();
    setBusy(false);
  }

  Future<void> addTask(Task task) async {
    await _databaseHelper.insertTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _databaseHelper.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _databaseHelper.deleteTask(id);
    loadTasks();
  }
}

import 'package:flutter/material.dart';
import 'package:hivetask/Taskk/todo_view_model.dart';
import 'package:stacked/stacked.dart';

import '../model/task_model.dart';


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onViewModelReady: (model) => model.loadTasks(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('TODO App'),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: model.tasks.length,
          itemBuilder: (context, index) {
            final task = model.tasks[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onLongPress:(){ model.deleteTask(task.id!);} ,
                child: Container(
                    height:100,child: Card(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                          left: 10,
                          child: Text('${task.id}',style: TextStyle(fontWeight: FontWeight.bold),)),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: Container(
                            width: 10,
                            color: Colors.black12,
                            height: 1,
                          )),
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Text('${task.title}',)),
                      Positioned(
                          top: 50,
                          left: 20,
                          child: Text('${task.description}',)),
                      Positioned(
                        top: 0,
                        right: 20,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${task.isCompleted?"Completed":"pending"}",style: TextStyle(color: task.isCompleted?Colors.green:Colors.red),),
                            Checkbox(

                            value: task.isCompleted,
                            onChanged: (value) {
                              task.isCompleted = value!;
                              model.updateTask(task);
                            },
                                              ),
                          ],
                        ),)
                    ],
                  ),
                )),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            _showTaskDialog(context, model);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _showTaskDialog(BuildContext context, TodoViewModel model) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final task = Task(
                title: titleController.text,
                description: descriptionController.text,
              );
              model.addTask(task);
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}


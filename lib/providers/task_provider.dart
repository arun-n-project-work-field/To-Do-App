import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTasks = prefs.getString('tasks');
    if (storedTasks != null) {
      List<dynamic> jsonTasks = json.decode(storedTasks);
      _tasks = jsonTasks.map((taskJson) => Task.fromJson(taskJson)).toList();
      notifyListeners();
    }
  }

  void addTask(String title) {
    if (title.isEmpty) return;
    _tasks.add(Task(title: title));
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonTasks = json.encode(_tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', jsonTasks);
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_notifier.dart';
import '../widgets/task_tile.dart';
import '../animations/scale_transition.dart';
import 'posts_screen.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final TextEditingController taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                ScaleTransitionPageRoute(child: PostsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(themeNotifier.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Add a new task',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    taskProvider.addTask(taskController.text);
                    taskController.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: taskProvider.tasks[index],
                  onToggle: () => taskProvider.toggleTaskCompletion(index),
                  onDelete: () => taskProvider.deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
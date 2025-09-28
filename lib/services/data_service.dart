import 'dart:math';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/category.dart';

class DataService {
  DataService._private();
  static final DataService instance = DataService._private();

  final ValueNotifier<List<Task>> tasks = ValueNotifier<List<Task>>([]);
  final ValueNotifier<List<Category>> categories = ValueNotifier<List<Category>>([]);

  String _newId([String prefix = 'id']) => '${prefix}_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';

  void initSampleData() {
    if (categories.value.isEmpty) {
      categories.value = [
        Category(id: _newId('cat'), name: 'Pessoal', icon: 'person', colorValue: Colors.indigo.value),
        Category(id: _newId('cat'), name: 'Trabalho', icon: 'work', colorValue: Colors.teal.value),
        Category(id: _newId('cat'), name: 'Estudo', icon: 'school', colorValue: Colors.orange.value),
      ];
    }
    if (tasks.value.isEmpty) {
      tasks.value = [
        Task(id: _newId('t'), title: 'Comprar mantimentos', description: 'Leite, pão e ovos', dateTime: DateTime.now().add(Duration(hours: 3)), priority: 2, categoryId: categories.value.first.id),
        Task(id: _newId('t'), title: 'Reunião com time', description: 'Planejamento semana', dateTime: DateTime.now().add(Duration(days: 1, hours: 2)), priority: 3, categoryId: categories.value[1].id),
        Task(id: _newId('t'), title: 'Estudar Flutter', description: 'Praticar layouts e state management', dateTime: DateTime.now().add(Duration(days: 2)), priority: 1, categoryId: categories.value[2].id),
      ];
    }
  }

  // Tasks
  void addTask(Task t) {
    tasks.value = [t, ...tasks.value];
  }

  void updateTask(Task updated) {
    final list = tasks.value.map((t) => t.id == updated.id ? updated : t).toList();
    tasks.value = list;
  }

  void removeTask(String id) {
    tasks.value = tasks.value.where((t) => t.id != id).toList();
  }

  // Subtasks
  void addSubtask(String taskId, Subtask s) {
    final list = tasks.value.map((t) {
      if (t.id == taskId) {
        final subs = [...t.subtasks, s];
        return Task(id: t.id, title: t.title, description: t.description, dateTime: t.dateTime, priority: t.priority, categoryId: t.categoryId, subtasks: subs);
      }
      return t;
    }).toList();
    tasks.value = list;
  }

  void toggleSubtask(String taskId, String subtaskId) {
    final list = tasks.value.map((t) {
      if (t.id == taskId) {
        final subs = t.subtasks.map((s) => s.id == subtaskId ? Subtask(id: s.id, title: s.title, done: !s.done) : s).toList();
        return Task(id: t.id, title: t.title, description: t.description, dateTime: t.dateTime, priority: t.priority, categoryId: t.categoryId, subtasks: subs);
      }
      return t;
    }).toList();
    tasks.value = list;
  }

  void removeSubtask(String taskId, String subtaskId) {
    final list = tasks.value.map((t) {
      if (t.id == taskId) {
        final subs = t.subtasks.where((s) => s.id != subtaskId).toList();
        return Task(id: t.id, title: t.title, description: t.description, dateTime: t.dateTime, priority: t.priority, categoryId: t.categoryId, subtasks: subs);
      }
      return t;
    }).toList();
    tasks.value = list;
  }

  // Categories
  void addCategory(Category c) {
    categories.value = [c, ...categories.value];
  }

  void updateCategory(Category updated) {
    final list = categories.value.map((c) => c.id == updated.id ? updated : c).toList();
    categories.value = list;
  }

  void removeCategory(String id) {
    categories.value = categories.value.where((c) => c.id != id).toList();
    // detach from tasks
    final tlist = tasks.value.map((t) => t.categoryId == id ? Task(id: t.id, title: t.title, description: t.description, dateTime: t.dateTime, priority: t.priority, categoryId: null, subtasks: t.subtasks) : t).toList();
    tasks.value = tlist;
  }
}

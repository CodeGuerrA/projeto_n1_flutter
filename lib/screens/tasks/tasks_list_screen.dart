import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import '../../services/data_service.dart';
import '../../models/task.dart';
import '../../models/category.dart';
import '../../ui/icon_map.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final ds = DataService.instance;

  String _priorityLabel(int p) {
    switch (p) {
      case 1:
        return 'Baixa';
      case 2:
        return 'Média';
      case 3:
        return 'Alta';
      default:
        return 'Média';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Sair',
            onPressed: () async {
              await AuthService.instance.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (r) => false,
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Task>>(
        valueListenable: ds.tasks,
        builder: (_, list, __) {
          if (list.isEmpty) {
            return Center(child: Text('Sem tarefas. Toque em + para criar.'));
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final t = list[i];
              final cat = ds.categories.value.firstWhere(
                (c) => c.id == t.categoryId,
                orElse: () => Category(
                  id: '',
                  name: '',
                  icon: 'note',
                  colorValue: Colors.grey.value,
                ),
              );
              return Card(
                child: ListTile(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.subtasks,
                    arguments: t.id,
                  ),
                  title: Text(t.title),
                  subtitle: Text(
                    t.description.isNotEmpty ? t.description : 'Sem descrição',
                  ),
                  trailing: Wrap(
                    spacing: 6,
                    children: [
                      if (t.dateTime != null)
                        Chip(
                          label: Text(
                            '${t.dateTime!.day}/${t.dateTime!.month}',
                          ),
                        ),
                      Chip(label: Text(_priorityLabel(t.priority))),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.taskForm,
                          arguments: t.id,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _confirmDelete(t),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(cat.colorValue),
                    child: Icon(
                      iconMap[cat.icon] ?? Icons.note,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.taskForm),
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(Task t) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir tarefa?'),
        content: Text('Deseja remover "${t.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              DataService.instance.removeTask(t.id);
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

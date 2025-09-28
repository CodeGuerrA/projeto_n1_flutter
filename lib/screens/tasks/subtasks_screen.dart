import 'package:flutter/material.dart';
import '../../services/data_service.dart';
import '../../models/task.dart';

class SubtasksScreen extends StatefulWidget {
  @override
  _SubtasksScreenState createState() => _SubtasksScreenState();
}

class _SubtasksScreenState extends State<SubtasksScreen> {
  final ds = DataService.instance;
  String? taskId;
  Task? task;
  final _ctrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      taskId = arg;
      task = ds.tasks.value.firstWhere((t)=>t.id==arg, orElse: () => Task(id: '', title: '', description: ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (taskId == null) return Scaffold(body: Center(child: Text('Tarefa não encontrada')));
    return Scaffold(
      appBar: AppBar(title: Text('Subtarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<Task>>(
                valueListenable: ds.tasks,
                builder: (_, list, __) {
                  final t = list.firstWhere((x)=>x.id==taskId, orElse: ()=>Task(id: '', title: '', description: ''));
                  if (t.id.isEmpty) return Center(child: Text('Tarefa não encontrada'));
                  return ListView.builder(itemCount: t.subtasks.length, itemBuilder: (_, i) {
                    final s = t.subtasks[i];
                    return CheckboxListTile(
                      value: s.done,
                      onChanged: (_){ ds.toggleSubtask(taskId!, s.id); },
                      title: Text(s.title),
                      secondary: IconButton(icon: Icon(Icons.delete), onPressed: ()=>ds.removeSubtask(taskId!, s.id)),
                    );
                  });
                },
              ),
            ),
            Row(children: [
              Expanded(child: TextField(controller: _ctrl, decoration: InputDecoration(hintText: 'Nova subtarefa'))),
              SizedBox(width: 8),
              ElevatedButton(onPressed: () {
                final text = _ctrl.text.trim();
                if (text.isEmpty) return;
                final s = Subtask(id: 's_${DateTime.now().millisecondsSinceEpoch}', title: text);
                ds.addSubtask(taskId!, s);
                _ctrl.clear();
              }, child: Text('Adicionar')),
            ])
          ],
        ),
      ),
    );
  }
}

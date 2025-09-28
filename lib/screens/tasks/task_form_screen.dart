import 'package:flutter/material.dart';
import '../../services/data_service.dart';
import '../../models/task.dart';
import '../../models/category.dart';
import '../../ui/icon_map.dart';

class TaskFormScreen extends StatefulWidget {
  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ds = DataService.instance;

  String? id;
  String title = '';
  String description = '';
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  int priority = 2;
  String? categoryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      final t = ds.tasks.value.firstWhere((e) => e.id == arg, orElse: () => Task(id: '', title: '', description: ''));
      if (t.id.isNotEmpty) {
        id = t.id;
        title = t.title;
        description = t.description;
        dateTime = t.dateTime;
        if (dateTime != null) timeOfDay = TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute);
        priority = t.priority;
        categoryId = t.categoryId;
      }
    }
  }

  void _pickDate() async {
    final d = await showDatePicker(context: context, initialDate: dateTime ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (d != null) setState(()=>dateTime = d);
  }

  void _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: timeOfDay ?? TimeOfDay.now());
    if (t != null) setState(()=>timeOfDay = t);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    DateTime? finalDt;
    if (dateTime != null) {
      if (timeOfDay != null) {
        finalDt = DateTime(dateTime!.year, dateTime!.month, dateTime!.day, timeOfDay!.hour, timeOfDay!.minute);
      } else {
        finalDt = DateTime(dateTime!.year, dateTime!.month, dateTime!.day);
      }
    }
    if (id == null) {
      final t = Task(id: 't_${DateTime.now().millisecondsSinceEpoch}', title: title.trim(), description: description.trim(), dateTime: finalDt, priority: priority, categoryId: categoryId);
      ds.addTask(t);
    } else {
      final existing = ds.tasks.value.firstWhere((x)=>x.id==id!, orElse: () => Task(id: '', title: '', description: ''));
      final t = Task(id: id!, title: title.trim(), description: description.trim(), dateTime: finalDt, priority: priority, categoryId: categoryId, subtasks: existing.subtasks);
      ds.updateTask(t);
    }
    Navigator.pop(context);
  }

  String _dateLabel() {
    if (dateTime == null) return 'Sem data';
    final d = dateTime!;
    final day = d.day.toString().padLeft(2,'0');
    final month = d.month.toString().padLeft(2,'0');
    final year = d.year;
    return '$day/$month/$year';
  }

  String _timeLabel() {
    if (timeOfDay == null) return 'Sem hora';
    final h = timeOfDay!.hour.toString().padLeft(2,'0');
    final m = timeOfDay!.minute.toString().padLeft(2,'0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id==null ? 'Nova tarefa' : 'Editar tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(initialValue: title, decoration: InputDecoration(labelText: 'Título'), onChanged: (v)=>title=v, validator: (v)=> (v==null||v.trim().isEmpty)?'Informe título':null),
              SizedBox(height: 12),
              TextFormField(initialValue: description, decoration: InputDecoration(labelText: 'Descrição'), minLines: 2, maxLines: 4, onChanged: (v)=>description=v),
              SizedBox(height: 12),
              Row(children: [
                Expanded(child: Text('Data: ${_dateLabel()}')),
                TextButton(onPressed: _pickDate, child: Text('Escolher data')),
              ]),
              SizedBox(height: 8),
              Row(children: [
                Expanded(child: Text('Hora: ${_timeLabel()}')),
                TextButton(onPressed: _pickTime, child: Text('Escolher hora')),
              ]),
              SizedBox(height: 12),
              DropdownButtonFormField<int>(value: priority, decoration: InputDecoration(labelText: 'Prioridade'), items: [1,2,3].map((p)=>DropdownMenuItem(value:p, child: Text(p==1?'Baixa':p==2?'Média':'Alta'))).toList(), onChanged: (v)=>setState(()=>priority=v!)),
              SizedBox(height: 12),
              DropdownButtonFormField<String?>(value: categoryId, decoration: InputDecoration(labelText: 'Categoria'), items: [null, ...ds.categories.value].map((c) {
                if (c==null) return DropdownMenuItem<String?>(value: null, child: Text('Sem categoria'));
                return DropdownMenuItem<String?>(value: c.id, child: Row(children: [Icon(iconMap[c.icon] ?? Icons.note), SizedBox(width:8), Text(c.name)]));
              }).toList(), onChanged: (v)=>setState(()=>categoryId=v)),
              SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: Text('Salvar'))),
            ],
          ),
        ),
      ),
    );
  }
}

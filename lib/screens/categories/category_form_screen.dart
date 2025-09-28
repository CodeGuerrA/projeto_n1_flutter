import 'package:flutter/material.dart';
import '../../services/data_service.dart';
import '../../models/category.dart';
import '../../ui/icon_map.dart';

class CategoryFormScreen extends StatefulWidget {
  @override
  _CategoryFormScreenState createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ds = DataService.instance;

  String? id;
  String name = '';
  String iconName = 'note';
  int colorValue = Colors.indigo.value;

  final icons = iconMap.keys.toList();
  final colors = [Colors.indigo, Colors.teal, Colors.orange, Colors.pink, Colors.green, Colors.blueGrey];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      final c = ds.categories.value.firstWhere((x)=>x.id==arg, orElse: ()=>Category(id: '', name: '', icon: 'note', colorValue: Colors.grey.value));
      if (c.id.isNotEmpty) {
        id = c.id;
        name = c.name;
        iconName = c.icon;
        colorValue = c.colorValue;
      }
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (id == null) {
      final c = Category(id: 'cat_${DateTime.now().millisecondsSinceEpoch}', name: name.trim(), icon: iconName, colorValue: colorValue);
      ds.addCategory(c);
    } else {
      final c = Category(id: id!, name: name.trim(), icon: iconName, colorValue: colorValue);
      ds.updateCategory(c);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id==null ? 'Nova categoria' : 'Editar categoria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(initialValue: name, decoration: InputDecoration(labelText: 'Nome'), onChanged: (v)=>name=v, validator: (v)=> (v==null||v.trim().isEmpty)?'Informe nome':null),
              SizedBox(height: 12),
              Text('Ícone', style: TextStyle(fontWeight: FontWeight.w600)),
              Wrap(children: icons.map((k) => GestureDetector(
                onTap: ()=>setState(()=>iconName=k),
                child: Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: iconName==k?Theme.of(context).primaryColor:Colors.grey[100]),
                  child: Icon(iconMap[k] ?? Icons.note, color: iconName==k?Colors.white:Colors.black87),
                ),
              )).toList()),
              SizedBox(height: 12),
              Text('Cor', style: TextStyle(fontWeight: FontWeight.w600)),
              Wrap(children: colors.map((c) => GestureDetector(
                onTap: ()=>setState(()=>colorValue = c.value),
                child: Container(
                  margin: EdgeInsets.all(6),
                  width: 44, height:44, decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
                  child: colorValue==c.value? Icon(Icons.check,color: Colors.white):null,
                ),
              )).toList()),
              SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: Text('Salvar'))),
            ],
          ),
        ),
      ),
    );
  }
}

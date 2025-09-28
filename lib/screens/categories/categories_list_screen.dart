import 'package:flutter/material.dart';
import '../../services/data_service.dart';
import '../../models/category.dart';
import '../../ui/icon_map.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';

class CategoriesListScreen extends StatefulWidget {
  @override
  _CategoriesListScreenState createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  final ds = DataService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
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
      body: ValueListenableBuilder<List<Category>>(
        valueListenable: ds.categories,
        builder: (_, list, __) {
          if (list.isEmpty) {
            return Center(child: Text('Nenhuma categoria.'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final c = list[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(c.colorValue),
                  child: Icon(
                    iconMap[c.icon] ?? Icons.note,
                    color: Colors.white,
                  ),
                ),
                title: Text(c.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.categoryForm,
                        arguments: c.id,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _confirmDelete(c),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.categoryForm),
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(Category c) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir categoria?'),
        content: Text('Remover "${c.name}" e desvincular tarefas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ds.removeCategory(c.id);
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

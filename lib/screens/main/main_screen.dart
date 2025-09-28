import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import '../tasks/tasks_list_screen.dart';
import '../categories/categories_list_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  // Lista de páginas
  List<Widget> get _pages => [TasksListScreen(), CategoriesListScreen()];

  // Ação do FAB
  void _onFab() {
    if (_index == 0) {
      Navigator.pushNamed(context, Routes.taskForm);
    } else if (_index == 1) {
      Navigator.pushNamed(context, Routes.categoryForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_index != 0) {
          setState(() => _index = 0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(index: _index, children: _pages),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFab,
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tarefas'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categorias',
            ),
          ],
        ),
      ),
    );
  }
}

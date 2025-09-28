import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../services/app_prefs.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _ctrl = PageController();
  int _page = 0;

  void _next() {
    if (_page < 2) _ctrl.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    else _finish();
  }

  void _prev() {
    if (_page > 0) _ctrl.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _skip() async {
    await AppPrefs.setOnboardingSkipped(true);
    Navigator.pushNamed(context, Routes.login);
  }

  void _finish() async {
    await AppPrefs.setOnboardingSkipped(true);
    Navigator.pushNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _page > 0 ? IconButton(icon: Icon(Icons.arrow_back), onPressed: _prev) : null,
        actions: [
          TextButton(onPressed: _skip, child: Text('Pular')),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _ctrl,
              onPageChanged: (v) => setState(() => _page = v),
              children: [
                _buildPage(Icons.task, 'Gerencie tarefas', 'Crie, edite e organize suas tarefas facilmente.'),
                _buildPage(Icons.repeat, 'Rotinas', 'Automatize suas rotinas diárias com facilidade.'),
                _buildPage(Icons.category, 'Categorias', 'Organize tarefas por categorias e cores.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Row(
                  children: List.generate(3, (i) => AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _page == i ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _page == i ? Theme.of(context).primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
                ),
                Spacer(),
                ElevatedButton(onPressed: _next, child: Text(_page < 2 ? 'Avançar' : 'Começar')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(IconData icon, String title, String subtitle) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 96, color: Theme.of(context).primaryColor),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.black87)),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    await Future.delayed(Duration(milliseconds: 400));
    final ok = await AuthService.instance.login(username.trim(), password);
    setState(() => loading = false);
    if (ok) {
      Navigator.pushNamed(context, Routes.tasks);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login falhou: usuário/senha inválidos')));
    }
  }

  void _useAlt() async {
    // dialog to use alternative password
    final data = await showDialog<Map<String,String>>(context: context, builder: (_) {
      String user='';
      String alt='';
      return AlertDialog(
        title: Text('Entrar com senha alternativa'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(decoration: InputDecoration(labelText: 'Usuário'), onChanged: (v)=>user=v),
          TextField(decoration: InputDecoration(labelText: 'Senha alternativa'), obscureText: true, onChanged: (v)=>alt=v),
        ]),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, {'user': user, 'alt': alt}), child: Text('Entrar')),
        ],
      );
    });
    if (data == null) return;
    setState(() => loading = true);
    final ok = await AuthService.instance.loginWithAlt(data['user']?.trim() ?? '', data['alt'] ?? '');
    setState(() => loading = false);
    if (ok) Navigator.pushNamed(context, Routes.tasks);
    else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha: senha alternativa inválida')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Usuário ou email', prefixIcon: Icon(Icons.person)),
                    onChanged: (v) => username = v,
                    validator: (v) => (v==null || v.trim().length < 2) ? 'Informe usuário' : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    onChanged: (v) => password = v,
                    validator: (v) => (v==null || v.trim().length < 3) ? 'Senha muito curta' : null,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loading ? null : _submit,
                      child: loading ? SizedBox(height: 18,width:18,child: CircularProgressIndicator(strokeWidth:2, color: Colors.white)) : Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () => Navigator.pushNamed(context, Routes.register), child: Text('Criar conta')),
                      SizedBox(width: 8),
                      TextButton(onPressed: () => Navigator.pushNamed(context, Routes.recovery), child: Text('Recuperar acesso')),
                      SizedBox(width: 8),
                      TextButton(onPressed: _useAlt, child: Text('Usar senha alternativa')),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

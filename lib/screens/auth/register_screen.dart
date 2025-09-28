import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String confirm = '';
  bool loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (password != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Senhas não conferem')));
      return;
    }
    setState(() => loading = true);
    await Future.delayed(Duration(milliseconds: 300));
    final ok = await AuthService.instance.register(username.trim(), password);
    setState(() => loading = false);
    if (!ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Usuário já existe')));
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Conta criada (simulada)')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuário'),
                onChanged: (v) => username = v,
                validator: (v) => (v == null || v.trim().length < 3)
                    ? 'Informe usuário'
                    : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (v) => password = v,
                validator: (v) =>
                    (v == null || v.trim().length < 3) ? 'Senha curta' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirmar senha'),
                obscureText: true,
                onChanged: (v) => confirm = v,
                validator: (v) => (v == null || v.trim().length < 3)
                    ? 'Informe confirmação'
                    : null,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : _submit,
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

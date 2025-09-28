import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RecoveryScreen extends StatefulWidget {
  @override
  _RecoveryScreenState createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  String altPassword = '';
  String username = '';
  bool saved = false;

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    await AuthService.instance.setAltPassword(username.trim(), altPassword);
    setState(()=>saved=true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Senha alternativa salva (simulada)')));
    Future.delayed(Duration(milliseconds: 600), ()=>Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar acesso')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Caso a biometria falhe, você pode cadastrar uma senha alternativa.'),
              SizedBox(height: 12),
              TextFormField(decoration: InputDecoration(labelText: 'Usuário'), onChanged: (v)=>username=v, validator: (v)=> (v==null||v.trim().isEmpty)?'Informe usuário':null),
              SizedBox(height: 12),
              TextFormField(decoration: InputDecoration(labelText: 'Senha alternativa'), obscureText: true, onChanged: (v)=>altPassword=v, validator: (v)=> (v==null||v.trim().length<3)?'Senha curta':null),
              SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: Text('Salvar'))),
            ],
          ),
        ),
      ),
    );
  }
}

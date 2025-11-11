import 'dart:async';
import 'package:proyectoflutter6/DatabaseHelper.dart';
import 'package:flutter/material.dart';

// Formulario

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    try {
      final value = await DatabaseHelper.instance.getUsers();
      setState(() {
        _users = value.map<User>((e) => User.fromMap(e)).toList();
      });
    } catch (e) {
      print("ERROR$e");
    }
  }

  Future<void> _addUser() async {
    try {
    if(_formKey.currentState!.validate()){
     final newUser = User(name: _nameCtrl.text, email: _emailCtrl.text);
     await DatabaseHelper.instance.insertUser(newUser);
     _nameCtrl.clear();
     _emailCtrl.clear();
  
     // Recargar usuarios desde la DB
     final updatedList = await DatabaseHelper.instance.getUsers();
     setState(() {
       _users = updatedList.map<User>((e) => User.fromMap(e)).toList();
       }); 
     }
   } on Exception catch (e) {
       print("ERROR$e");
     }
  }

  final _decorationForm1 = const InputDecoration(
    label: Text("Nombre"),
    border: OutlineInputBorder(),
  );
   final _decorationForm2 = const InputDecoration(
    label: Text("Correo electrónico"),
    border: OutlineInputBorder(),
  );

  final _spacerV1 = const SizedBox(
    height: 12,
  );

  final _styleBTN = ElevatedButton.styleFrom(
    backgroundColor: Colors.tealAccent,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
        ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de usuarios"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: _decorationForm1,
                    validator:(value) => 
                    value!.isEmpty ? "Ingresa el nombre" : null,
                  ),
                  _spacerV1,
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: _decorationForm2,
                    validator: (value) => 
                    value!.isEmpty ? "Ingresa el email" : null,
                  ),
                  _spacerV1,
                  ElevatedButton.icon(
                    onPressed: _addUser, 
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar'),
                    style: _styleBTN,
                  ),
                ],
              ),
            ),
            _spacerV1,
            const Divider(),
            const Text("Usuarios registrados:",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index){
                  final user = _users[index];
                  return ListTile(
                    leading: const Icon (Icons.person, color: Colors.teal),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
             ),
            ),
          ],
        ),
      ),
    );
  }
}

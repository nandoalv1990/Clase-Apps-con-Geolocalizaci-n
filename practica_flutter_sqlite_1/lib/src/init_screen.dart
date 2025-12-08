import 'package:flutter/material.dart';
import '../data/user_dao.dart';
import '../models/user.dart';
import '../utils/security.dart';

class InitScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const InitScreen({super.key, required this.onToggleTheme});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final dao = UserDao();

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  Future<void> cargarUsuarios() async {
    final listaUsuarios = await dao.getUsers();
    setState(() => users = listaUsuarios);
  }

  Future<void> registrar() async {
    if (usernameCtrl.text.isEmpty || passwordCtrl.text.isEmpty) return;
    final hashed = Security.hashPassword(passwordCtrl.text);
    final user = User(
      username: usernameCtrl.text, 
      password: hashed,
      roleId: 2,
    );
    await dao.insertUser(user);
    usernameCtrl.clear();
    passwordCtrl.clear();
    cargarUsuarios();
  }

  Future<void> eliminar(int id) async{
    await dao.deleteUser(id);
    cargarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página principal"),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme, 
            icon: Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: "Usuario",
              ),
            ),  
            TextField(
              controller: passwordCtrl,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: "Contraseña",
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: registrar, 
              child: Text("Registrar"),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, i){
                  return ListTile(
                    title: Text(users[i].username),
                    subtitle: Text("ID: ${users[i].id}"),
                    trailing: IconButton(
                      onPressed: () => eliminar(users[i].id!), 
                      icon: Icon(Icons.delete),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
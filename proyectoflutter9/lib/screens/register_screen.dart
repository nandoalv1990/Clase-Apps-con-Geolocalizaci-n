import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  String _parseError(Object e){
    final err = e.toString();
    if (err.contains('email-already-in-use')){
      return 'El correo está en uso';
    } else if (err.contains('weak-password')){
      return 'La contraseña es muy debil ()';
    }else if (err.contains('invalid-email')){
      return 'Formato de correo inválido';
    }
    return 'Error al crear el usuario';
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _register() async{
    if (!_formkey.currentState!.validate()) return;
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (password != confirm) {
      Navigator.pop(context);
      return;
    }
    setState(() => _isLoading = true);

    try {
      await _authService.register(email, password);
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      _showMessage(_parseError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose(){
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar'),),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Form(key: _formkey,child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty)? 'Ingrese un correo electrónico' : null,
              ),
              const SizedBox(height: 12.0,),

              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if(v == null || v.isEmpty) return 'Ingrese una contraseña';
                  if (v.length < 8) return 'Minimo 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 12.0,),

              TextFormField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty)? 'Confirme la constraseña' : null,
              ),
              const SizedBox(height: 20.0,),

              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: _isLoading? 
                const Center(
                  child: CircularProgressIndicator(),
                ) : ElevatedButton(
                  onPressed: _register, 
                  child: const Text('Registrarse')
                ),
              ),
              const SizedBox(height: 12,),

              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('Iniciar sesión'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
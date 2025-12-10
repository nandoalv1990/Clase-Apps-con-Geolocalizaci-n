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
      Navigator.pop(context,' = $e' as BuildContext);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
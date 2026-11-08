import 'package:flutter/material.dart';
import 'package:flutter_dart/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
  }

  Widget _showInput(
    TextEditingController namaController,
    String placeholder,
    bool isPassword,
  ) {
    return TextField(
      controller: namaController,
      obscureText: isPassword,
      decoration: InputDecoration(hintText: placeholder),
    );
  }

  Future<void> _showDialog(String pesan, [Widget? alamat]) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              onPressed: () {
                if (alamat == null) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => alamat),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showInput(
              _usernameController,
              'Masukkan Username',
              false,
            ),
            _showInput(
              _passwordController,
              'Masukkan Password',
              true,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text == 'admin' &&
                    _passwordController.text == 'admin') {
                  await _saveUsername();
                  if (!context.mounted) return;
                  await _showDialog('Anda Berhasil Login', const HomePage());
                } else {
                  await _showDialog('Username dan Password Salah');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

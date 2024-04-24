import 'package:flutter/material.dart';
import 'package:pokedex/components/ui/form/auth_form.dart';
import 'package:pokedex/components/ui/form/text_input.dart';
import 'package:pokedex/components/ui/link.dart';
import 'package:pokedex/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController.init(context);
  }

  void handleSubmit() async {
    final nickname = _nicknameController.text;
    final password = _passwordController.text;

    await _authController.login(nickname, password);
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Faça seu Login',
      buttonText: 'Entrar',
      submit: handleSubmit,
      fields: [
        TextInput(
          labelText: 'Nickname',
          controller: _nicknameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o nickname';
            }

            final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
            if (!regex.hasMatch(value)) {
              return 'O nickname deve conter apenas letras';
            }

            return null;
          },
        ),
        const SizedBox(height: 20),
        TextInput(
          labelText: 'Senha',
          controller: _passwordController,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira sua senha';
            }

            if (value.length < 6) {
              return 'A senha deve ter pelo menos 6 caracteres';
            }

            return null;
          },
        )
      ],
      footer: const [
        Link(
            description: 'Não tem uma conta?',
            route: '/register',
            text: 'Clique aqui e cadastre-se')
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex/components/ui/form/auth_form.dart';
import 'package:pokedex/components/ui/form/text_input.dart';
import 'package:pokedex/components/ui/link.dart';
import 'package:pokedex/controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController.init(context);
  }

  void handleSubmit() async {
    final nickname = _nicknameController.text;
    final password = _passwordController.text;

    await _authController.register(nickname, password);
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Crie sua conta',
      buttonText: 'Cadastrar',
      submit: handleSubmit,
      fields: [
        TextInput(
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
          labelText: 'Nickname',
        ),
        const SizedBox(height: 20),
        TextInput(
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
          labelText: 'Senha',
        )
      ],
      footer: const [
        Link(
            description: 'Ja possui uma conta?',
            text: 'Realizar Login',
            route: '/login')
      ],
    );
  }
}

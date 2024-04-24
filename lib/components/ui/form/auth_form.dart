import 'package:flutter/material.dart';
import 'package:pokedex/components/layout/background_layout.dart';
import 'package:pokedex/components/layout/logo.dart';
import 'package:pokedex/components/ui/button.dart';
import 'package:pokedex/stores/app_store.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String title;
  final List<Widget> fields;
  final String buttonText;
  final VoidCallback submit;
  final List<Widget>? footer;

  AuthForm(
      {super.key,
      required this.title,
      required this.fields,
      required this.buttonText,
      required this.submit,
      this.footer});

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      submit();
    }
  }

  Widget _body(BuildContext context) {
    final AppStore appStore = Provider.of<AppStore>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              const SizedBox(height: 20),
              Text(title,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Card(
                color: const Color.fromARGB(255, 27, 27, 27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white, width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ...fields,
                        const SizedBox(height: 23),
                        Button(text: buttonText, onPressed: handleSubmit),
                        if (appStore.errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              appStore.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        if (footer != null) ...footer!,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLayout(
        body: _body(context),
      ),
    );
  }
}

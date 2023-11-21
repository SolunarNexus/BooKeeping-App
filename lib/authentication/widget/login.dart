import 'package:book_keeping/authentication/widget/register.dart';
import 'package:book_keeping/authentication/widget/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    final validator = Validator(validators: [
                      const RequiredValidator(),
                      const EmailValidator()
                    ]);
                    return validator.validate(label: "Email", value: value);
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    final validator =
                        Validator(validators: [const RequiredValidator()]);
                    return validator.validate(label: "Password", value: value);
                  },
                ),
                const SizedBox(height: 32),
                MaterialButton(
                  onPressed: () async {
                    await _login(context);
                  },
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  minWidth: double.infinity,
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ResetPassword(),
                  ));
                },
                child: const Text("Reset password"),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Register(),
                  ));
                },
                child: const Text("Register"),
              ),
            ],
          )
        ],
      ),
      // child:
    );
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (mounted && e.code == "INVALID_LOGIN_CREDENTIALS") {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid login credentials")));
        }
      }
    }
  }
}

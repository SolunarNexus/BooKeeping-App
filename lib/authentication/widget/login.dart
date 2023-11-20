import 'package:book_keeping/authentication/widget/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  minWidth: double.infinity,
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Register(),
              ));
            },
            child: const Text("Register"),
          )
        ],
      ),
      // child:
    );
  }
}

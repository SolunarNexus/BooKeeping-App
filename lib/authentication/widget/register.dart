import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/field_label.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userService = GetIt.instance.get<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "Register",
        includeActions: false,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const FieldLabel(text: "Email"),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  final validator = Validator(validators: [
                    const RequiredValidator(),
                    const EmailValidator()
                  ]);
                  return validator.validate(label: "Email", value: value);
                },
              ),
              const SizedBox(height: 32),
              const FieldLabel(text: "Password"),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  final validator = Validator(validators: [
                    const RequiredValidator(),
                    const MinLengthValidator(length: 6),
                  ]);
                  return validator.validate(label: "Password", value: value);
                },
              ),
              const SizedBox(height: 32),
              const FieldLabel(text: "Confirm password"),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  final validator = Validator(validators: [
                    const RequiredValidator(),
                    const MinLengthValidator(length: 6),
                  ]);
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    return "Password does not match confirmation";
                  }
                  return validator.validate(label: "Password", value: value);
                },
              ),
              const SizedBox(height: 32),
              MaterialButton(
                onPressed: () async {
                  await _registerUser(context);
                },
                color: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.primary,
                minWidth: double.infinity,
                child: const Text("Register"),
              )
            ],
          ),
        ),
        // child:
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        if (credential.user?.email != null) {
          _userService.create(credential.user!.email!);
        }
        if (mounted) {
          context.goNamed("home");
        }
      } on FirebaseAuthException catch (e) {
        if (mounted && e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The account already exists for that email")));
        }
      }
    }
  }
}

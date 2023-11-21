import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
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
              MaterialButton(
                onPressed: () async {
                  await _resetPassword(context);
                },
                color: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.primary,
                minWidth: double.infinity,
                child: const Text("Reset Password"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}

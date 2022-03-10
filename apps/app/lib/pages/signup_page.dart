import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zomateen/api/user_api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool loading = false;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    UserAPI _userApi = UserAPI();

    late String _name;
    late String _email;
    late String _password;
    late String _confirmPassword;

    void _saveForm() async {
      setState(() {
        loading = true;
      });

      final bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState!.save();

        if (_password != _confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Passwords do not match!",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );

          return;
        }

        bool res = await _userApi.signup(_name, _email, _password, isAdmin);

        setState(() {
          loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Account Created successfully",
              style: TextStyle(color: Colors.black),
            ),
          ),
        );

        Timer(const Duration(seconds: 2),
            () => {if (res) Navigator.of(context).pop()});
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (loading)
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              TextFormField(
                maxLength: 20,
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  if (val != null) _name = val;
                },
                validator: (val) => (val == null) ? "Enter a valid Name" : null,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  labelText: 'Name',
                  helperText: 'Enter your Name',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                maxLength: 20,
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) {
                  if (val != null) _email = val;
                },
                validator: (val) => (val == null ||
                        val.trim().length < 5 ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val))
                    ? "Enter a valid Email"
                    : null,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  labelText: 'Email',
                  helperText: 'Enter your Email',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                maxLength: 15,
                keyboardType: TextInputType.visiblePassword,
                onSaved: (val) {
                  if (val != null) _password = val;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Enter a valid Password";
                  }

                  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
                  bool hasDigits = password.contains(RegExp(r'[0-9]'));
                  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
                  bool hasSpecialCharacters =
                      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                  bool hasMinLength = password.length > 8;

                  return hasDigits &
                          hasUppercase &
                          hasLowercase &
                          hasSpecialCharacters &
                          hasMinLength
                      ? null
                      : "Enter a stronger Password";
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.password),
                  labelText: 'Password',
                  helperText: 'Enter your Password',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                maxLength: 15,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onSaved: (val) {
                  if (val != null) _confirmPassword = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter a valid Password";
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.password),
                  labelText: 'Confirm Password',
                  helperText: 'Confirm your Password',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text("Admin Account"),
                  Switch(
                    value: isAdmin,
                    onChanged: (_) => setState(() {
                      isAdmin = !isAdmin;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text("Signup"),
              ),
              const SizedBox(height: 10),
              const Text("Already have an Account?"),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Signin"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/api/user_api.dart';
import 'package:zomateen/models/user_model.dart';
import 'package:zomateen/providers/user_provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _userApi = UserAPI();

  bool loading = false;
  late String? _email;
  late String? _password;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);

    void _saveForm() async {
      setState(() {
        loading = true;
      });

      final bool isValid = _formKey.currentState!.validate();
      _formKey.currentState!.save();

      if (isValid && _email != null && _password != null) {
        User? usr = await _userApi.login(_email!, _password!);

        if (usr != null) {
          print(usr);
          _user.setUser = usr;

          Navigator.of(context).pushNamed(
              usr.isAdmin ? "/admin/dashboard" : "/client/dashboard");

          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Error Logging in!",
              style: TextStyle(color: Colors.black),
            ),
          ),
        );

        setState(() {
          loading = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Signin"),
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey,
                ),
              TextFormField(
                maxLength: 20,
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => val == null ? null : _email = val,
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
                onSaved: (val) => val == null ? null : _password = val,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Enter a valid Password";
                  }

                  return null;
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text("Signin"),
              ),
              const SizedBox(height: 10),
              const Text("Don't have an Account?"),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/signup");
                },
                child: const Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

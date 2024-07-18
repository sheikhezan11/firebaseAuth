import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:firebaseauth/interfaces/Auth/register_services.dart';
import 'package:firebaseauth/view/login_view.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final RegisterServices registerServices = RegisterServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: registerServices.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more robust email validation here
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: registerServices.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  // You can add more password validation here
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    UserController().registerUser(
                      registerServices.emailController.text,
                      registerServices.passwordController.text,
                    ).then((success) {
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView(),
                        )
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('The User is Already Existed'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    }
                    );
                  }
                },
                child: const Text("SIGNUP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

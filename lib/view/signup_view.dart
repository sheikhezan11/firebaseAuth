import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:firebaseauth/interfaces/Auth/register_services.dart';
import 'package:firebaseauth/view/login_view.dart';
import 'package:firebaseauth/widget/round_button.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final RegisterServices registerServices = RegisterServices();

  // Future<void> _registerUser() async {
  //   try {
  //     if (_formKey.currentState!.validate()) {
  //       await _auth.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //       final email = _emailController.text;
  //       final password = _passwordController.text;
  //       print('Registration successful: Email: $email, Password: $password');
  //
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginView()));
  //     }
  //   } catch (e) {
  //     // Handle registration errors here
  //     print('Registration failed: $e');
  //     // Show a snackbar or dialog to the user with the error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Registration failed: $e'),
  //         duration: Duration(seconds: 5),
  //       ),
  //     );
  //   }
  // }

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
              ElevatedButton(onPressed: (){

                UserController().registerUser(registerServices.emailController.text, registerServices.passwordController.text);

              }, child: Text("SIGNUP"))
            ],
          ),
        ),
      ),
    );
  }
}

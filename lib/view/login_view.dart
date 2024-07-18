import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:firebaseauth/interfaces/Auth/login_services.dart';
import 'package:firebaseauth/view/home_view.dart';
import 'package:firebaseauth/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final LoginServices loginServices = LoginServices(); // Create a single instance of LoginServices
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: loginServices.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: loginServices.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              RoundButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    UserController().LoginUser(
                      loginServices.emailController.text,
                      loginServices.passwordController.text,
                    ).then((success) {
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView(user: FirebaseAuth.instance.currentUser)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email or password. Please try again.'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    }
                    );
                  }
                },
                title: "Login",
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupView()),
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

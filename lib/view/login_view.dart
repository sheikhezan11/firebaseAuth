import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:firebaseauth/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'signup_view.dart';
import 'package:firebaseauth/interfaces/Auth/login_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final LoginServices loginServices = LoginServices(); // Create a single instance of LoginServices

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: loginServices.emailController, // Use the instance's emailController
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: loginServices.passwordController, // Use the instance's passwordController
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            RoundButton(
              onTap: (){
                UserController().LoginUser(
                    loginServices.emailController.text, // Use the instance's emailController text
                    loginServices.passwordController.text); // Use the instance's passwordController text
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
    );
  }
}

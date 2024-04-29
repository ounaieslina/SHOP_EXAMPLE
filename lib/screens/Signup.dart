import 'package:flutter/material.dart';

import '../sql_helper.dart';
import 'SignIn.dart';

class CreateAccountForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 1500),
                tween: Tween<double>(begin: -1, end: 0),
                builder: (context, value, child) {
                  return FractionalTranslation(
                    translation: Offset(0, value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Utilisez une animation Flutter intégrée pour le titre
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 1000),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Utilisez une animation Flutter intégrée pour le champ Email
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 1500),
                tween: Tween<double>(begin: -1, end: 0),
                builder: (context, value, child) {
                  return FractionalTranslation(
                    translation: Offset(value, 0),
                    child: child,
                  );
                },
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Utilisez une animation Flutter intégrée pour le champ Password
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 1500),
                tween: Tween<double>(begin: 1, end: 0),
                builder: (context, value, child) {
                  return FractionalTranslation(
                    translation: Offset(value, 0),
                    child: child,
                  );
                },
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Utilisez une animation Flutter intégrée pour le bouton
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 2000),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  onPressed: () async{
                    String email = emailController.text;
                    String password = passwordController.text;
                    int id = await SQLHelper.createItem(email, password);
                    debugPrint('New item created with ID: $id');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );                  },
                  child: Text('Create Account'),
                ),
              ),
              SizedBox(height: 20),
        
            ],
          ),
        ),
      ),
    );
  }
}


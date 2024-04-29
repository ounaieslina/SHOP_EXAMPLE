import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../sql_helper.dart';
import 'Signup.dart';
import 'home_screen.dart'; // Update the path accordingly

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Text(
        "Test",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset("assets/Signin.svg", height: 250),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Sign In", style: TextStyle(fontSize: 30)),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: "Email"),
                    controller: emailController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                    controller: passwordController,
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _signIn,
                    child: Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateAccountForm ()),
                          );
                        },
                        child: Text("Sign Up Now", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      toast('Please fill in all fields');
      return;
    }

    bool isValid = await SQLHelper.checkCredentials(email, password);

    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen ()),
      );
    } else {
      toast('Wrong phone number or password');
    }
  }

  void toast(String message) {
    // Implement toast messages
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

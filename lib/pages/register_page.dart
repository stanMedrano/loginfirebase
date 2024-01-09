import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/componentes/button.dart';
import 'package:loginfirebase/componentes/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  //sign user up
  void signUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
//make sure passwords match
    if (passwordTextController.text != confirmPasswordTextController.text) {
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage("Password dont matchat!");
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text, 
        password: passwordTextController.text,
        );
        //pop loading circle
        if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
     if (context.mounted) {
        Navigator.pop(context);
      }
      //show error to user 
      displayMessage(e.code);
    }
  }

//display a dialog message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //texto
                  Text(
                    "Crear cuenta",
                    style: TextStyle(color: Colors.grey[750], fontSize: 15),
                  ),
            
                  const SizedBox(height: 25),
                  //email textField
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  //passrod
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  //Confirmar passrod
                  MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirmar Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  //sign up button
                  MyButton(onTap: signUp, text: 'Sign Up'),
                  const SizedBox(height: 10),
                  //go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿Ya tienes una cuenta?",
                        style: TextStyle(
                          color: Colors.grey[750],
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Entre aquí",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

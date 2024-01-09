import 'package:flutter/material.dart';
import 'package:loginfirebase/pages/login_pages.dart';
import 'package:loginfirebase/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //inicializar 
  bool showLoginPage = true;
  // condicion para cambiar entre login o register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    }else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
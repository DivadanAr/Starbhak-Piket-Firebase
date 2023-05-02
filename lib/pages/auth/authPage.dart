import 'package:flutter/src/widgets/framework.dart';
import 'package:project_starbhak_piket/pages/auth/loginPage.dart';
import 'package:project_starbhak_piket/pages/auth/signUpPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key
  });

  @override
  State < AuthPage > createState() => _AuthPageState();
}

class _AuthPageState extends State < AuthPage > {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin 
    ? LoginPage(onClickSignUp: toggle) 
    : SignUpPage(onClickSignin: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
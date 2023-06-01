import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/login_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        backgroundColor: ColorsManager.background,
      ),
      body: const LoginBody(),

    );
  }
}
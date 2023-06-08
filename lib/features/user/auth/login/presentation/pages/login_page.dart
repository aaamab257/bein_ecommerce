import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../on_boarding/presentation/manager/countries_cubit.dart';
import '../widgets/login_body.dart';

class LoginPage extends StatefulWidget {
  final String iniCountry;
  final List<String> countries ;
 LoginPage({Key? key, required this.iniCountry ,required this.countries}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  @override
  void initState() {
   
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        backgroundColor: ColorsManager.background,
      ),
      body:  LoginBody(countries:widget. countries , iniCountry:widget. iniCountry,),
    );
  }
}

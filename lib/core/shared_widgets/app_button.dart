import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppButton extends StatelessWidget {
  final String buttonTxt;
  final Function() onPressed ;
  const AppButton({super.key, required this.onPressed,  required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed  ,
      child: Text(buttonTxt),
    );
    
  }
}

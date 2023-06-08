import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SolidBtn extends StatefulWidget {
  final Widget Text ;
  final Function() onPressed ;

  const SolidBtn({super.key , required this.Text , required this.onPressed});

  @override
  State<SolidBtn> createState() => _SolidBtnState();
}

class _SolidBtnState extends State<SolidBtn> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      
      style: OutlinedButton.styleFrom(
        backgroundColor:Color(0xff064A7B),
        
      ),
      onPressed: widget.onPressed,
      
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget.Text
      ),
    );
  }
}

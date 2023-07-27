import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OutLinedBtn extends StatelessWidget {
  final Widget Text;
  final Function() onPressed;
  const OutLinedBtn({super.key, required this.Text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          ),
      onPressed: onPressed,
      child: Padding(padding: const EdgeInsets.all(10.0), child: Text),
    );
  }
}

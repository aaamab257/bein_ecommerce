import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff444d56)),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          msg,
          style: const TextStyle(
              color: ColorsManager.white,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
    backgroundColor: const Color(0xff444d56),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(120.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16.0),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

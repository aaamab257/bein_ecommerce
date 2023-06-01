import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppToasts{
    static Future errorDialog({required BuildContext context ,  String? message}){
    return showDialog(context: context, builder: (context) =>  Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.h)),
      child: SizedBox(height:100.h,child:  Center(child: Text(message?? "Something Error !"))),
    ),);
  }


}
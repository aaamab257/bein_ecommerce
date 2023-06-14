import 'package:bein_ecommerce/features/user/auth/otp/presentation/widgets/otp_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../../core/utils/colors/colors_manager.dart';

class OtpPage extends StatefulWidget {
  final String phone, email;

  const OtpPage({required this.email, required this.phone, super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

      ),
      body: OtpBody(phone: widget.phone),
    );
  }
}

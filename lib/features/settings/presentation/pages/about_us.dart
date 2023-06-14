import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager/img_manger.dart';
import '../../../../core/utils/colors/colors_manager.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          title: const Text(
            'About us',
          ),
        ),
        body: ListView(
          children: [
            Image.asset(
              ImagesManager.bannerDemo1,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

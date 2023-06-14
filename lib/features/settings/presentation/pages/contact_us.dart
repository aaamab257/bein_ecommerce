import 'package:bein_ecommerce/core/shared_widgets/solid_button.dart';
import 'package:bein_ecommerce/core/utils/assets_manager/img_manger.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../config/localization/app_localization.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Contact us',
          ),
        ),
        body: ListView(
          children: [
            Image.asset(
              ImagesManager.bannerDemo1,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,

                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Contact Us',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Location',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                        'Kuwat-Sharq-Ahmed Al Jaber Street-dasman complex-block 3- fourth floor '),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Phone',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('+96596690411 '),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Email',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('hr@bit-kw.com'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                         width: 0.5),
                                  ),
                                  filled: true,

                                  hintText: AppLocalizations.of(context)!
                                          .translate("name") ??
                                      "Your Name",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Color(0xffF5F5F5), width: 0.5),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF5F5F5),
                                  hintText: AppLocalizations.of(context)!
                                          .translate("email") ??
                                      "Your Email",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Color(0xffF5F5F5), width: 0.5),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF5F5F5),
                                  hintText: AppLocalizations.of(context)!
                                          .translate("message") ??
                                      "Your Message",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SolidBtn(
                                Text: const Text(
                                  'Send',
                                  style: TextStyle(color: ColorsManager.white),
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

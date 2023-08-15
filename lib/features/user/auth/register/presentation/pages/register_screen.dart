import 'package:bein_ecommerce/core/shared_widgets/custom_snackbar.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/pages/login_page.dart';
import 'package:bein_ecommerce/features/user/auth/register/data/models/register_model.dart';
import 'package:bein_ecommerce/features/user/intresting/intrested_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../../config/localization/app_localization.dart';
import '../../../../../../core/shared_widgets/app_button.dart';
import '../../../../../../core/shared_widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  String iniCountry = '';
  List<String> countries = [];
  RegisterScreen(
      {super.key, required this.countries, required this.iniCountry});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

FloatingActionButton buildFloatingActionButton() {
  return FloatingActionButton(
    onPressed: () async {},
    child: const Icon(
      Icons.chat_bubble_outline_outlined,
    ),
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _password1Focus = FocusNode();
  FocusNode _password2Focus = FocusNode();

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            AppLocalizations.of(context)!.translate('register') ?? "Register"),
      ),
      floatingActionButton: buildFloatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 25.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('welcome') ??
                        "Welcome in sinyar",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('name') ?? "Name",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CustomTextField(
                  controller: _nameController,
                  hint:
                      AppLocalizations.of(context)?.translate("name") ?? "Name",
                  type: TextInputType.text,
                  isPassword: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('phone') ?? "Phone",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _PhoneTextField(_phoneController),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('email') ?? "Email",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  hint: AppLocalizations.of(context)?.translate("email") ??
                      "Email",
                  type: TextInputType.emailAddress,
                  isPassword: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('password') ??
                        "Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CustomTextField(
                  controller: _password1Controller,
                  hint:
                      AppLocalizations.of(context)?.translate("password_txt") ??
                          "Password",
                  type: TextInputType.text,
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('confirm_pass') ??
                        "Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CustomTextField(
                  controller: _password2Controller,
                  hint:
                      AppLocalizations.of(context)?.translate("confirm_pass") ??
                          "Confirm Password",
                  type: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 72.0, right: 72.0, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        buttonTxt: AppLocalizations.of(context)!
                                .translate('register') ??
                            "Register",
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                        .translate('email_error') ??
                                    "Please Enter your E-mail");
                          } else if (_phoneController.text.isEmpty) {
                            showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                        .translate('phone_error') ??
                                    "Please Enter your Phone Number");
                          } else if (_nameController.text.isEmpty) {
                            showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                        .translate('Name_error') ??
                                    "Please Enter your Name");
                          } else if (_password1Controller.text.isEmpty) {
                            showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                        .translate('phone_error') ??
                                    "Please Enter your Password");
                          }
                          RegisterModel registerModel = RegisterModel(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _nameController.text,
                            is_admin: false,
                            is_user: true,
                            is_vendor: false,
                            password: _password1Controller.text,
                            password2: _password2Controller.text,
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const IntrestedScreen()),
                          // );
                        },
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                    .translate('already_have_account') ??
                                "Already Have Account?",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage(
                                          iniCountry: widget.iniCountry,
                                          countries: widget.countries,
                                        )),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                      .translate('login') ??
                                  "Login",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _PhoneTextField(TextEditingController _phoneController) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: IntlPhoneField(
          showCountryFlag: true,
          showDropdownIcon: false,
          disableLengthCheck: true,
          showCursor: true,
          onChanged: (value) {},
          onSubmitted: (valueKey) {},
          countries: widget.countries,
          initialCountryCode: widget.iniCountry,
          controller: _phoneController,
          textAlign: TextAlign.start,
          focusNode: _phoneFocus,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            border: const OutlineInputBorder(),
            hintText: AppLocalizations.of(context)?.translate("phone") ??
                "Phone number",
            filled: true,
            alignLabelWithHint: true,
            isDense: false,
          ),
        ),
      ),
    );
  }
}

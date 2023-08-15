import 'package:bein_ecommerce/core/shared_widgets/text_field.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_state.dart';
import 'package:bein_ecommerce/features/user/auth/register/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../config/localization/app_localization.dart';
import '../../../../../../config/route/app_routes.dart';
import '../../../../../../core/shared_widgets/app_button.dart';
import '../../../../../../core/shared_widgets/custom_snackbar.dart';
import '../../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../../core/shared_widgets/solid_button.dart';
import '../../../../../../core/utils/colors/colors_manager.dart';
import '../../../otp/presentation/pages/otp_page.dart';
import '../../data/models/login_request.dart';

class LoginBody extends StatefulWidget {
  String iniCountry;
  List<String> countries = [];

  LoginBody({super.key, required this.countries, this.iniCountry = "EG"});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  

  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  bool email = false;
  bool phone = false;
  bool isEmptyEmail = false;

  bool isEmptyPhone = false;

  bool emailFounded = false;

  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = true;
  }

  @override
  void dispose() {
    _passController.dispose();

    super.dispose();
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {},
      child: const Icon(
        Icons.chat_bubble_outline_outlined,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (context) => di.sl<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) => di.sl<LoginCubit>(),
          builder: (context, state) {
            Widget _body1() {
              if (state is CheckPhoneLoading) {
                return const LoadingScreen();
              } else if (state is CheckPhoneError) {
                return AppErrorWidget(
                  onPress: () {
                    setState(() {});
                  },
                );
              } else {
                return SafeArea(
                  child: Scaffold(
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
                                  AppLocalizations.of(context)!.translate(
                                          'login_and_register_with_phone') ??
                                      "Please Enter you phone and password",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .translate('phone') ??
                                      "Phone",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: _PhoneTextField(_phoneController),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .translate('password') ??
                                      "Password",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              CustomTextField(
                                controller: _passController,
                                hint: AppLocalizations.of(context)
                                        ?.translate("password_txt") ??
                                    "Password",
                                type: TextInputType.text,
                                isPassword: true,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      AppLocalizations.of(context)!
                                              .translate('forget_password') ??
                                          "Forget your password?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 72.0, right: 72.0, bottom: 25),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppButton(
                                      buttonTxt: AppLocalizations.of(context)!
                                              .translate('login') ??
                                          "Login",
                                      onPressed: () {
                                        String phone = _phoneController.text;
                                        print('phone : ======== > $phone');
                                        LoginCubit.get(context)
                                            .login(LoginRequest(
                                                phoneNumber: phone,
                                                password: _passController.text))
                                            .then((value) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              AppRouteName.home,
                                              (route) => false);
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 35.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .translate('dont_have_acc') ??
                                              "Don`t have an account?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        const SizedBox(
                                          width: 3.0,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen(
                                                        iniCountry:
                                                            widget.iniCountry,
                                                        countries:
                                                            widget.countries,
                                                      )),
                                            );
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                    .translate('register') ??
                                                "Register",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
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
                  ),
                );
              }
            }

            return SafeArea(
              child: Scaffold(
                body: Container(
                  child: _body1(),
                ),
              ),
            );
          },
        ));
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

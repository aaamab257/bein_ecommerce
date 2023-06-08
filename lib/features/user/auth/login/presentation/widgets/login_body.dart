import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_state.dart';
import 'package:flutter/material.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../config/localization/app_localization.dart';
import '../../../../../../core/shared_widgets/custom_snackbar.dart';
import '../../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../../core/shared_widgets/solid_button.dart';
import '../../../../../../core/utils/colors/colors_manager.dart';
import '../../../otp/presentation/pages/otp_page.dart';

class LoginBody extends StatefulWidget {
  String iniCountry = '';
  List<String> countries = [];
  LoginBody({super.key, required this.countries, required this.iniCountry});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

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
    _emailController.dispose();

    super.dispose();
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
                    backgroundColor: ColorsManager.background,
                    body: Container(
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                                ?.translate("enter_phone") ??
                                            "enter_phone",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)?.translate(
                                                "login_and_register_with_phone") ??
                                            "login_and_register_with_phone",
                                        style: const TextStyle(fontSize: 18.0),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      IntlPhoneField(
                                        showCountryFlag: false,
                                        showCursor: false,
                                        onChanged: (value) {},
                                        onSubmitted: (valueKey) {
                                          print(
                                              'phone number ==========1============== >${valueKey}');
                                        },
                                        countries: widget.countries,
                                        initialCountryCode: widget.iniCountry,
                                        controller: _phoneController,
                                        textAlign: TextAlign.start,
                                        focusNode: _phoneFocus,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          hintText: AppLocalizations.of(context)
                                                  ?.translate("phone") ??
                                              "Phone number",
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
                                          fillColor: ColorsManager.background,
                                          alignLabelWithHint: true,
                                          isDense: false,
                                        ),
                                      ),
                                      isEmptyPhone
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Please Enter your phone',
                                                style: TextStyle(
                                                    color: ColorsManager.red,
                                                    fontSize: 13.0),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      email
                                          ? TextField(
                                              controller: _emailController,
                                              focusNode: _emailFocus,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: AppLocalizations.of(
                                                            context)
                                                        ?.translate("email") ??
                                                    "Email",
                                                filled: true,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                fillColor:
                                                    ColorsManager.background,
                                                alignLabelWithHint: true,
                                                isDense: true,
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      isEmptyEmail
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Please Enter your Email',
                                                style: const TextStyle(
                                                    color: ColorsManager.red,
                                                    fontSize: 18.0),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      emailFounded
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'This Email already taken by another user',
                                                style: TextStyle(
                                                    color: ColorsManager.red,
                                                    fontSize: 13.0),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SolidBtn(
                                    onPressed: _isEnabled
                                        ? () {
                                            if (email) {
                                              if (_emailController
                                                  .text.isEmpty) {
                                                showSnackBar(
                                                    context,
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "empty_fields") ??
                                                        "Please fill Empty Fields",
                                                    );
                                                setState(() {
                                                  isEmptyEmail = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isEmptyEmail = false;
                                                });
                                                LoginCubit.get(context)
                                                    .checkMail(CheckMailRequest(
                                                        email: _emailController
                                                            .text))
                                                    .then((value) async {
                                                  if (!value) {
                                                    String cartID = "";
                                                    String countryID = "";
                                                    await di
                                                        .sl<CartCubit>()
                                                        .getCartId()
                                                        .then((value) {
                                                      cartID = value;
                                                    });
                                                    await di
                                                        .sl<CountriesCubit>()
                                                        .getCurrentCountry()
                                                        .then((value) {
                                                      countryID = value.id;
                                                    });
                                                    await LoginCubit.get(
                                                            context)
                                                        .register(RegisterRequest(
                                                            phone:
                                                                _phoneController
                                                                    .text,
                                                            email:
                                                                _emailController
                                                                    .text,
                                                            cartId: cartID,
                                                            countryId:
                                                                countryID))
                                                        .then((value) {
                                                      if (value) {
                                                        Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                                pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    OtpPage(
                                                                      email: _emailController
                                                                          .text,
                                                                      phone: _phoneController
                                                                          .text,
                                                                    ),
                                                                transitionDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                transitionsBuilder:
                                                                    (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                  const begin =
                                                                      Offset(
                                                                          0.0,
                                                                          1.0);
                                                                  const end =
                                                                      Offset
                                                                          .zero;
                                                                  final tween = Tween(
                                                                      begin:
                                                                          begin,
                                                                      end: end);
                                                                  final offsetAnimation =
                                                                      animation
                                                                          .drive(
                                                                              tween);
                                                                  return SlideTransition(
                                                                    position:
                                                                        offsetAnimation,
                                                                    child:
                                                                        child,
                                                                  );
                                                                }));
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      emailFounded = true;
                                                    });
                                                  }
                                                });
                                              }
                                            } else {
                                              if (_phoneController
                                                  .text.isEmpty) {
                                                showSnackBar(
                                                    context,
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "empty_fields") ??
                                                        "Please fill Empty Fields",
                                                    );
                                                setState(() {
                                                  isEmptyPhone = false;
                                                  // showSnackBar(
                                                  //     context,
                                                  //     AppLocalizations.of(
                                                  //                 context)!
                                                  //             .translate(
                                                  //                 "empty_fields") ??
                                                  //         "Please fill Empty Fields",
                                                  //     ColorsManager.white,
                                                  //     const Color(0xff064A7B));
                                                });
                                              } else {
                                                setState(() {
                                                  isEmptyPhone = false;
                                                });
                                                LoginCubit.get(context)
                                                    .checkPhone(
                                                        CheckPhoneRequest(
                                                            phone:
                                                                _phoneController
                                                                    .text))
                                                    .then((value) {
                                                  if (value) {
                                                    print(
                                                        'phone number ==========1============== >${_phoneController.text.trim()}');
                                                    Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                    animation,
                                                                    secondaryAnimation) =>
                                                                OtpPage(
                                                                  phone:
                                                                      _phoneController
                                                                          .text,
                                                                  email:
                                                                      _emailController
                                                                          .text,
                                                                ),
                                                            transitionDuration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            transitionsBuilder:
                                                                (context,
                                                                    animation,
                                                                    secondaryAnimation,
                                                                    child) {
                                                              const begin =
                                                                  Offset(
                                                                      0.0, 1.0);
                                                              const end =
                                                                  Offset.zero;
                                                              final tween =
                                                                  Tween(
                                                                      begin:
                                                                          begin,
                                                                      end: end);
                                                              final offsetAnimation =
                                                                  animation
                                                                      .drive(
                                                                          tween);
                                                              return SlideTransition(
                                                                position:
                                                                    offsetAnimation,
                                                                child: child,
                                                              );
                                                            }));
                                                  } else {
                                                    setState(() {
                                                      print(
                                                          'phone number ==========2============== >${_phoneController.text.trim()}');
                                                      email = true;
                                                    });
                                                  }
                                                });
                                              }

                                              /**/
                                            }
                                          }
                                        : () {
                                            showSnackBar(
                                                context,
                                                AppLocalizations.of(context)!
                                                        .translate(
                                                            "empty_fields") ??
                                                    "Please fill Empty Fields",
                                                );
                                          },
                                    Text: Text(
                                      AppLocalizations.of(context)
                                              ?.translate('continue') ??
                                          "Continue",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: ColorsManager.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }

            return SafeArea(
              child: Scaffold(
                backgroundColor: ColorsManager.background,
                body: Container(
                  child: _body1(),
                  color: ColorsManager.background,
                ),
              ),
            );
          },
        ));
  }
}

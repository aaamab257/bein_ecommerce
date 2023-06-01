import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/login_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../../config/localization/app_localization.dart';
import '../../../../../../config/route/app_routes.dart';
import '../../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../../core/shared_widgets/solid_button.dart';
import '../../../../../../core/utils/colors/colors_manager.dart';
import '../../../login/presentation/manager/login_cubit.dart';
import '../../../login/presentation/manager/login_state.dart';

class OtpBody extends StatefulWidget {
  final String phone;

  const OtpBody({super.key, required this.phone});

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  TextEditingController _fController = TextEditingController();
  TextEditingController _sController = TextEditingController();
  TextEditingController _thController = TextEditingController();
  TextEditingController _foController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    /* appBar: AppBar(backgroundColor: ColorsManager.background), */
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
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)
                                                ?.translate("otp_code") ??
                                            "Otp_code",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)?.translate(
                                              "otp_code_subTitle") ??
                                          "Otp_code_subTitle",
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _textFieldOTP(
                                                  first: true,
                                                  last: false,
                                                  controller: _fController),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _textFieldOTP(
                                                  first: false,
                                                  last: false,
                                                  controller: _sController),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _textFieldOTP(
                                                  first: false,
                                                  last: false,
                                                  controller: _thController),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _textFieldOTP(
                                                  first: false,
                                                  last: true,
                                                  controller: _foController),
                                            )),
                                      ],
                                    ),
                                    /*const Text(
                                      "Resend New Code",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                    onPressed: () {
                                      if (_fController.text.isEmpty) {
                                      } else if (_sController.text.isEmpty) {
                                      } else if (_thController.text.isEmpty) {
                                      } else if (_foController.text.isEmpty) {
                                      } else {
                                        String otp = _fController.text +
                                            _sController.text +
                                            _thController.text +
                                            _foController.text;
                                        LoginCubit.get(context)
                                            .login(LoginRequest(
                                                phoneNumber: widget.phone,
                                                otpCode: otp))
                                            .then((value) {

                                          di
                                              .sl<LoginCubit>()
                                              .saveToken(value)
                                              .then((value) {
                                            if (value) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRouteName.home,
                                                  (route) => false);
                                            }
                                          });
                                        });
                                      }
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

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          controller: controller,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: ColorsManager.black),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: ColorsManager.black),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

/**/
}

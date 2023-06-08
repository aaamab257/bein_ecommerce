import 'package:bein_ecommerce/core/shared_widgets/solid_button.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:bein_ecommerce/features/user/profile/presentation/manager/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../../../../config/localization/app_localization.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../data/local/models/profile_data_request.dart';
import '../manager/profile_cubit.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool refresh = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<ProfileCubit>()..getProfile(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) => di.sl<ProfileCubit>(),
            builder: (context, state) {
              if (!refresh) {
                di.sl<ProfileCubit>().getProfile().then((userModel) {
                  setState(() {
                    _emailController.text = userModel.email!.address!;
                    _firstNameController.text = userModel.firstName ?? "";
                    _lastNameController.text = userModel.lastName ?? "";
                    _phoneController.text = userModel.phone!.phoneNumber!;
                    _addressController.text = userModel.address!;
                    refresh = true;
                  });
                });
              }

              Widget body() {
                if (state is ProfileLoading) {
                  return const LoadingScreen();
                } else if (state is ProfileError) {
                  return AppErrorWidget(
                    onPress: () {
                      setState(() {});
                    },
                  );
                } else {
                  return Scaffold(
                      appBar: AppBar(
                        backgroundColor: ColorsManager.splashBackground,
                        centerTitle: true,
                        title: Text(
                          AppLocalizations.of(context)?.translate("account") ??
                              "account",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Container(
                        color: Colors.white,
                        child: ListView(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 20),
                                  child: Container(
                                    color: Color(0xffFFFFFF),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)
                                                            ?.translate(
                                                                "account_info") ??
                                                        "account_info",
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: <Widget>[
                                                  _status
                                                      ? _getEditIcon()
                                                      : Container(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "firstName") ??
                                                        "First name",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                child: TextField(
                                                  controller:
                                                      _firstNameController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                "firstName") ??
                                                        "First name",
                                                  ),
                                                  enabled: !_status,
                                                  autofocus: !_status,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "lastName") ??
                                                        "Last name",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                child: TextField(
                                                  controller:
                                                      _lastNameController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                "lastName") ??
                                                        "Last name",
                                                  ),
                                                  enabled: !_status,
                                                  autofocus: !_status,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "email") ??
                                                        "Email",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                child: TextField(
                                                  controller:
                                                      _emailController,
                                                  decoration:
                                                       InputDecoration(
                                                          border:
                                                          OutlineInputBorder(),
                                                          hintText:
                                                          AppLocalizations.of(
                                                              context)!
                                                              .translate(
                                                              "email") ??
                                                              "Email",),
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "address") ??
                                                        "Address",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                child: TextField(
                                                  controller:
                                                      _addressController,
                                                  decoration: InputDecoration(
                                                    border:
                                                    OutlineInputBorder(),
                                                    hintText: AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                "address") ??
                                                        "Address",
                                                  ),
                                                  enabled: !_status,
                                                  autofocus: !_status,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                "phone") ??
                                                        "Phone",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                child: TextFormField(
                                                  controller:
                                                      _phoneController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                "phone") ??
                                                        "Phone",
                                                  ),
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        !_status
                                            ? _getActionButtons()
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ));
                }
              }

              return Scaffold(
                backgroundColor: ColorsManager.background,
                body: body(),
              );
            }));
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SolidBtn(
                Text:  Text(
                  AppLocalizations
                      .of(context)!
                      .translate(
                      "save") ??
                      "Save",
                  style:const TextStyle(color: ColorsManager.white),
                ),
                onPressed: () async {
                  ProfileDataRequest model = ProfileDataRequest(
                    lName: _lastNameController.text.trim(),
                    address: _addressController.text.trim(),
                    fName: _firstNameController.text.trim(),
                  );

                  await di
                      .sl<ProfileCubit>()
                      .updateProfile(model)
                      .then((value) {
                    PanaraInfoDialog.showAnimatedGrow(
                      context,
                      imagePath: 'assets/images/success.png',
                      title: "Profile update",
                      message: "Your profile updated successfully",
                      buttonText: "Ok",
                      onTapDismiss: () {
                        setState(() {
                          _status = true;
                        });
                        Navigator.of(context).pop();
                      },
                      panaraDialogType: PanaraDialogType.normal,
                    );
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SolidBtn(
                Text: Text(
                    AppLocalizations
                        .of(context)!
                        .translate(
                        "cancel") ??
                        "Cancel",
                  style:const TextStyle(color: ColorsManager.white),
                ),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

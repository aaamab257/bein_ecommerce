import 'package:bein_ecommerce/core/shared_widgets/solid_button.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:bein_ecommerce/features/user/profile/presentation/manager/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
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
                        title: const Text('Profile'),
                      ),
                      body: Container(
                        color: Colors.white,
                        child: ListView(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  color: Color(0xffFFFFFF),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'Account Information',
                                                      style: TextStyle(
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
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'First Name',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                        _firstNameController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "First Name",
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'Last Name',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                        _lastNameController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Last Name",
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'Email',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Flexible(
                                                  child: TextField(
                                                    controller:
                                                    _emailController,
                                                    decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                        "Enter Email"),
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            )),

                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'Address',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                    _addressController,
                                                    decoration:
                                                    const InputDecoration(
                                                      hintText: "Address",
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 25.0),
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
                                                      'Phone Number',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0,
                                                right: 25.0,
                                                top: 2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                        _phoneController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Enter Phone Number"),
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            )),
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
              padding: const EdgeInsets.only(right: 10.0),
              child: SolidBtn(
                Text: const Text(
                  'Save',
                  style: TextStyle(color: ColorsManager.white),
                ),
                onPressed: () async {
                  UserModel model = UserModel(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      address: "",
                      phone: Phone(phoneNumber: _phoneController.text.trim()),
                      email: Email(address: "", verified: false));
                  await di
                      .sl<ProfileCubit>()
                      .updateProfile(model)
                      .then((value) {
                    print(value);
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SolidBtn(
                Text: const Text(
                  'Cancel',
                  style: TextStyle(color: ColorsManager.white),
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

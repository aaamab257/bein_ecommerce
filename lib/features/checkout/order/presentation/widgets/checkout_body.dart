import 'package:bein_ecommerce/core/shared_widgets/solid_button.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/place_order_model.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../../../../config/localization/app_localization.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../core/utils/colors/colors_manager.dart';

enum PaymentType { cash, installment }

class CheckoutBody extends StatefulWidget {
  final List<String> payType;

  const CheckoutBody({Key? key, required this.payType}) : super(key: key);

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  PaymentType type = PaymentType.cash;
  bool installment = false;
  int currentIndex = 0;
  String currentPayment = "CASH ON SHIPPING";
  String token = '';
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _nationalIdFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _nationalIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          installment
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                                .translate("fillYourData") ??
                            "Please fill your data",
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _inputField(
                                _firstNameController,
                                AppLocalizations.of(context)!
                                        .translate("firstName") ??
                                    "First name",
                                _firstNameFocus,
                                TextInputType.text),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: _inputField(
                                _lastNameController,
                                AppLocalizations.of(context)!
                                        .translate("lastName") ??
                                    "Last name",
                                _lastNameFocus,
                                TextInputType.text),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _emailController,
                          AppLocalizations.of(context)!.translate("email") ??
                              "Email",
                          _emailFocus,
                          TextInputType.emailAddress),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _phoneController,
                          AppLocalizations.of(context)!.translate("phone") ??
                              "Phone",
                          _phoneFocus,
                          TextInputType.number),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _addressController,
                          AppLocalizations.of(context)!.translate("address") ??
                              "Address",
                          _addressFocus,
                          TextInputType.text),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _nationalIdController,
                          AppLocalizations.of(context)!
                                  .translate("nationalId") ??
                              "National Id",
                          _nationalIdFocus,
                          TextInputType.text),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                                .translate("fillYourData") ??
                            "Please fill your data",
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _inputField(
                                _firstNameController,
                                AppLocalizations.of(context)!
                                        .translate("firstName") ??
                                    "First name",
                                _firstNameFocus,
                                TextInputType.text),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: _inputField(
                                _lastNameController,
                                AppLocalizations.of(context)!
                                        .translate("lastName") ??
                                    "Last name",
                                _lastNameFocus,
                                TextInputType.text),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _emailController,
                          AppLocalizations.of(context)!.translate("email") ??
                              "Email",
                          _emailFocus,
                          TextInputType.emailAddress),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _phoneController,
                          AppLocalizations.of(context)!.translate("phone") ??
                              "Phone",
                          _phoneFocus,
                          TextInputType.number),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _inputField(
                          _addressController,
                          AppLocalizations.of(context)!.translate("address") ??
                              "Address",
                          _addressFocus,
                          TextInputType.text),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
                AppLocalizations.of(context)!.translate("select_payment") ??
                    "Select the payment type"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Container(
                height: 150.0,
                child: Center(
                  child: SizedBox(
                    height: 150.h,
                    child: ListView(
                      children: List.generate(
                        widget.payType.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              currentPayment = widget.payType[index];
                              if (widget.payType[index] == 'CASH ON SHIPPING' ||
                                  widget.payType[index] ==
                                      'الـدفـع عنـد الاستــلام') {
                                setState(() {
                                  installment = false;
                                });
                              } else {
                                setState(() {
                                  installment = true;
                                });
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ListTile(
                              tileColor: ColorsManager.background,
                              selectedColor: ColorsManager.black,
                              selectedTileColor: ColorsManager.grey,
                              selected: currentIndex == index,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              title: Text(
                                widget.payType[index],
                                style:
                                    const TextStyle(color: ColorsManager.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
            child: Container(
              width: size.width,
              child: SolidBtn(
                  Text: Text(
                    AppLocalizations.of(context)!.translate("place_order") ??
                        "Place order",
                    style: const TextStyle(
                        color: ColorsManager.white, fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await di.sl<LoginCubit>().getToken().then((value) {
                      token = value;
                    });
                    if (currentPayment == 'CASH ON SHIPPING' ||
                        currentPayment == 'الـدفـع عنـد الاستــلام') {
                      if (_firstNameController.text.isNotEmpty &&
                          _lastNameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _addressController.text.isNotEmpty) {
                        await di
                            .sl<CartCubit>()
                            .placeOrder(
                                token,
                                PlaceOrderRequest(
                                    phone: _phoneController.text,
                                    email: _emailController.text,
                                    address: _addressController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    nationalId: "",
                                    payType: currentPayment))
                            .then((value) {
                          PanaraInfoDialog.showAnimatedGrow(
                            context,
                            imagePath: 'assets/images/success.png',
                            title: "Place Order",
                            message: "Your order placed successfully",
                            buttonText: "Ok",
                            onTapDismiss: () {
                              Navigator.pushNamed(context, AppRouteName.home);
                            },
                            panaraDialogType: PanaraDialogType.normal,
                          );
                        });
                      }
                    } else {
                      if (_firstNameController.text.isNotEmpty &&
                          _lastNameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _addressController.text.isNotEmpty &&
                          _nationalIdController.text.isNotEmpty) {
                        await di
                            .sl<CartCubit>()
                            .placeOrder(
                                token,
                                PlaceOrderRequest(
                                    phone: _phoneController.text,
                                    email: _emailController.text,
                                    address: _addressController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    nationalId: _nationalIdController.text,
                                    payType: currentPayment))
                            .then((value) {
                          PanaraInfoDialog.showAnimatedGrow(
                            context,
                            imagePath: 'assets/images/success.png',
                            title: AppLocalizations.of(context)!
                                    .translate("place_order") ??
                                "Place order",
                            message: "Your order placed successfully",
                            buttonText: "Ok",
                            onTapDismiss: () {
                              Navigator.pushNamed(context, AppRouteName.home);
                            },
                            panaraDialogType: PanaraDialogType.normal,
                          );
                        });
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

/**/

Widget _inputField(
  TextEditingController controller,
  String hint,
  FocusNode focusNode,
  TextInputType inputType,
) {
  return TextField(
    onChanged: (value) {},
    controller: controller,
    focusNode: focusNode,
    keyboardType: inputType,
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[800]),
      fillColor: ColorsManager.background,
      alignLabelWithHint: true,
      isDense: true,
    ),
  );
}

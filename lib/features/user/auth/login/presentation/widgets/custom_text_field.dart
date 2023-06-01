import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
 
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  
  final bool isSearch;
 
  final bool isEnabled;
  final TextCapitalization capitalization;
  final bool isElevation;
  final bool isPadding;
  

  const CustomTextField({this.hintText = 'Write something...',
      required this.controller,
      required this.focusNode,
      required this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
     
      
      this.capitalization = TextCapitalization.none,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
     
      this.isIcon = false,
      this.isPassword = false,
      
      this.isSearch = false,
      this.isElevation = true,
      this.isPadding=true});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.inputType,
      
  decoration: InputDecoration(
    hintText: widget.hintText,
    contentPadding: EdgeInsets.all(20),
  
        suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
                  ? IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
                      onPressed: _toggle): null
                  
              : null,
    enabledBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(width:1, color: ColorsManager.white),
      borderRadius: BorderRadius.circular(50.0),
    ),
  ),
);
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
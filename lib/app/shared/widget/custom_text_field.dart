import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String label;
  String hint;
  TextEditingController controller;
  Function validator;
  //Function onChanged;
  bool password;
  bool visibility;
  IconButton? suffixIcon;
  TextInputType keyboardType;

  CustomTextField(
      {required this.label,
      required this.hint,
      required this.controller,
      required this.validator,
      this.password = false,
      this.suffixIcon,
      this.visibility = false,
      required this.keyboardType});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.visibility,
          validator: (value) => widget.validator(value),
          style: StyleText.labelTextField,
          decoration: new InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    BorderSide(color: AppColors.greenBlueGrayola, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    BorderSide(color: AppColors.greenBlueGrayola, width: 2)),
            suffixIcon: widget.password ? widget.suffixIcon : null,
            labelText: widget.label,
            labelStyle: TextStyle(color: AppColors.greenBlueGrayola),
            hintText: widget.hint,
          ),
        ));
  }
}

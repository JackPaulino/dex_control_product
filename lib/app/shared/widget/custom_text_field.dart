import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/custom_decimal.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String label;
  String hint;
  TextEditingController controller;
  Function validator;
  Function onFieldSubmitted;
  TextCapitalization textCapitalization;
  bool visibility;
  bool inputFormat;
  TextAlign textAlign;
  IconButton? suffixIcon;
  TextInputType keyboardType;

  CustomTextField(
      {required this.label,
      required this.hint,
      required this.controller,
      required this.validator,
      required this.onFieldSubmitted,
      this.inputFormat = false,
      this.textCapitalization = TextCapitalization.none,
      this.textAlign = TextAlign.start,
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
          textAlign: widget.textAlign,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      BorderSide(color: AppColors.greenBlueGrayola, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      BorderSide(color: AppColors.greenBlueGrayola, width: 2)),
              suffixIcon: widget.suffixIcon,
              labelText: widget.label,
              labelStyle: TextStyle(color: AppColors.greenBlueGrayola),
              hintText: widget.hint),
          onFieldSubmitted: (value) => widget.onFieldSubmitted(value),
          inputFormatters: widget.inputFormat
              ? [
                  LengthLimitingTextInputFormatter(7),
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter.digitsOnly,
                  // ignore: deprecated_member_use
                  BlacklistingTextInputFormatter.singleLineFormatter,
                  new CurrencyInputFormatter()
                ]
              : [],
        ));
  }
}

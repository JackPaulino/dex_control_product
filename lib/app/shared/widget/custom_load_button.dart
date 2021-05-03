import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoadButton extends StatefulWidget {
  final bool loading;
  final Function onPressed;
  final String txt;
  final double width;
  final TextStyle styleText;

  const CustomLoadButton(
      {Key? key,
      required this.loading,
      required this.onPressed,
      required this.txt,
      required this.width,
      required this.styleText})
      : super(key: key);
  @override
  _CustomLoadButtonState createState() => _CustomLoadButtonState();
}

class _CustomLoadButtonState extends State<CustomLoadButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      // ignore: deprecated_member_use
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
        height: widget.width,
        color: AppColors.pineGreen,
        onPressed: widget.loading
            ? () {}
            : () {
                setState(() {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();
                  widget.onPressed();
                });
              },
        child: widget.loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.loading))
            : Text(widget.txt, style: widget.styleText),
      ),
    );
  }
}

import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool pop;
  final bool confBtnColor;

  const CustomDialogButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.pop = false,
      this.confBtnColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: height * .065,
        width: width * .3,
        // ignore: deprecated_member_use
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          color: confBtnColor ? Colors.green : AppColors.primary,
          onPressed: () {
            if (pop) Navigator.pop(context);
            onPressed();
          },
        ),
      ),
    );
  }
}

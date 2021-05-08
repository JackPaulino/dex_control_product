import 'package:flutter/material.dart';

Future<void> customDialog(context,
    {String title = '',
    String text = '',
    Widget? content,
    List<Widget>? buttons,
    bool barrierDismissible = true,
    icon}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AlertDialog(
          title: icon != null
              ? icon
              : Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
              child: text != ''
                  ? Text(text, overflow: TextOverflow.fade)
                  : content),
          actions: [
            Container(
              width: MediaQuery.of(context).size.width * .94,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons!,
              ),
            )
          ],
        ),
      );
    },
  );
}

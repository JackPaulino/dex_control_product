import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    Appformat.quantity.minimumFractionDigits = 2;

    double value = double.parse(newValue.text);
    String newText = Appformat.quantity.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

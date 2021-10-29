import 'package:flutter/services.dart';

class DefaultTextInputJsonFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(newValue.text)) {
      return oldValue;
    }

    return newValue.copyWith(
        text: newValue.text, selection: updateCursorPosition(newValue.text));
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

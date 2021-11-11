import 'package:flutter/services.dart';

class DefaultTextInputJsonFormatter extends TextInputFormatter {
  final String? pattern;
  DefaultTextInputJsonFormatter({this.pattern});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    if (pattern == null) {
      if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(newValue.text)) {
        return oldValue;
      }
    } else {
      if (!RegExp('$pattern').hasMatch(newValue.text)) {
        return oldValue;
      }
    }

    return newValue.copyWith(
        text: newValue.text, selection: updateCursorPosition(newValue.text));
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

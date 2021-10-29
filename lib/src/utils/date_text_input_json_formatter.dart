import 'package:flutter/services.dart';

class DateTextInputJsonFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    if (newValue.text.length > 10) {
      return oldValue;
    }

    var dateText = _addSeperators(newValue.text, '-');

    if (dateText.length == 1) {
      if (!RegExp(r'([0-3])$').hasMatch(dateText)) {
        return oldValue;
      }
    }
    if (dateText.length == 2) {
      print(dateText[1]);
      if (!RegExp(r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])$').hasMatch(dateText)) {
        return oldValue;
      }
    }

    if (dateText.length == 4) {
      if (!RegExp(r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-([0-1])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }

    if (dateText.length == 5) {
      if (!RegExp(r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }
    if (dateText.length == 7) {
      if (!RegExp(r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])-([1-2])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }

    if (dateText.length == 8) {
      if (!RegExp(
              r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])-(1[9]|2[0|9])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }

    if (dateText.length == 9) {
      if (!RegExp(
              r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])-(19[89]|20[0-3])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }

    if (dateText.length == 10) {
      if (!RegExp(
              r'(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])-(19[89][0-9]|20[0-3][0-9])$')
          .hasMatch(dateText)) {
        return oldValue;
      }
    }

    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('-', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

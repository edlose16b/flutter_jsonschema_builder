import 'package:flutter/services.dart';

class EmailTextInputJsonFormatter extends TextInputFormatter {
  var _index = 0;
  //var _shouldDotOnce = false;
  static const String _atomCharacters = "!#\$%&'*+-/=?^_`{|}~";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    if (newValue.text.length >= 255) {
      return oldValue;
    }
    if (_atomCharacters.contains(newValue.text)) {
      return oldValue;
    }

    if (!_isAtom(newValue.text[_index])) {
      if (newValue.text.codeUnitAt(_index) == 64) {
        //_shouldDotOnce = true;
        if (RegExp(r'(\@).*\1').hasMatch(newValue.text)) {
          return oldValue;
        }
      }
    }
    _index++;

    return newValue.copyWith(
        text: newValue.text, selection: updateCursorPosition(newValue.text));
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  bool _isAtom(String c) {
    return _isLetterOrDigit(c);
  }

  bool _isLetterOrDigit(String c) {
    return _isLetter(c) || _isDigit(c);
  }

  static bool _isDigit(String c) {
    return c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  }

  static bool _isLetter(String c) {
    return (c.codeUnitAt(0) >= 65 && c.codeUnitAt(0) <= 90) ||
        (c.codeUnitAt(0) >= 97 && c.codeUnitAt(0) <= 122);
  }
}

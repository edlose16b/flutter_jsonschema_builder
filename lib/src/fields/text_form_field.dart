import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jsonschema_form/src/utils/input_validation_json_schema.dart';

import '../utils/utils.dart';
import '../models/models.dart';

class TextJFormField extends StatefulWidget {
  const TextJFormField(
      {Key? key, required this.property, required this.onSaved})
      : super(key: key);

  final SchemaProperty property;
  final void Function(String?) onSaved;
  @override
  _TextJFormFieldState createState() => _TextJFormFieldState();
}

class _TextJFormFieldState extends State<TextJFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: (widget.property.autoFocus ?? false),
      keyboardType: getTextInputTypeFromFormat(widget.property.format),
      maxLines: widget.property.widget == "textarea" ? null : 1,
      obscureText: widget.property.format == PropertyFormat.password,
      initialValue: widget.property.defaultValue ?? '',
      onSaved: widget.onSaved,
      maxLength: widget.property.maxLength,
      inputFormatters: [textInputCustomFormatter(widget.property.format)],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {},
      validator: (String? value) {
        if (value != null) {
          return inputValidationJsonSchema(
              newValue: value, property: widget.property);
        }
      },
      decoration: InputDecoration(
        labelText: widget.property.required
            ? widget.property.title + ' *'
            : widget.property.title,
        helperText: widget.property.help,
      ),
    );
  }

  TextInputType getTextInputTypeFromFormat(PropertyFormat format) {
    late TextInputType textInputType;

    switch (format) {
      case PropertyFormat.general:
        textInputType = TextInputType.text;
        break;
      case PropertyFormat.password:
        textInputType = TextInputType.visiblePassword;
        break;
      case PropertyFormat.date:
        textInputType = TextInputType.datetime;
        break;
      case PropertyFormat.datetime:
        textInputType = TextInputType.datetime;
        break;
      case PropertyFormat.email:
        textInputType = TextInputType.emailAddress;
        break;
      case PropertyFormat.dataurl:
        textInputType = TextInputType.text;
        break;
      case PropertyFormat.uri:
        textInputType = TextInputType.url;
        break;
    }

    return textInputType;
  }

  TextInputFormatter textInputCustomFormatter(PropertyFormat format) {
    late TextInputFormatter textInputFormatter;
    switch (format) {
      case PropertyFormat.email:
        textInputFormatter = EmailTextInputJsonFormatter();
        break;
      default:
        textInputFormatter =
            DefaultTextInputJsonFormatter(pattern: widget.property.pattern);
        break;
    }
    return textInputFormatter;
  }
}

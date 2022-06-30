import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/utils/input_validation_json_schema.dart';

import '../utils/utils.dart';
import '../models/models.dart';

class TextJFormField extends PropertyFieldWidget<String> {
  const TextJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<String?> onSaved,
    required final ValueChanged<String?> onChanged,
    String? Function(dynamic)? customValidator,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
          customValidator: customValidator,
        );

  @override
  _TextJFormFieldState createState() => _TextJFormFieldState();
}

class _TextJFormFieldState extends State<TextJFormField> {
  Timer? _timer;

  @override
  void initState() {
    widget.triggetDefaultValue();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.property.title} ${widget.property.required ? "*" : ""}',
            style: WidgetBuilderInherited.of(context).uiConfig.fieldTitle),
        AbsorbPointer(
          absorbing: widget.property.disabled ?? false,
          child: TextFormField(
            key: Key(widget.property.idKey),
            autofocus: (widget.property.autoFocus ?? false),
            keyboardType: getTextInputTypeFromFormat(widget.property.format),
            maxLines: widget.property.widget == "textarea" ? null : 1,
            obscureText: widget.property.format == PropertyFormat.password,
            initialValue: widget.property.defaultValue ?? '',
            onSaved: widget.onSaved,
            maxLength: widget.property.maxLength,
            inputFormatters: [textInputCustomFormatter(widget.property.format)],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: widget.property.readOnly,
            onChanged: (value) {
              if (_timer != null && _timer!.isActive) _timer!.cancel();

              _timer = Timer(const Duration(seconds: 1), () {
                if (widget.onChanged != null) widget.onChanged!(value);
              });
            },
            validator: (String? value) {
              if (widget.property.required && value != null) {
                return inputValidationJsonSchema(
                    newValue: value, property: widget.property);
              }

              if (widget.customValidator != null)
                return widget.customValidator!(value);

              return null;
            },
            style: widget.property.readOnly
                ? const TextStyle(color: Colors.grey)
                : WidgetBuilderInherited.of(context).uiConfig.label,
            decoration: InputDecoration(
              helperText: widget.property.help != null &&
                      widget.property.help!.isNotEmpty
                  ? widget.property.help
                  : null,
              labelStyle: const TextStyle(color: Colors.blue),
              errorStyle: WidgetBuilderInherited.of(context).uiConfig.error,
            ),
          ),
        ),
      ],
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

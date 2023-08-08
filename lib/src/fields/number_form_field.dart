import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';
import '../models/models.dart';

class NumberJFormField extends PropertyFieldWidget<String?> {
  const NumberJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<String?> onSaved,
    ValueChanged<String?>? onChanged,
    final String? Function(dynamic)? customValidator,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
          customValidator: customValidator,
        );

  @override
  _NumberJFormFieldState createState() => _NumberJFormFieldState();
}

class _NumberJFormFieldState extends State<NumberJFormField> {
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
    final uiConfig = WidgetBuilderInherited.of(context).uiConfig;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.property.title} ${widget.property.required ? "*" : ""}',
          style: uiConfig.fieldTitle,
        ),
        TextFormField(
          key: Key(widget.property.idKey),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
          ],
          autofocus: false,
          onSaved: widget.onSaved,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: widget.property.readOnly,
          onChanged: (value) {
            if (_timer != null && _timer!.isActive) _timer!.cancel();

            _timer = Timer(const Duration(seconds: 1), () {
              if (widget.onChanged != null) widget.onChanged!(value);
            });
          },
          style: widget.property.readOnly
              ? const TextStyle(color: Colors.grey)
              : WidgetBuilderInherited.of(context).uiConfig.label,
          validator: (String? value) {
            if (widget.property.required && value != null && value.isEmpty) {
              return uiConfig.requiredText ?? 'Required';
            }
            if (widget.property.minLength != null &&
                value != null &&
                value.isNotEmpty &&
                value.length <= widget.property.minLength!) {
              return 'should NOT be shorter than ${widget.property.minLength} characters';
            }

            if (widget.customValidator != null)
              return widget.customValidator!(value);
            return null;
          },
          decoration: InputDecoration(
            helperText:
                widget.property.help != null && widget.property.help!.isNotEmpty
                    ? widget.property.help
                    : null,
            errorStyle: WidgetBuilderInherited.of(context).uiConfig.error,
          ),
        ),
      ],
    );
  }

  String get decorationLabelText =>
      '${widget.property.title} ${widget.property.required ? "*" : ""} ${widget.property.description ?? ""}';
}

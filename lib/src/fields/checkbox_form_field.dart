import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import '../models/models.dart';

class CheckboxJFormField extends PropertyFieldWidget<bool> {
  const CheckboxJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<bool?> onSaved,
    ValueChanged<bool>? onChanged,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

  @override
  _CheckboxJFormFieldState createState() => _CheckboxJFormFieldState();
}

class _CheckboxJFormFieldState extends State<CheckboxJFormField> {
  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: (widget.property.defaultValue is String)
          ? widget.property.defaultValue.toLowerCase() == 'true'
          : widget.property.defaultValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.property.required) {
          if (value != null && !value) {
            return "Required";
          }
        }
        return null;
      },
      onSaved: (newValue) {
        widget.onSaved(newValue);
      },
      builder: (field) {
        return CheckboxListTile(
          value: field.value,
          title: Text(widget.property.title),
          subtitle: (widget.property.required)
              ? const Text(
                  'Required',
                  style: TextStyle(color: Color(0xFFd32f2f)),
                )
              : null,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            field.didChange(value);
            if (widget.onChanged != null && value != null) {
              widget.onChanged!(value);
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../models/models.dart';

class CheckboxJFormField extends StatefulWidget {
  const CheckboxJFormField({
    Key? key,
    required this.property,
    required this.onSaved,
  }) : super(key: key);

  final SchemaProperty property;
  final void Function(bool?)? onSaved;

  @override
  _CheckboxJFormFieldState createState() => _CheckboxJFormFieldState();
}

class _CheckboxJFormFieldState extends State<CheckboxJFormField> {
  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: widget.property.defaultValue ?? false,
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
        widget.onSaved!(newValue);
      },
      builder: (field) {
        return CheckboxListTile(
          value: field.value,
          title: Text(widget.property.title),
          subtitle: const Text(
            'Required',
            style: TextStyle(color: Color(0xFFd32f2f)),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            field.didChange(value);
          },
        );
      },
    );
  }
}

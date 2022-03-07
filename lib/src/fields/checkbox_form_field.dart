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
  void initState() {
    widget.triggetDefaultValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      key: Key(widget.property.idKey),
      initialValue: widget.property.defaultValue ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (newValue) {
        widget.onSaved(newValue);
      },
      builder: (field) {
        print(field.value);
        return CheckboxListTile(
          value: (field.value == null) ? false : field.value,
          title: Text(widget.property.title),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: widget.property.readOnly
              ? null
              : (bool? value) {
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

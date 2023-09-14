import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/field_header_widget.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';
import 'package:flutter_jsonschema_builder/src/fields/shared.dart';
import '../models/models.dart';

class CheckboxJFormField extends PropertyFieldWidget<bool> {
  const CheckboxJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<bool?> onSaved,
    ValueChanged<bool?>? onChanged,
    final String? Function(dynamic)? customValidator,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
          customValidator: customValidator,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldHeader(property: widget.property),
        FormField<bool>(
          key: Key(widget.property.idKey),
          initialValue: widget.property.defaultValue ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (newValue) {
            widget.onSaved(newValue);
          },
          validator: (value) {
            if (widget.customValidator != null)
              return widget.customValidator!(value);

            return null;
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  value: (field.value == null) ? false : field.value,
                  title: Text(
                    widget.property.title,
                    style: widget.property.readOnly
                        ? Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.grey)
                        : Theme.of(context).textTheme.titleMedium,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: widget.property.readOnly
                      ? null
                      : (bool? value) {
                          field.didChange(value);
                          if (widget.onChanged != null && value != null) {
                            widget.onChanged!(value);
                          }
                        },
                ),
                if (field.hasError) CustomErrorText(text: field.errorText!),
              ],
            );
          },
        ),
      ],
    );
  }
}

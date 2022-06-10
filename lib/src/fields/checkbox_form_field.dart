import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import '../models/models.dart';

class CheckboxJFormField extends PropertyFieldWidget<bool> {
  const CheckboxJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<bool?> onSaved,
    ValueChanged<bool?>? onChanged,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.property.title} ${widget.property.required ? "*" : ""}',
            style:
                WidgetBuilderInherited.of(context).uiConfig.fieldTitle),
        FormField<bool>(
          key: Key(widget.property.idKey),
          initialValue: widget.property.defaultValue ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (newValue) {
            widget.onSaved(newValue);
          },
          builder: (field) {
            return CheckboxListTile(
              value: (field.value == null) ? false : field.value,
              title: Text(
                widget.property.title,
                style: widget.property.readOnly
                    ? const TextStyle(color: Colors.grey)
                    : WidgetBuilderInherited.of(context)
                        .uiConfig
                        .label,
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
            );
          },
        ),
      ],
    );
  }
}

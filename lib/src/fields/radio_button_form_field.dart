import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import '../models/models.dart';

class RadioButtonJFormField extends PropertyFieldWidget<int> {
  const RadioButtonJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<int?> onSaved,
    ValueChanged<int>? onChanged,
  }) : super(
            key: key,
            property: property,
            onSaved: onSaved,
            onChanged: onChanged);

  @override
  _RadioButtonJFormFieldState createState() => _RadioButtonJFormFieldState();
}

class _RadioButtonJFormFieldState extends State<RadioButtonJFormField> {
  bool booleanValue = false;

  int? groupValue;

  @override
  void initState() {
    print(widget.property.defaultValue);
    groupValue = (widget.property.defaultValue ?? false) ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.property.enumm != null, 'enum is required');
    assert(() {
      if (widget.property.enumNames != null) {
        return widget.property.enumNames!.length ==
            widget.property.enumm!.length;
      }
      return true;
    }(), '[enumNames] and [enum]  must be the same size ');

    inspect(widget.property);
    return FormField<int>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: groupValue,
      onSaved: (newValue) {
        widget.onSaved(newValue);
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.property.required
                  ? widget.property.title + ' *'
                  : widget.property.title,
              style: Theme.of(context).textTheme.caption,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Widget>.generate(
                  widget.property.enumNames?.length ?? 0,
                  (int i) => RadioListTile(
                        value: i,
                        title: Text(widget.property.enumNames?[i]),
                        groupValue: groupValue,
                        onChanged: widget.property.readOnly
                            ? null
                            : (dynamic value) {
                                print(value);
                                groupValue = value;
                                if (value != null) {
                                  field.didChange(groupValue);
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(groupValue!);
                                  }
                                }
                              },
                      )),
            ),
          ],
        );
      },
    );
  }
}

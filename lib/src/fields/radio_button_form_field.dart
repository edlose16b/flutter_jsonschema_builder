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
    groupValue = ((widget.property.defaultValue is String)
            ? widget.property.defaultValue.toLowerCase() == 'true'
            : widget.property.defaultValue)
        ? 0
        : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Text(widget.property.title),
            Row(
              children: List<Widget>.generate(
                  widget.property.enumNames?.length ?? 0,
                  (int i) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: i,
                            activeColor: Colors.blue,
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
                          ),
                          Text(widget.property.enumNames?[i]),
                        ],
                      )),
            ),
          ],
        );
      },
    );
  }
}

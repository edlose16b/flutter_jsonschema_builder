import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:intl/intl.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import '../models/models.dart';
import '..//utils/date_text_input_json_formatter.dart';

class DateJFormField extends PropertyFieldWidget<DateTime> {
  const DateJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<DateTime?> onSaved,
    ValueChanged<DateTime>? onChanged,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

  @override
  _DateJFormFieldState createState() => _DateJFormFieldState();
}

class _DateJFormFieldState extends State<DateJFormField> {
  final txtDateCtrl = MaskedTextController(mask: '00-00-0000');
  final formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: txtDateCtrl,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (widget.property.required && (value == null || value.isEmpty)) {
              return 'Required';
            }
          },
          inputFormatters: [DateTextInputJsonFormatter()],
          decoration: InputDecoration(
            hintText: 'DD-MM-YYYY',
            labelText: widget.property.required
                ? widget.property.title + ' *'
                : widget.property.title,
            helperText: widget.property.help,
            suffixIcon: IconButton(
              icon: const Icon(Icons.date_range_outlined),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1998),
                  lastDate: DateTime.now(),
                );
                if (date != null) txtDateCtrl.text = formatter.format(date);

                widget.onSaved(date);
              },
            ),
          ),
          // onChanged: (value) {
          // TODO: Transformar string to date
          //   widget.onChanged(value);
          // },
        ),
        
      ],
    );
  }
}

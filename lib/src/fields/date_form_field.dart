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
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.property.defaultValue != null)
        txtDateCtrl.updateText(widget.property.defaultValue);
    });

    widget.triggetDefaultValue();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.property.title} ${widget.property.required ? "*" : ""}',
            style: Theme.of(context).textTheme.bodyText1),
        TextFormField(
          key: Key(widget.property.idKey),
          controller: txtDateCtrl,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (widget.property.required && (value == null || value.isEmpty)) {
              return 'Required';
            }
          },
          inputFormatters: [DateTextInputJsonFormatter()],
          readOnly: widget.property.readOnly,
          style: widget.property.readOnly
              ? const TextStyle(color: Colors.grey)
              : null,
          decoration: InputDecoration(
            hintText: 'DD-MM-YYYY',
            helperText:
                widget.property.help != null && widget.property.help!.isNotEmpty
                    ? widget.property.help
                    : null,
            suffixIcon: IconButton(
              icon: const Icon(Icons.date_range_outlined),
              onPressed: widget.property.readOnly
                  ? null
                  : () async {
                      final tempDate = widget.property.defaultValue != null
                          ? formatter.parse(txtDateCtrl.text)
                          : DateTime.now();

                      final date = await showDatePicker(
                        context: context,
                        initialDate: tempDate,
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );
                      if (date != null)
                        txtDateCtrl.text = formatter.format(date);

                      widget.onSaved(date);
                    },
            ),
          ),
          onSaved: (value) {
            if (widget.onSaved != null && value != null)
              widget.onSaved(formatter.parse(value));
          },
          onChanged: (value) {
            if (widget.onChanged != null)
              widget.onChanged!(formatter.parse(value));
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
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
  final txtDateCtrl = MaskedTextController(mask: '0000-00-00');
  final formatter = DateFormat('yyyy-MM-dd');

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
        Text(
          '${widget.property.title} ${widget.property.required ? "*" : ""}',
          style: WidgetBuilderInherited.of(context)
              .jsonFormSchemaUiConfig
              .fieldTitle,
        ),
        TextFormField(
          key: Key(widget.property.idKey),
          controller: txtDateCtrl,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (widget.property.required && (value == null || value.isEmpty)) {
              return 'Required';
            }
            return null;
          },
          // inputFormatters: [DateTextInputJsonFormatter()],
          readOnly: widget.property.readOnly,
          style: widget.property.readOnly
              ? const TextStyle(color: Colors.grey)
              : WidgetBuilderInherited.of(context).jsonFormSchemaUiConfig.label,
          decoration: InputDecoration(
              hintText: 'YYYY-MM-DD',
              helperText: widget.property.help != null &&
                      widget.property.help!.isNotEmpty
                  ? widget.property.help
                  : null,
              suffixIcon: IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: widget.property.readOnly ? null : _onPressed,
              ),
              errorStyle: WidgetBuilderInherited.of(context)
                  .jsonFormSchemaUiConfig
                  .error),
          onSaved: (value) {
            if (value != null) widget.onSaved(formatter.parse(value));
          },
          onChanged: (value) {
            try {
              if (widget.onChanged != null && DateTime.tryParse(value) != null)
                widget.onChanged!(formatter.parse(value));
            } catch (e) {
              return;
            }
          },
        ),
      ],
    );
  }

  void _onPressed() async {
    final tempDate = widget.property.defaultValue != null
        ? formatter.parse(txtDateCtrl.text)
        : DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: tempDate,
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (date != null) txtDateCtrl.text = formatter.format(date);

    widget.onSaved(date);
  }
}

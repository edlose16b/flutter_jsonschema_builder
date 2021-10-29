import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';

class NumberJFormField extends StatefulWidget {
  const NumberJFormField(
      {Key? key, required this.property, required this.onSaved})
      : super(key: key);

  final SchemaProperty property;
  final void Function(String?)? onSaved;

  @override
  _NumberJFormFieldState createState() => _NumberJFormFieldState();
}

class _NumberJFormFieldState extends State<NumberJFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
      ],
      autofocus: false,
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (widget.property.required && value != null && value.isEmpty) {
          return 'Required';
        }
        if (widget.property.minLength != null &&
            value != null &&
            value.isNotEmpty &&
            value.length <= widget.property.minLength!) {
          return 'should NOT be shorter than ${widget.property.minLength} characters';
        }
        return null;
      },
      decoration: InputDecoration(labelText: decorationLabelText),
    );
  }

  String get decorationLabelText =>
      '${widget.property.title} ${widget.property.required ? "*" : ""} ${widget.property.description ?? ""}';
}

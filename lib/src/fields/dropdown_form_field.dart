import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import '../models/models.dart';

class DropDownJFormField extends PropertyFieldWidget<dynamic> {
  const DropDownJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

  @override
  _DropDownJFormFieldState createState() => _DropDownJFormFieldState();
}

class _DropDownJFormFieldState extends State<DropDownJFormField> {
  @override
  void initState() {
    // fill enum property
    if (widget.property.enumm == null) {
      switch (widget.property.type) {
        case SchemaType.boolean:
          widget.property.enumm = [true, false];
          break;
        default:
          widget.property.enumm =
              widget.property.enumNames?.map((e) => e.toString()).toList() ??
                  [];
      }
    }

    widget.triggetDefaultValue();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.property.title} ${widget.property.required ? "*" : ""}',
            style: Theme.of(context).textTheme.bodyText1),
        DropdownButtonFormField<dynamic>(
          key: Key(widget.property.idKey),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: const Text('Seleccione'),
          isExpanded: false,
          validator: (value) {
            if (widget.property.required && value == null) {
              return 'required';
            }
            return null;
          },
          items: _buildItems(),
          value: widget.property.defaultValue,
          onChanged: widget.property.readOnly
              ? null
              : (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                },
          onSaved: widget.onSaved,
        ),
      ],
    );
  }

  List<DropdownMenuItem> _buildItems() {
    final w = <DropdownMenuItem>[];
    for (var i = 0; i < widget.property.enumm!.length; i++) {
      final value = widget.property.enumm![i];
      final text = widget.property.enumNames?[i] ?? value;
      w.add(
        DropdownMenuItem(
          child: Text(text.toString()),
          value: value,
        ),
      );
    }
    return w;
  }
}

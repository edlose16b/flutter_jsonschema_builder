import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/field_header_widget.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';
import '../models/models.dart';

class DropDownJFormField extends PropertyFieldWidget<dynamic> {
  const DropDownJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
    this.customPickerHandler,
    final String? Function(dynamic)? customValidator,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
          customValidator: customValidator,
        );

  final Future<dynamic> Function(SchemaProperty)? customPickerHandler;
  @override
  _DropDownJFormFieldState createState() => _DropDownJFormFieldState();
}

class _DropDownJFormFieldState extends State<DropDownJFormField> {
  dynamic value;
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

    value = widget.property.defaultValue;
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

    final uiConfig = WidgetBuilderInherited.of(context).uiConfig;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldHeader(property: widget.property),
        GestureDetector(
          onTap: _onTap,
          child: AbsorbPointer(
            absorbing: widget.customPickerHandler != null,
            child: DropdownButtonFormField<dynamic>(
              key: Key(widget.property.idKey),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hint: Text(
                uiConfig.selectionTitle ?? 'Select',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              isExpanded: false,
              validator: (value) {
                if (widget.property.required && value == null) {
                  return uiConfig.requiredText ?? 'Required';
                }
                if (widget.customValidator != null)
                  return widget.customValidator!(value);
                return null;
              },
              items: _buildItems(),
              value: value,
              onChanged: _onChanged,
              onSaved: widget.onSaved,
              style: widget.property.readOnly
                  ? const TextStyle(color: Colors.grey)
                  : Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTap() async {
    print('ontap');
    if (widget.customPickerHandler == null) return;
    final response = await widget.customPickerHandler!(widget.property);
    if (response != null) _onChanged(response);
  }

  Function(dynamic)? _onChanged(dynamic value) {
    if (widget.property.readOnly) return null;
    return (value) {
      if (widget.onChanged != null) widget.onChanged!(value);
      setState(() {
        this.value = value;
      });
    }(value);
  }

  List<DropdownMenuItem>? _buildItems() {
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

  Map _getItems() {
    var data = {};
    for (var i = 0; i < widget.property.enumm!.length; i++) {
      final value = widget.property.enumm![i];
      final text = widget.property.enumNames?[i] ?? value;
      data[value] = text;
    }

    return data;
  }
}

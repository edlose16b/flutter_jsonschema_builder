import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import '../models/models.dart';

class DropDownJFormField extends PropertyFieldWidget<dynamic> {
  const DropDownJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
    this.customPickerHandler,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

  final Future<dynamic> Function(Map)? customPickerHandler;
  @override
  _DropDownJFormFieldState createState() => _DropDownJFormFieldState();
}

class _DropDownJFormFieldState extends State<DropDownJFormField> {
  var value;
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

    widget.triggetDefaultValue().then((value) {
      setState(() {
        this.value = value;
      });
    });
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
            style: WidgetBuilderInherited.of(context).uiConfig.fieldTitle),
        GestureDetector(
          onTap: _onTap,
          child: AbsorbPointer(
            absorbing: widget.customPickerHandler != null,
            child: DropdownButtonFormField<dynamic>(
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
              value: value,
              onChanged: _onChanged,
              onSaved: widget.onSaved,
              style: widget.property.readOnly
                  ? const TextStyle(color: Colors.grey)
                  : WidgetBuilderInherited.of(context).uiConfig.label,
              decoration: InputDecoration(
                errorStyle: WidgetBuilderInherited.of(context).uiConfig.error,
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
    final response = await widget.customPickerHandler!(_getItems());

    _onChanged(response);
  }

  Function(dynamic)? _onChanged(dynamic value) {
    return widget.property.readOnly
        ? null
        : (value) {
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

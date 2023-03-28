import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';
import 'package:flutter_jsonschema_builder/src/models/one_of_model.dart';
import 'package:flutter_jsonschema_builder/src/models/property_schema.dart';
import 'package:flutter_jsonschema_builder/src/models/schema.dart';

class DropdownOneOfJFormField extends PropertyFieldWidget<dynamic> {
  const DropdownOneOfJFormField({
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

  final Future<dynamic> Function(Map)? customPickerHandler;

  @override
  _SelectedFormFieldState createState() => _SelectedFormFieldState();
}

class _SelectedFormFieldState extends State<DropdownOneOfJFormField> {
  final listOfModel = <OneOfModel>[];
  Map<String, dynamic> indexedData = {};
  OneOfModel? valueSelected;
  List<DropdownMenuItem<OneOfModel>> w = <DropdownMenuItem<OneOfModel>>[];

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

    if (widget.property.oneOf is List) {
      for (int i = 0; i < (widget.property.oneOf?.length ?? 0); i++) {
        final customObject = OneOfModel(
          oneOfModelEnum: widget.property.oneOf![i]['enum'],
          title: widget.property.oneOf![i]['title'],
          type: widget.property.oneOf![i]['type'],
        );

        listOfModel.add(customObject);
      }
    }

    // fill selected value

    try {
      final exists = listOfModel.firstWhere((e) =>
          e.oneOfModelEnum is List &&
          e.oneOfModelEnum!.map((i) => i.toLowerCase()).contains(
                widget.property.defaultValue.toLowerCase(),
              ));

      valueSelected = exists;
    } catch (e) {
      valueSelected = null;
    }

    widget.triggetDefaultValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.property.oneOf != null, 'oneOf is required');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.property.title} ${widget.property.required ? "*" : ""}',
            style: WidgetBuilderInherited.of(context).uiConfig.fieldTitle),
        GestureDetector(
          onTap: _onTap,
          child: AbsorbPointer(
            absorbing: widget.customPickerHandler != null,
            child: DropdownButtonFormField<OneOfModel>(
              key: Key(widget.property.idKey),
              value: valueSelected,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hint: const Text('Seleccione'),
              isExpanded: false,
              validator: (value) {
                if (widget.property.required && value == null) {
                  return 'required';
                }
                if (widget.customValidator != null)
                  return widget.customValidator!(value);
                return null;
              },
              items: _buildItems(),
              onChanged: _onChanged,
              onSaved: widget.onSaved,
              decoration: InputDecoration(
                  errorStyle:
                      WidgetBuilderInherited.of(context).uiConfig.error),
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

    if (response != null) _onChanged(response);
  }

  Function(dynamic)? _onChanged(dynamic value) {
    if (widget.property.readOnly) return null;

    return (OneOfModel? value) {
      setState(() {
        valueSelected = value;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(value?.oneOfModelEnum?.first);
      }
    }(value);
  }

  List<DropdownMenuItem<OneOfModel>>? _buildItems() {
    if (listOfModel.isEmpty) return [];

    return listOfModel
        .map((item) => DropdownMenuItem<OneOfModel>(
              value: item,
              child: Text(
                item.title ?? '',
                style: widget.property.readOnly
                    ? const TextStyle(color: Colors.grey)
                    : WidgetBuilderInherited.of(context).uiConfig.label,
              ),
            ))
        .toList();
  }

  Map _getItems() {
    if (listOfModel.isEmpty) return {};

    var data = {};
    for (final element in listOfModel) {
      data[element] = element.title;
    }

    return data;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/models/one_of_model.dart';
import 'package:flutter_jsonschema_form/src/models/property_schema.dart';
import 'package:flutter_jsonschema_form/src/models/schema.dart';

class SelectedFormField extends PropertyFieldWidget<dynamic> {
  const SelectedFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
    required this.customPickerHandler,
  }) : super(
            key: key,
            property: property,
            onSaved: onSaved,
            onChanged: onChanged);

  final Future<dynamic> Function(Map)? customPickerHandler;

  @override
  _SelectedFormFieldState createState() => _SelectedFormFieldState();
}

class _SelectedFormFieldState extends State<SelectedFormField> {
  final listOfModel = <OneOfModel>[];
  Map<String, dynamic> indexedData = {};
  OneOfModel? valueSelected;
  List<DropdownMenuItem<OneOfModel>> w = <DropdownMenuItem<OneOfModel>>[];
  late OneOfModel customObject;

  final pageController = PageController(initialPage: 1, viewportFraction: 0.77);

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
        customObject = OneOfModel(
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
          e.oneOfModelEnum!.map((e) => e.toLowerCase()).contains(
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
        DropdownButtonFormField<OneOfModel>(
          key: Key(widget.property.idKey),
          value: valueSelected,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: const Text('Seleccione'),
          isExpanded: true,
          validator: (value) {
            if (widget.property.required && value == null) {
              return 'required';
            }
          },
          items: (listOfModel != [] || listOfModel.isNotEmpty)
              ? listOfModel
                  .map((item) {
                    return DropdownMenuItem<OneOfModel>(
                      value: item,
                      child: Text(
                        item.title ?? '',
                        style: widget.property.readOnly
                            ? const TextStyle(color: Colors.grey)
                            : WidgetBuilderInherited.of(context).uiConfig.label,
                      ),
                    );
                  })
                  .toSet()
                  .toList()
              : [],
          onChanged: widget.property.readOnly
              ? null
              : (OneOfModel? value) {
                  valueSelected = value;
                  if (widget.onChanged != null) {
                    widget.onChanged!(value?.oneOfModelEnum?.first);
                  }
                },
          onSaved: widget.onSaved,
          decoration: InputDecoration(
              errorStyle: WidgetBuilderInherited.of(context).uiConfig.error),
        ),
      ],
    );
  }
}

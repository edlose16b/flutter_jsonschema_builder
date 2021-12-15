import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/models/one_of_model.dart';
import 'package:flutter_jsonschema_form/src/models/property_schema.dart';

class SelectedFormField extends PropertyFieldWidget<dynamic> {
  const SelectedFormField({
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
  _SelectedFormFieldState createState() => _SelectedFormFieldState();
}

class _SelectedFormFieldState extends State<SelectedFormField> {
  late final listOfModel = <OneOfModel>[];
  Map<String, dynamic> indexedData = {};

  @override
  Widget build(BuildContext context) {
    assert(widget.property.oneOf != null, 'oneOf is required');
    assert(
      () {
        return true;
      }(),
    );
    late OneOfModel customObject;
    if (widget.property.oneOf is List) {
      for (int i = 0; i < (widget.property.oneOf?.length ?? 0); i++) {
        if (widget.property.id == 'profession') {
          final titleList = [];
          final enumString = widget.property.oneOf![i]['enum'].first;
          titleList.add(widget.property.oneOf![i]['title']);
          customObject = OneOfModel(
              oneOfModelEnum: titleList,
              title: enumString,
              type: widget.property.oneOf![i]['type']);
        } else {
          customObject = OneOfModel(
              oneOfModelEnum: widget.property.oneOf![i]['enum'],
              title: widget.property.oneOf![i]['title'],
              type: widget.property.oneOf![i]['type']);
        }
        listOfModel.add(customObject);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.property.required
              ? widget.property.title + ' *'
              : widget.property.title,
          style: Theme.of(context).textTheme.caption,
        ),
        DropdownButtonFormField<dynamic>(
          value: widget.property.defaultValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: const Text('Seleccione'),
          isExpanded: true,
          validator: (value) {
            if (widget.property.required && value == null) {
              return 'required';
            }
          },
          items: _buildItems(),
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          onSaved: widget.onSaved,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  List<DropdownMenuItem> _buildItems() {
    final w = <DropdownMenuItem>[];
    for (var i = 0; i < listOfModel.length; i++) {
      final value = listOfModel[i].oneOfModelEnum?.first;
      final text = listOfModel[i].title;
      w.add(
        DropdownMenuItem(
          child: Text(
            text.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          value: value,
        ),
      );
    }
    return w;
  }
}

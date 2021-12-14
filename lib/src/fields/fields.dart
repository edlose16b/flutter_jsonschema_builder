export 'checkbox_form_field.dart';
export 'date_form_field.dart';
export 'dropdown_form_field.dart';
export 'file_form_field.dart';
export 'number_form_field.dart';
export 'text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/models/property_schema.dart';

abstract class PropertyFieldWidget<T> extends StatefulWidget {
  const PropertyFieldWidget({
    Key? key,
    required this.property,
    required this.onSaved,
    required this.onChanged,
  }) : super(key: key);

  final SchemaProperty property;
  final ValueSetter<T?> onSaved;
  final ValueChanged<T>? onChanged;

  @override
  State createState();
}

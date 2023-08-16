import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/flutter_jsonschema_builder.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';

class FieldHeader extends StatelessWidget {
  const FieldHeader({required this.property, Key? key}) : super(key: key);
  final SchemaProperty property;
  @override
  Widget build(BuildContext context) {
    final description = property.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${property.title} ${property.required ? "*" : ""}',
          style: WidgetBuilderInherited.of(context).uiConfig.fieldTitle,
        ),
        if (description != null && description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            description,
            style: WidgetBuilderInherited.of(context).uiConfig.fieldDescription,
          ),
        ]
      ],
    );
  }
}

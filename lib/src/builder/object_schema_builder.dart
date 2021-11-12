import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_form/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ObjectSchemaBuilder extends StatelessWidget {
  const ObjectSchemaBuilder({
    Key? key,
    required this.mainSchema,
    required this.schemaObject,
  }) : super(key: key);

  final Schema mainSchema;
  final SchemaObject schemaObject;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralSubtitle(
          title: schemaObject.title,
          description: schemaObject.description,
          mainSchemaTitle: mainSchema.title,
          nainSchemaDescription: mainSchema.description,
        ),
        if (schemaObject.properties != null)
          ...schemaObject.properties!
              .map((e) =>
                  FormFromSchemaBuilder(mainSchema: mainSchema, schema: e))
              .toList(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_form/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ObjectSchemaBuilder extends StatelessWidget {
  const ObjectSchemaBuilder({
    Key? key,
    this.id,
    required this.mainSchema,
    required this.schemaObject,
  }) : super(key: key);
  final String? id;
  final Schema mainSchema;
  final SchemaObject schemaObject;
  @override
  Widget build(BuildContext context) {
    print(schemaObject.dependencies);
    print(schemaObject.properties);
    int ttt = 0;
    if (schemaObject != null) {
      schemaObject.dependencies?.forEach((key, value) {
        schemaObject.properties?.forEach((element) {
          if (key == element.id) {
            schemaObject.required.addAll(value);
            schemaObject.copyWith(id: element.id);
            print(schemaObject.required);
            print(++ttt);
            print(value.first);
          }
        });
      });
    }

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
          ...schemaObject.properties!.map((e) {
            return FormFromSchemaBuilder(
              mainSchema: mainSchema,
              schema: e,
              id: e.id,
            );
          }).toList(),
      ],
    );
  }

  void prueba1(String value, SchemaProperty schemaProperty) {}
}

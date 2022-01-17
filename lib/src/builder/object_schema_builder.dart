import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/object_schema_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ObjectSchemaBuilder extends StatefulWidget {
  ObjectSchemaBuilder({
    Key? key,
    required this.mainSchema,
    required this.schemaObject,
  }) : super(key: key);

  final Schema mainSchema;
  SchemaObject schemaObject;

  @override
  State<ObjectSchemaBuilder> createState() => _ObjectSchemaBuilderState();
}

class _ObjectSchemaBuilderState extends State<ObjectSchemaBuilder> {
  @override
  Widget build(BuildContext context) {
    return ObjectSchemaInherited(
      schemaObject: widget.schemaObject,
      listen: (value) {
        if (value is ObjectSchemaDependencyEvent) {
          setState(() => widget.schemaObject = value.schemaObject);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralSubtitle(
            title: widget.schemaObject.title,
            description: widget.schemaObject.description,
            mainSchemaTitle: widget.mainSchema.title,
            nainSchemaDescription: widget.mainSchema.description,
          ),
          if (widget.schemaObject.properties != null)
            ...widget.schemaObject.properties!
                .map((e) => FormFromSchemaBuilder(
                    schemaObject: widget.schemaObject,
                    mainSchema: widget.mainSchema, schema: e))
                .toList(),
        ],
      ),
    );
  }
}

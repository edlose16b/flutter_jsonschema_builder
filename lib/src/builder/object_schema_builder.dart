import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/object_schema_logic.dart';
import 'package:flutter_jsonschema_builder/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_builder/src/models/models.dart';

class ObjectSchemaBuilder extends StatefulWidget {
  const ObjectSchemaBuilder({
    Key? key,
    required this.mainSchema,
    required this.schemaObject,
    this.showDebugElements = true,
  }) : super(key: key);

  final Schema mainSchema;
  final SchemaObject schemaObject;
  final bool showDebugElements;

  @override
  State<ObjectSchemaBuilder> createState() => _ObjectSchemaBuilderState();
}

class _ObjectSchemaBuilderState extends State<ObjectSchemaBuilder> {
  late SchemaObject _schemaObject;

  @override
  void initState() {
    super.initState();
    _schemaObject = widget.schemaObject;
  }

  @override
  Widget build(BuildContext context) {
    return ObjectSchemaInherited(
      schemaObject: _schemaObject,
      listen: (value) {
        if (value is ObjectSchemaDependencyEvent) {
          setState(() => _schemaObject = value.schemaObject);
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
                    mainSchema: widget.mainSchema,
                    showDebugElements: widget.showDebugElements,
                    schema: e))
                .toList(),
        ],
      ),
    );
  }
}

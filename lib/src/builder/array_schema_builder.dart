import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';
import 'package:flutter_jsonschema_form/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ArraySchemaBuilder extends StatefulWidget {
  const ArraySchemaBuilder(
      {Key? key, required this.mainSchema, required this.schemaArray})
      : super(key: key);
  final Schema mainSchema;
  final SchemaArray schemaArray;

  @override
  State<ArraySchemaBuilder> createState() => _ArraySchemaBuilderState();
}

class _ArraySchemaBuilderState extends State<ArraySchemaBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget widgetBuilder;
    widgetBuilder = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralSubtitle(
          title: widget.schemaArray.title,
          description: widget.schemaArray.description,
          mainSchemaTitle: widget.mainSchema.title,
          nainSchemaDescription: widget.mainSchema.description,
        ),
        ...widget.schemaArray.items.map((schemaLoop) {
          final index = widget.schemaArray.items.indexOf(schemaLoop);
          return Column(
            children: [
              if (index >= 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.schemaArray.items.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text('Eliminar item'),
                  ),
                ),
              FormFromSchemaBuilder(
                mainSchema: widget.mainSchema,
                schema: schemaLoop,
              ),
              if (widget.schemaArray.items.length > 1) const Divider(),
              const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ],
    );

    return Column(
      children: [
        widgetBuilder,
        if (!widget.schemaArray.isMultipleFile)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                // inspect(schema);
                final newSchemaObject = widget.schemaArray.items.first
                    .copyWith(id: widget.schemaArray.items.length.toString());

                widget.schemaArray.items.add(newSchemaObject);

                inspect(widget.schemaArray);
                setState(() {});
              },
              icon: const Icon(Icons.add),
              label: const Text('Añadir Item'),
            ),
          ),
      ],
    );
  }
}
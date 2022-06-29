import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';
import 'package:flutter_jsonschema_form/src/builder/general_subtitle_widget.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/shared.dart';
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
    final widgetBuilderInherited = WidgetBuilderInherited.of(context);

    widgetBuilder = FormField(
      validator: (_) {
        if (widget.schemaArray.required && widget.schemaArray.items.isEmpty)
          return 'is required';
        return null;
      },
      onSaved: (_) {
        if (widget.schemaArray.items.isEmpty) {
          widgetBuilderInherited.updateObjectData(
              widgetBuilderInherited.data, widget.schemaArray.idKey, []);
        }
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.infinity),
            GeneralSubtitle(
              title: widget.schemaArray.title,
              description: widget.schemaArray.description,
              mainSchemaTitle: widget.mainSchema.title,
              nainSchemaDescription: widget.mainSchema.description,
            ),
            ...widget.schemaArray.items.map((schemaLoop) {
              final index = widget.schemaArray.items.indexOf(schemaLoop);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (index >= 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: widgetBuilderInherited.uiConfig.removeItemBuilder !=
                            null
                        ? widgetBuilderInherited.uiConfig.removeItemBuilder!(
                            () => _removeItem(index), widget.schemaArray.idKey)
                        : TextButton.icon(
                            onPressed: () => _removeItem(index),
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
            if (field.hasError) CustomErrorText(text: field.errorText!),
          ],
        );
      },
    );

    return Column(
      children: [
        widgetBuilder,
        if (!widget.schemaArray.isArrayMultipleFile())
          Align(
            alignment: Alignment.centerRight,
            child: widgetBuilderInherited.uiConfig.addItemBuilder != null
                ? widgetBuilderInherited.uiConfig.addItemBuilder!(
                    _addItem, widget.schemaArray.idKey)
                : TextButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Añadir Item'),
                  ),
          ),
      ],
    );
  }

  void _addItem() {
    if (widget.schemaArray.items.isEmpty) {
      _addFirstItem();
    } else {
      _addItemFromFirstSchema();
    }

    setState(() {});
  }

  void _removeItem(int index) {
    setState(() {
      widget.schemaArray.items.removeAt(index);
    });
  }

  void _addFirstItem() {
    if (widget.schemaArray.itemsBaseSchema is Object) {
      final newSchema = Schema.fromJson(
        widget.schemaArray.itemsBaseSchema,
        id: '0',
        parent: widget.schemaArray,
      );

      widget.schemaArray.items = [newSchema];
    } else {
      widget.schemaArray.items =
          (widget.schemaArray.itemsBaseSchema as List<Map<String, dynamic>>)
              .map((e) => Schema.fromJson(
                    e,
                    id: '0',
                    parent: widget.schemaArray,
                  ))
              .toList();
    }
  }

  void _addItemFromFirstSchema() {
    final newSchemaObject = widget.schemaArray.items.first
        .copyWith(id: widget.schemaArray.items.length.toString());

    widget.schemaArray.items.add(newSchemaObject);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class PropertySchemaBuilder extends StatelessWidget {
  const PropertySchemaBuilder({
    Key? key,
    this.id,
    required this.mainSchema,
    required this.schemaProperty,
  }) : super(key: key);
  final String? id;
  final Schema mainSchema;
  final SchemaProperty schemaProperty;
  @override
  Widget build(BuildContext context) {
    Widget _field = const SizedBox.shrink();

    final widgetBuilderInherited = WidgetBuilderInherited.of(context);
    if (schemaProperty.enumm != null) {
      _field = DropDownJFormField(
        property: schemaProperty,
        onSaved: (val) {
          log('onSaved: DateJFormField  ${schemaProperty.idKey}  : $val');
          widgetBuilderInherited.updateObjectData(
            widgetBuilderInherited.data,
            schemaProperty.idKey,
            val,
          );
        },
      );
    } else {
      switch (schemaProperty.type) {
        case SchemaType.string:
          if (schemaProperty.format == PropertyFormat.date ||
              schemaProperty.format == PropertyFormat.datetime) {
            _field = DateJFormField(
              property: schemaProperty,
              onSaved: (val) {
                log('onSaved: DateJFormField  ${schemaProperty.idKey}  : $val');
                widgetBuilderInherited.updateObjectData(
                  widgetBuilderInherited.data,
                  schemaProperty.idKey,
                  val,
                );
              },
            );
            break;
          }

          if (schemaProperty.format == PropertyFormat.dataurl) {
            _field = FileJFormField(
              property: schemaProperty,
              onSaved: (val) {
                log('onSaved: FileJFormField  ${schemaProperty.idKey}  : $val');
                widgetBuilderInherited.updateObjectData(
                  widgetBuilderInherited.data,
                  schemaProperty.idKey,
                  val,
                );
              },
            );
            break;
          }

          _field = TextJFormField(
              property: schemaProperty,
              id: id,
              onSaved: (val) {
                log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
                widgetBuilderInherited.updateObjectData(
                  widgetBuilderInherited.data,
                  schemaProperty.idKey,
                  val,
                );
              });
          break;
        case SchemaType.integer:
        case SchemaType.number:
          _field = NumberJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: NumberJFormField ${schemaProperty.idKey}  : $val');
              widgetBuilderInherited.updateObjectData(
                widgetBuilderInherited.data,
                schemaProperty.idKey,
                val,
              );
            },
          );
          break;
        case SchemaType.boolean:
          _field = CheckboxJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: CheckboxJFormField ${schemaProperty.idKey}  : $val');
              widgetBuilderInherited.updateObjectData(
                widgetBuilderInherited.data,
                schemaProperty.idKey,
                val,
              );
            },
          );
          break;
        default:
          _field = TextJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
              widgetBuilderInherited.updateObjectData(
                widgetBuilderInherited.data,
                schemaProperty.idKey,
                val,
              );
            },
          );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          schemaProperty.idKey,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        _field,
      ],
    );
  }
}

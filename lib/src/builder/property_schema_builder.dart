import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/object_schema_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class PropertySchemaBuilder extends StatelessWidget {
  PropertySchemaBuilder({
    Key? key,
    required this.mainSchema,
    required this.schemaProperty,
    this.onChangeListen,
  }) : super(key: key);

  final Schema mainSchema;
  final SchemaProperty schemaProperty;
  final ValueChanged<dynamic>? onChangeListen;

  Timer? _timer;
  late WidgetBuilderInherited widgetBuilderInherited;

  @override
  Widget build(BuildContext context) {
    Widget _field = const SizedBox.shrink();

    widgetBuilderInherited = WidgetBuilderInherited.of(context);

    if (schemaProperty.enumm != null) {
      _field = DropDownJFormField(
        property: schemaProperty,
        onSaved: (val) {
          log('onSaved: DateJFormField  ${schemaProperty.idKey}  : $val');
          updateData(context, val);
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
                updateData(context, val);
              },
            );
            break;
          }

          if (schemaProperty.format == PropertyFormat.dataurl) {
            _field = FileJFormField(
              property: schemaProperty,
              onSaved: (val) {
                log('onSaved: FileJFormField  ${schemaProperty.idKey}  : $val');
                updateData(context, val);
              },
            );
            break;
          }

          _field = TextJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
            },
            onChange: (value) {
              print('🦊🦊🦊🦊 value $value');
              listenStringForPropertyDependencies(context, value);
            },
          );
          break;
        case SchemaType.integer:
        case SchemaType.number:
          _field = NumberJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: NumberJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
            },
          );
          break;
        case SchemaType.boolean:
          _field = CheckboxJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: CheckboxJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
            },
          );
          break;
        default:
          _field = TextJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
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

  void updateData(BuildContext context, dynamic val) {
    widgetBuilderInherited.updateObjectData(schemaProperty.idKey, val);
  }

  // @temp Functions
  void listenStringForPropertyDependencies(BuildContext context, String value) {
    if (value.isEmpty) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(value, false, schemaProperty);
    }

    if (value.isNotEmpty) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(value, true, schemaProperty);
    }
  }
}

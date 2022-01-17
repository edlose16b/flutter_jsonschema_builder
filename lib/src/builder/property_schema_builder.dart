import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/object_schema_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/fields/radio_button_form_field.dart';
import 'package:flutter_jsonschema_form/src/fields/selected_form_field.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';
import 'package:flutter_jsonschema_form/src/models/one_of_model.dart';

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
        onChanged: (value) {
          dispatchBooleanEventToParent(context, value != null);
        },
      );
    } else if (schemaProperty.oneOf != null) {
      _field = SelectedFormField(
        property: schemaProperty,
        onSaved: (val) {
          if (val is OneOfModel) {
            log('onSaved: DateJFormField  ${schemaProperty.idKey}  : ${val.oneOfModelEnum?.first}');
            updateData(context, val.oneOfModelEnum?.first);
          }
        },
        onChanged: (value) {
          dispatchSelectedForDropDownEventToParent(context, value);
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
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value != null);
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
              onChanged: (value) {
                //TODO: Cuando es array no obitnee el depents
                dispatchBooleanEventToParent(
                  context,
                  value != null && value.isNotEmpty,
                );
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
            onChanged: (value) {
              print('🦊🦊🦊🦊 value $value');
              dispatchStringEventToParent(context, value);
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
            onChanged: (value) {
              dispatchBooleanEventToParent(
                context,
                value != null && value.isNotEmpty,
              );
            },
          );
          break;
        case SchemaType.boolean:
          print(schemaProperty.enumNames?.length);
          if ((schemaProperty.enumNames?.length ?? 0) > 0) {
            _field = RadioButtonJFormField(
              property: schemaProperty,
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value != null);
              },
              onSaved: (val) {
                log('onSaved: RadioButtonJFormField ${schemaProperty.idKey}  : $val');

                updateData(context, val);
              },
            );
          } else {
            _field = CheckboxJFormField(
              property: schemaProperty,
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value);
              },
              onSaved: (val) {
                log('onSaved: CheckboxJFormField ${schemaProperty.idKey}  : $val');

                updateData(context, val);
              },
            );
          }

          break;
        default:
          _field = TextJFormField(
            property: schemaProperty,
            onSaved: (val) {
              log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
            },
            onChanged: (value) {},
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
  /// Cuando se valida si es string o no
  void dispatchStringEventToParent(BuildContext context, String value) {
    if (value.isEmpty && schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(false, schemaProperty);
    }

    if (value.isNotEmpty && !schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(true, schemaProperty);
    }
  }

  void dispatchSelectedForDropDownEventToParent(
      BuildContext context, String value) {
    /* if (value.isNotEmpty && schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(false, schemaProperty, optionalValue: value);
    } */

    if (value.isNotEmpty || !schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(true, schemaProperty, optionalValue: value);
    }
  }

  /// Cuando se valida si es true o false
  void dispatchBooleanEventToParent(BuildContext context, bool value) {
    if (value != schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(value, schemaProperty);
    }
  }
}

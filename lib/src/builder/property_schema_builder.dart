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
import 'package:intl/intl.dart';

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
  late SchemaProperty schemaPropertySorted;

  @override
  Widget build(BuildContext context) {
    Widget _field = const SizedBox.shrink();

    widgetBuilderInherited = WidgetBuilderInherited.of(context);
    if ((schemaProperty.order?.length ?? 0) > 0) {
      for (var i = 0; i < (schemaProperty.order?.length ?? 0); i++) {
        // print(i);

        if (schemaProperty.order?[i] == schemaProperty.id) {
          schemaPropertySorted = schemaProperty;
        } else {
          schemaPropertySorted = schemaProperty;
        }
      }
    } else {
      schemaPropertySorted = schemaProperty;
    }

    if (schemaProperty.enumm != null) {
      _field = DropDownJFormField(
        property: schemaPropertySorted,
        onSaved: (val) {
          log('onSaved: DropDownJFormField  ${schemaProperty.idKey}  : $val');
          updateData(context, val);
        },
        onChanged: (value) {
          log('dispatch... $value');

          // dispatchBooleanEventToParent(context,false);

          // final setValue =
          //     !((value is String && value.isEmpty) || value == null);
          dispatchSelectedForDropDownEventToParent(context, value,
              id: schemaProperty.id);
        },
      );
    } else if (schemaProperty.oneOf != null) {
      _field = SelectedFormField(
        property: schemaPropertySorted,
        onSaved: (val) {
          if (val is OneOfModel) {
            log('onSaved: SelectedFormField  ${schemaProperty.idKey}  : ${val.oneOfModelEnum?.first}');
            updateData(context, val.oneOfModelEnum?.first);
          }
        },
        onChanged: (value) {
          dispatchSelectedForDropDownEventToParent(context, value,
              id: schemaProperty.id);
        },
      );
    } else {
      switch (schemaProperty.type) {
        case SchemaType.string:
          if (schemaProperty.format == PropertyFormat.date ||
              schemaProperty.format == PropertyFormat.datetime) {
            _field = DateJFormField(
              property: schemaPropertySorted,
              onSaved: (val) {
                if (val == null) return;
                final date = DateFormat('dd-MM-yyyy').format(val);
                log('onSaved: DateJFormField  ${schemaProperty.idKey}  : $date');
                updateData(context, date);
              },
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value != null);
              },
            );
            break;
          }

          if (schemaProperty.format == PropertyFormat.dataurl) {
            _field = FileJFormField(
              property: schemaPropertySorted,
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
            property: schemaPropertySorted,
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
            property: schemaPropertySorted,
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
          if (schemaProperty.widget == 'radio') {
            _field = RadioButtonJFormField(
              property: schemaPropertySorted,
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
              property: schemaPropertySorted,
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
            property: schemaPropertySorted,
            onSaved: (val) {
              log('onSaved: TextJFormField ${schemaProperty.idKey}  : $val');
              updateData(context, val);
            },
            onChanged: (value) {
              print('🦊🦊🦊🦊 value $value');
              dispatchStringEventToParent(context, value);
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
    widgetBuilderInherited.updateObjectData(
        WidgetBuilderInherited.of(context).data, schemaProperty.idKey, val);
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
      BuildContext context, dynamic value,
      {String? id}) {
    if ((value != null && (value is String ? value.isNotEmpty : true)) ||
        !schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context).listenChangeProperty(
          true, schemaProperty,
          optionalValue: value, idOptional: id, mainSchema: mainSchema);
    }
  }

  /// Cuando se valida si es true o false
  void dispatchBooleanEventToParent(BuildContext context, bool value) {
    print('distpached $value');
    if (value != schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(value, schemaProperty);
    }
  }
}

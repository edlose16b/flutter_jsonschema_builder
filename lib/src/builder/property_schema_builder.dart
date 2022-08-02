import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/object_schema_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';
import 'package:flutter_jsonschema_form/src/fields/radio_button_form_field.dart';
import 'package:flutter_jsonschema_form/src/fields/dropdown_oneof_form_field.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';
import 'package:flutter_jsonschema_form/src/models/one_of_model.dart';
import 'package:flutter_jsonschema_form/src/utils/date_text_input_json_formatter.dart';
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

    // sort
    schemaPropertySorted = schemaProperty;

    if (schemaProperty.widget == 'radio') {
      _field = RadioButtonJFormField(
        property: schemaPropertySorted,
        onChanged: (value) {
          dispatchBooleanEventToParent(context, value != null);
          updateData(context, value);
          widgetBuilderInherited.notifyChanges();
        },
        onSaved: (val) {
          log('onSaved: RadioButtonJFormField ${schemaProperty.idKey}  : $val');

          updateData(context, val);
        },
        customValidator: _getCustomValidator(context, schemaProperty.idKey),
      );
    } else if (schemaProperty.enumm != null &&
        (schemaProperty.enumm!.isNotEmpty ||
            (schemaProperty.enumNames != null &&
                schemaProperty.enumNames!.isNotEmpty))) {
      _field = DropDownJFormField(
        property: schemaPropertySorted,
        customPickerHandler: _getCustomPickerHanlder(
          context,
          schemaProperty.id,
        ),
        onSaved: (val) {
          log('onSaved: DropDownJFormField  ${schemaProperty.idKey}  : $val');
          updateData(context, val);
        },
        onChanged: (value) {
          dispatchSelectedForDropDownEventToParent(context, value,
              id: schemaProperty.id);
          updateData(context, value);
          widgetBuilderInherited.notifyChanges();
        },
        customValidator: _getCustomValidator(context, schemaProperty.idKey),
      );
    } else if (schemaProperty.oneOf != null) {
      _field = DropdownOneOfJFormField(
        property: schemaPropertySorted,
        customPickerHandler: _getCustomPickerHanlder(
          context,
          schemaProperty.id,
        ),
        onSaved: (val) {
          if (val is OneOfModel) {
            log('onSaved: SelectedFormField  ${schemaProperty.idKey}  : ${val.oneOfModelEnum?.first}');
            updateData(context, val.oneOfModelEnum?.first);
          }
        },
        onChanged: (value) {
          dispatchSelectedForDropDownEventToParent(context, value,
              id: schemaProperty.id);

          updateData(context, value);
          widgetBuilderInherited.notifyChanges();
        },
        customValidator: _getCustomValidator(context, schemaProperty.idKey),
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
                String date;
                if (schemaProperty.format == PropertyFormat.date) {
                  date = DateFormat(dateFormatString).format(val);
                } else {
                  date = DateFormat(dateTimeFormatString).format(val);
                }

                log('onSaved: DateJFormField  ${schemaProperty.idKey}  : $date');
                updateData(context, date);
              },
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value != null);
                if (value == null) return;
                String date;
                if (schemaProperty.format == PropertyFormat.date) {
                  date = DateFormat(dateFormatString).format(value);
                } else {
                  date = DateFormat(dateTimeFormatString).format(value);
                }

                updateData(context, date);
                widgetBuilderInherited.notifyChanges();
              },
              customValidator:
                  _getCustomValidator(context, schemaProperty.idKey),
            );
            break;
          }

          if (schemaProperty.format == PropertyFormat.dataurl) {
            _field = FileJFormField(
              property: schemaPropertySorted,
              customFileHandler: getCustomFileHanlder(
                  WidgetBuilderInherited.of(context).customFileHandler,
                  schemaProperty.id),
              onSaved: (val) {
                log('onSaved: FileJFormField  ${schemaProperty.idKey}  : $val');
                updateData(context, val);
              },
              onChanged: (value) {
                print(value);

                dispatchBooleanEventToParent(
                    context,
                    schemaProperty.isMultipleFile
                        ? value is List && value.isNotEmpty
                        : value != null);

                updateData(context, value);
                widgetBuilderInherited.notifyChanges();
              },
              customValidator:
                  _getCustomValidator(context, schemaProperty.idKey),
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
              dispatchStringEventToParent(context, value!);
              updateData(context, value);
              widgetBuilderInherited.notifyChanges();
            },
            customValidator: _getCustomValidator(context, schemaProperty.idKey),
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
              updateData(context, value);
              widgetBuilderInherited.notifyChanges();
            },
            customValidator: _getCustomValidator(context, schemaProperty.idKey),
          );
          break;
        case SchemaType.boolean:
          if (schemaProperty.widget == 'radio') {
            _field = RadioButtonJFormField(
              property: schemaPropertySorted,
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value != null);
                updateData(context, value);
                widgetBuilderInherited.notifyChanges();
              },
              onSaved: (val) {
                log('onSaved: RadioButtonJFormField ${schemaProperty.idKey}  : $val');

                updateData(context, val);
              },
              customValidator:
                  _getCustomValidator(context, schemaProperty.idKey),
            );
          } else {
            _field = CheckboxJFormField(
              property: schemaPropertySorted,
              onChanged: (value) {
                dispatchBooleanEventToParent(context, value!);
                updateData(context, value);
                widgetBuilderInherited.notifyChanges();
              },
              onSaved: (val) {
                log('onSaved: CheckboxJFormField ${schemaProperty.idKey}  : $val');

                updateData(context, val);
              },
              customValidator:
                  _getCustomValidator(context, schemaProperty.idKey),
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
              dispatchStringEventToParent(context, value!);
              updateData(context, value);
              widgetBuilderInherited.notifyChanges();
            },
            customValidator: _getCustomValidator(context, schemaProperty.idKey),
          );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        if (!kReleaseMode)
          Text(
            'key: ${schemaProperty.idKey}',
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
    debugPrint('dispatchSelectedForDropDownEventToParent()  $value ID: $id');
    ObjectSchemaInherited.of(context).listenChangeProperty(
        (value != null && (value is String ? value.isNotEmpty : true)),
        schemaProperty,
        optionalValue: value,
        idOptional: id,
        mainSchema: mainSchema);
    // }
  }

  /// Cuando se valida si es true o false
  void dispatchBooleanEventToParent(BuildContext context, bool value) {
    debugPrint('dispatchBooleanEventToParent()  $value');
    if (value != schemaProperty.isDependentsActive) {
      ObjectSchemaInherited.of(context)
          .listenChangeProperty(value, schemaProperty);
    }
  }

  Future<List<File>?> Function()? getCustomFileHanlder(
      CustomFileHandler? customFileHandler, String key) {
    if (customFileHandler == null) return null;

    final handlers = customFileHandler();

    if (handlers.containsKey(key)) return handlers[key];

    if (handlers.containsKey('*')) return handlers['*'];

    return null;
  }

  Future<dynamic> Function(Map<dynamic, dynamic>)? _getCustomPickerHanlder(
      BuildContext context, String key) {
    final customFileHandler =
        WidgetBuilderInherited.of(context).customPickerHandler;

    if (customFileHandler == null) return null;

    final handlers = customFileHandler();

    if (handlers.containsKey(key)) return handlers[key];

    if (handlers.containsKey('*')) return handlers['*'];

    return null;
  }

  String? Function(dynamic)? _getCustomValidator(
      BuildContext context, String key) {
    final customValidatorHandler =
        WidgetBuilderInherited.of(context).customValidatorHandler;

    if (customValidatorHandler == null) return null;

    final handlers = customValidatorHandler();

    if (handlers.containsKey(key)) return handlers[key];

    if (handlers.containsKey('*')) return handlers['*'];

    return null;
  }
}

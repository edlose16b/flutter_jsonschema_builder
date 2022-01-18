import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ObjectSchemaEvent {
  ObjectSchemaEvent({required this.schemaObject});
  final SchemaObject schemaObject;
}

class ObjectSchemaDependencyEvent extends ObjectSchemaEvent {
  ObjectSchemaDependencyEvent({required SchemaObject schemaObject})
      : super(schemaObject: schemaObject);
}

class ObjectSchemaInherited extends InheritedWidget {
  const ObjectSchemaInherited({
    Key? key,
    required this.schemaObject,
    required Widget child,
    required this.listen,
  }) : super(key: key, child: child);

  final SchemaObject schemaObject;
  final ValueSetter<ObjectSchemaEvent?> listen;

  static ObjectSchemaInherited of(BuildContext context) {
    final ObjectSchemaInherited? result =
        context.dependOnInheritedWidgetOfExactType<ObjectSchemaInherited>();
    assert(result != null, 'No WidgetBuilderInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ObjectSchemaInherited oldWidget) {
    final needsRepint = schemaObject != oldWidget.schemaObject;
    return needsRepint;
  }

  /// esta funcion comunica
  void listenChangeProperty(bool active, SchemaProperty schemaProperty,
      {String? optionalValue, Schema? mainSchema}) async {
    try {
      if (schemaProperty.dependents is List<String>) {
        for (var element in schemaObject.properties!) {
          if ((schemaProperty.dependents as List).contains(element.id)) {
            if (element is SchemaProperty) {
              print('Este element ${element.id} es ahora $active');
              element.required = active;
            }
          }
        }

        schemaProperty.isDependentsActive = active;
        listen(ObjectSchemaDependencyEvent(schemaObject: schemaObject));
      } else if (schemaProperty.dependents.containsKey("oneOf")) {
        // Eliminamos los nuevos imputs agregados

        schemaObject.properties!.removeWhere((element) =>
            (element is SchemaProperty) &&
            (element).dependentsAddedBy == schemaProperty.id);

        List? listProperty;
        SchemaProperty? schemaProp;
        Map<String, dynamic>? schemaTemp;
        if (schemaProperty.dependents is Map) {
          schemaTemp = {};
          schemaProperty.dependents.forEach((key, value) {
            listProperty = value;
          });
        }

        for (var schema in (listProperty ?? [])) {
          Map propertiesMap = Map.from(schema['properties']);
          if (propertiesMap is Map && schema != null) {
            schemaTemp = schema;

            propertiesMap.forEach((keyPrimary, value) {
              if (value is Map) {
                value.forEach((ky, val) {
                  if (ky == 'enum') {
                    if (value[ky].first == optionalValue) {
                      print('🧠🧠 $keyPrimary');

                      var propertiesTemporal;

                      final temporal =
                          SchemaObject.fromJson(kNoIdKey, schemaTemp ?? {});

                      temporal.properties?.forEach((elment) {
                        if (elment is! SchemaEnum) {
                          propertiesTemporal = elment as SchemaProperty;

                          schemaProp = propertiesTemporal;
                          if (schemaProp != null) {
                            schemaObject.properties!.add(schemaProp!);

                            schemaProperty.isDependentsActive = active;
                            schemaProp!.dependentsAddedBy = keyPrimary;
                          }
                        }
                      });
                    }
                  } else {
                    // schemaObject.properties!
                    //     .removeWhere((e) => e.id == keyPrimary);
                    // FormFromSchemaBuilder(
                    //   mainSchema: mainSchema!,
                    //   schema: schemaObject,
                    // );
                  }
                });
              }
            });
          }
        }

        // Actualizamos depsues de todo
        listen(ObjectSchemaDependencyEvent(schemaObject: schemaObject));
      } else if (schemaProperty.dependents is Schema) {
        print('tttt');
        final _schema = schemaProperty.dependents;

        if (active) {
          schemaObject.properties!.add(_schema);
        } else {
          schemaObject.properties!
              .removeWhere((element) => element.id == _schema.idKey);
        }

        schemaProperty.isDependentsActive = active;

        listen(ObjectSchemaDependencyEvent(schemaObject: schemaObject));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

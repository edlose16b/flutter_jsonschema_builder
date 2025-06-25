import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/models/models.dart';

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
      {dynamic optionalValue, Schema? mainSchema, String? idOptional}) async {
    try {
      // Eliminamos los nuevos imputs agregados
      await _removeCreatedItemsSafeMode(schemaProperty);
      // Obtenemos el index del actual property para anadir a abajo de él
      final indexProperty = schemaObject.properties!.indexOf(schemaProperty);

      if (schemaProperty.dependents is List) {
        dev.log('case 1');

        // Cuando es una Lista de String y todos ellos ahoran serán requeridos

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
      } else if (schemaProperty.dependents != null &&
          schemaProperty.dependents.containsKey("oneOf")) {
        // Cuando es OneOf

        dev.log('case OneOf');

        final oneOfs = schemaProperty.dependents['oneOf'];

        if (oneOfs is List) {
          for (Map<String, dynamic> oneOf in oneOfs) {
            // Verificamos si es el que requerimos
            if (oneOf.containsKey('properties') &&
                !oneOf['properties'].containsKey(schemaProperty.id)) continue;

            // Verificamos que tenga la estructura enum correcta
            if (oneOf['properties'][schemaProperty.id] is! Map ||
                !oneOf['properties'][schemaProperty.id].containsKey('enum'))
              continue;

            // Guardamos los valores que se van a condicionar para que salgan los nuevos inputs

            final valuesForCondition =
                oneOf['properties'][schemaProperty.id]['enum'];

            // si tiene uno del valor seleccionado en el select, mostramos
            if (valuesForCondition.contains(optionalValue)) {
              schemaProperty.isDependentsActive = true;

              // Add new propperties

              final tempSchema = SchemaObject.fromJson(
                kNoIdKey,
                oneOf,
                parent: schemaObject,
              );

              final newProperties = tempSchema.properties!
                  // Quitamos el key del mismo para que no se agregue al arbol de widgets
                  .where((e) => e.id != schemaProperty.id)
                  // Agregamos que fue dependiente de este, para que luego pueda ser eliminado.
                  .map((e) {
                e.dependentsAddedBy.addAll([
                  ...schemaProperty.dependentsAddedBy,
                  schemaProperty.id,
                ]);
                if (e is SchemaProperty) e.setDependents(schemaObject);

                return e;
              }).toList();

              schemaObject.properties!
                  .insertAll(indexProperty + 1, newProperties);
            }
          }
        }

        // distpach Event
        listen(ObjectSchemaDependencyEvent(schemaObject: schemaObject));
      } else if (schemaProperty.dependents is Schema) {
        // Cuando es un Schema simple
        dev.log('case 3');
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

  Future<void> _removeCreatedItemsSafeMode(
      SchemaProperty schemaProperty) async {
    bool filter(Schema element) =>
        (element).dependentsAddedBy.contains(schemaProperty.id);

    if (schemaObject.properties!.where(filter).isNotEmpty) {
      schemaObject.properties!.removeWhere(filter);

      listen(ObjectSchemaDependencyEvent(schemaObject: schemaObject));
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}

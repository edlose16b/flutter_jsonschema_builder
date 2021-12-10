import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/models/models.dart';

class ObjectSchemaEvent {}

class ObjectSchemaPropertyDependencyEvent extends ObjectSchemaEvent {
  ObjectSchemaPropertyDependencyEvent({required this.schemaObject});
  final SchemaObject schemaObject;
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

  void listenChangeProperty(
      String value, bool isRequired, SchemaProperty schemaProperty) async {
    print('value: $value a -> : $isRequired ');

    schemaProperty.dependents;

    if (schemaProperty.dependents is List<String>) {
      for (var element in schemaObject.properties!) {
        if ((schemaProperty.dependents as List).contains(element.id)) {
          if (element is SchemaProperty) {
            print('Este element ${element.id} es ahora $isRequired');
            element.required = isRequired;
          }
        }
      }
    }

    

    listen(ObjectSchemaPropertyDependencyEvent(schemaObject: schemaObject));
  }
}

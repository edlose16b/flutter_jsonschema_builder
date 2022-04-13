import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/models/json_form_schema_style.dart';
import 'package:flutter_jsonschema_form/src/models/schema.dart';

class WidgetBuilderInherited extends InheritedWidget {
  WidgetBuilderInherited({
    Key? key,
    required this.mainSchema,
    required Widget child,
    this.customFileHandler,
  }) : super(key: key, child: child);

  final Schema mainSchema;
  final data = {};
  final Future<List<File>?> Function()? customFileHandler;
  late final JsonFormSchemaStyle jsonFormSchemaStyle;

  void setJsonFormSchemaStyle(
      BuildContext context, JsonFormSchemaStyle? jsonFormSchemaStyle) {
    final textTheme = Theme.of(context).textTheme;

    this.jsonFormSchemaStyle = JsonFormSchemaStyle(
      title: jsonFormSchemaStyle?.title ?? textTheme.headline6,
      subtitle: jsonFormSchemaStyle?.subtitle ??
          textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
      description: jsonFormSchemaStyle?.description ?? textTheme.bodyText2,
      error: jsonFormSchemaStyle?.error ??
          TextStyle(
              color: Theme.of(context).errorColor,
              fontSize: textTheme.caption!.fontSize),
      label: jsonFormSchemaStyle?.label ?? textTheme.bodyText2,
    );
  }

  /// update [data] with key,values from jsonSchema
  void updateObjectData(object, String path, dynamic value) {
    print('updateObjectData $object path $path value $value');

    final stack = path.split('.');

    while (stack.length > 1) {
      final _key = stack[0];
      final isNextKeyInteger = int.tryParse(stack[1]) != null;
      final newContent = isNextKeyInteger ? [] : {};
      final _keyNumeric = int.tryParse(_key);

      log('$_key - next Key is int? $isNextKeyInteger');

      _addNewContent(object, _keyNumeric, newContent);

      final tempObject = object[_keyNumeric ?? _key];
      if (tempObject != null) {
        object = tempObject;
      } else {
        object[_key] = newContent;
        object = object[_key];
      }

      stack.removeAt(0);
    }

    final _key = stack[0];
    final _keyNumeric = int.tryParse(_key);
    _addNewContent(object, _keyNumeric, value);

    object[_keyNumeric ?? _key] = value;
    stack.removeAt(0);
  }

  /// add a new value into a schema,
  void _addNewContent(object, int? _keyNumeric, dynamic value) {
    if (object is List && _keyNumeric != null) {
      if (object.length - 1 < _keyNumeric) {
        object.add(value);
      }
    }
  }

  @override
  bool updateShouldNotify(covariant WidgetBuilderInherited oldWidget) =>
      mainSchema != oldWidget.mainSchema;

  static WidgetBuilderInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<WidgetBuilderInherited>();

    assert(result != null, 'No WidgetBuilderInherited found in context');
    return result!;
  }
}

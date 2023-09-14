import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/widget_builder.dart';
import 'package:flutter_jsonschema_builder/src/models/json_form_schema_style.dart';
import 'package:flutter_jsonschema_builder/src/models/schema.dart';

class WidgetBuilderInherited extends InheritedWidget {
  WidgetBuilderInherited({
    Key? key,
    required this.mainSchema,
    required Widget child,
    this.fileHandler,
    this.initialFileValueHandler,
    this.customPickerHandler,
    this.customValidatorHandler,
    this.onChanged,
    Map<String, dynamic>? initialData,
  })  : data = initialData ?? {},
        super(key: key, child: child);

  final Schema mainSchema;
  final Map<String, dynamic> data;

  final FileHandler? fileHandler;
  final InitialFileValueHandler? initialFileValueHandler;
  final CustomPickerHandler? customPickerHandler;
  final CustomValidatorHandler? customValidatorHandler;
  final ValueChanged<dynamic>? onChanged;
  late final JsonFormSchemaUiConfig uiConfig;

  void setJsonFormSchemaStyle(
      BuildContext context, JsonFormSchemaUiConfig? uiConfig) {
    this.uiConfig = JsonFormSchemaUiConfig(
      titleAlign: uiConfig?.titleAlign ?? TextAlign.center,
      selectionTitle: uiConfig?.selectionTitle,
      requiredText: uiConfig?.requiredText,
      //builders
      addItemBuilder: uiConfig?.addItemBuilder,
      removeItemBuilder: uiConfig?.removeItemBuilder,
      submitButtonBuilder: uiConfig?.submitButtonBuilder,
      addFileButtonBuilder: uiConfig?.addFileButtonBuilder,
      filesBuilder: uiConfig?.filesBuilder,
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
    onChanged?.call(data);
  }

  /// add a new value into a schema,
  void _addNewContent(object, int? _keyNumeric, dynamic value) {
    if (object is List && _keyNumeric != null) {
      if (object.length - 1 < _keyNumeric) {
        object.add(value);
      }
    }
  }

  void notifyChanges() {
    // if (onChanged != null) onChanged!(data);
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

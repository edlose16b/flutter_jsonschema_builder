import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/flutter_jsonschema_builder.dart';

class JsonFormSchemaUiConfig {
  JsonFormSchemaUiConfig({
    this.titleAlign,
    this.addItemBuilder,
    this.removeItemBuilder,
    this.submitButtonBuilder,
    this.addFileButtonBuilder,
    this.filesBuilder,
    this.selectionTitle,
    this.requiredText,
  });

  TextAlign? titleAlign;

  /// title of the selection widget
  /// if it is null, it will default to "Select"
  String? selectionTitle;

  /// text of the required fields
  /// if it is null, it will default to "Required"
  String? requiredText;

  Widget Function(VoidCallback onPressed, String key)? addItemBuilder;
  Widget Function(VoidCallback onPressed, String key)? removeItemBuilder;

  /// render a custom submit button
  /// @param [VoidCallback] submit function
  Widget Function(VoidCallback onSubmit)? submitButtonBuilder;

  /// render a custom button
  /// if it returns null or it is null, it will build default buttom
  Widget? Function(VoidCallback? onPressed, SchemaProperty property)?
      addFileButtonBuilder;

  /// render a custom files preview
  ///
  /// this widget is typically shown above the [addFileButtonBuilder] or default button in file field
  ///
  /// The builder decides what to build based on the [files] provided,
  /// and [onRemove] callback is provided so you can handle files removal from cusotm widgets
  ///
  /// if it returns `null`, default files names widget will be displayed
  Widget Function(List<SchemaFormFile>? files,
      {required ValueChanged<String> onRemove})? filesBuilder;
}

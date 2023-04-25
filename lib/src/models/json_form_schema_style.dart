import 'dart:typed_data';

import 'package:flutter/material.dart';

class JsonFormSchemaUiConfig {
  JsonFormSchemaUiConfig({
    this.fieldTitle,
    this.error,
    this.title,
    this.titleAlign,
    this.subtitle,
    this.description,
    this.label,
    this.addItemBuilder,
    this.removeItemBuilder,
    this.submitButtonBuilder,
    this.addFileButtonBuilder,
    this.imagesBuilder,
    this.selectionTitle,
    this.requiredText,
  });

  TextStyle? fieldTitle;
  TextStyle? error;
  TextStyle? title;
  TextAlign? titleAlign;
  TextStyle? subtitle;
  TextStyle? description;
  TextStyle? label;

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
  Widget? Function(VoidCallback? onPressed, String key)? addFileButtonBuilder;

  /// render a custom image preview, it takes a list of Uint8List (image bytes) as a parameter
  /// this widget is typically shown above the [addFileButtonBuilder] or default button in file field
  ///
  /// if it returns null or it is null, images won't be rendered
  Widget Function(List<Uint8List> images)? imagesBuilder;
}

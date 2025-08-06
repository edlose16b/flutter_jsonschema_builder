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
    this.inputDecoration,
  });

  TextStyle? fieldTitle;
  TextStyle? error;
  TextStyle? title;
  TextAlign? titleAlign;
  TextStyle? subtitle;
  TextStyle? description;
  TextStyle? label;

  Widget Function(VoidCallback onPressed, String key)? addItemBuilder;
  Widget Function(VoidCallback onPressed, String key)? removeItemBuilder;

  /// render a custom submit button
  /// @param [VoidCallback] submit function
  Widget Function(VoidCallback onSubmit)? submitButtonBuilder;

  /// render a custom button
  /// if it returns null or it is null, it will build default buttom
  Widget? Function(VoidCallback? onPressed, String key)? addFileButtonBuilder;

  /// decoration for text fields
  InputDecoration? inputDecoration;
}

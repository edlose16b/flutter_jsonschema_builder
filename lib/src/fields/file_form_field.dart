import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/fields/fields.dart';

import '../models/models.dart';
import './shared.dart';

extension on PlatformFile {
  File get toFile {
    return File(path!);
  }
}

class FileJFormField extends PropertyFieldWidget<dynamic> {
  const FileJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
    this.customFileHandler,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

  final Future<List<File>?> Function()? customFileHandler;

  @override
  _FileJFormFieldState createState() => _FileJFormFieldState();
}

class _FileJFormFieldState extends State<FileJFormField> {
  @override
  void initState() {
    widget.triggetDefaultValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgetBuilderInherited = WidgetBuilderInherited.of(context);

    return FormField<List<File>>(
      key: Key(widget.property.idKey),
      validator: (value) {
        if ((value == null || value.isEmpty) && widget.property.required) {
          return 'Required';
        }
        return null;
      },
      onSaved: (newValue) {
        if (newValue != null) {
          final response =
              widget.property.isMultipleFile ? newValue : (newValue.first);

          widget.onSaved(response);
        }
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.property.title} ${widget.property.required ? "*" : ""}',
              style: widgetBuilderInherited.uiConfig.fieldTitle,
            ),
            const SizedBox(height: 10),
            _buildButton(widgetBuilderInherited, field),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: field.value?.length ?? 0,
              itemBuilder: (context, index) {
                final file = field.value![index];

                return ListTile(
                  title: Text(
                      file.path.characters
                          .takeLastWhile((p0) => p0 != '/')
                          .string,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: widget.property.readOnly
                          ? const TextStyle(color: Colors.grey)
                          : widgetBuilderInherited.uiConfig.label),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 14),
                    onPressed: () {
                      change(
                          field,
                          field.value!
                            ..removeWhere(
                                (element) => element.path == file.path));
                    },
                  ),
                );
              },
            ),
            if (field.hasError) CustomErrorText(text: field.errorText!),
          ],
        );
      },
    );
  }

  void change(FormFieldState<List<File>> field, List<File>? values) {
    field.didChange(values);

    if (widget.onChanged != null) {
      final response = widget.property.isMultipleFile
          ? values
          : (values != null && values.isNotEmpty ? values.first : null);
      widget.onChanged!(response);
    }
  }

  VoidCallback? _onTap(FormFieldState<List<File>> field) {
    if (widget.property.readOnly) return null;

    return () async {
      if (widget.customFileHandler == null) {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: widget.property.isMultipleFile,
        );

        if (result != null) {
          change(field, result.files.map((e) => e.toFile).toList());
        }
      } else {
        final result = await widget.customFileHandler!();

        if (result != null) {
          change(field, result);
        }
      }
    };
  }

  Widget _buildButton(
    WidgetBuilderInherited widgetBuilderInherited,
    FormFieldState<List<File>> field,
  ) {
    final addFileButtonBuilder =
        widgetBuilderInherited.uiConfig.addFileButtonBuilder;

    if (addFileButtonBuilder != null &&
        addFileButtonBuilder(_onTap(field), widget.property.idKey) != null) {
      return addFileButtonBuilder(_onTap(field), widget.property.idKey)!;
    }

    return ElevatedButton(
      onPressed: _onTap(field),
      child: const Text('Add File'),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 40)),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:file_picker/file_picker.dart';
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
                style: Theme.of(context).textTheme.bodyText1),
            TextButton(
              onPressed: widget.property.readOnly
                  ? null
                  : () async {
                      if (widget.customFileHandler == null) {
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: widget.property.isMultipleFile,
                        );

                        if (result != null) {
                          change(field,
                              result.files.map((e) => e.toFile).toList());
                        }
                      } else {
                        final result = await widget.customFileHandler!();

                        if (result != null) {
                          change(field, result);
                        }
                      }
                    },
              child: const Text('Elegir archivos'),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: field.value?.length ?? 0,
              itemBuilder: (context, index) {
                final file = field.value![index];

                return ListTile(
                  title: Text(
                    file.parent.path.characters
                        .takeLastWhile((p0) => p0 != '/')
                        .string,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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

  // void change(
  //     FormFieldState<List<PlatformFile>> field, List<PlatformFile>? values) {
  //   field.didChange(values);
  //   if (widget.onChanged != null) {
  //     widget.onChanged!(values?.map((e) => e.toFile).toList());
  //   }
  // }

  void change(FormFieldState<List<File>> field, List<File>? values) {
    field.didChange(values);

    if (widget.onChanged != null) {
      final response = widget.property.isMultipleFile
          ? values
          : (values != null && values.isNotEmpty ? values.first : null);
      widget.onChanged!(response);
    }
  }
}

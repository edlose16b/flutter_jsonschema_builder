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

class FileJFormField extends PropertyFieldWidget<List<File>?> {
  const FileJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<List<File>?> onSaved,
    ValueChanged<List<File>?>? onChanged,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
        );

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField<List<PlatformFile>>(
          key: Key(widget.property.idKey),
          validator: (value) {
            if ((value == null || value.isEmpty) && widget.property.required) {
              return 'Required';
            }
          },
          onSaved: (newValue) {
            if (newValue != null) {
              widget.onSaved(newValue.map((e) => e.toFile).toList());
            }
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: widget.property.readOnly
                      ? null
                      : () async {
                          final result = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                          );

                          if (result != null) {
                            change(field, result.files);
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
                      title: Text(file.name),
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
        ),
      ],
    );
  }

  void change(
      FormFieldState<List<PlatformFile>> field, List<PlatformFile>? values) {
    field.didChange(values);
    if (widget.onChanged != null) {
      widget.onChanged!(values?.map((e) => e.toFile).toList());
    }
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';
import 'package:mime/mime.dart';

import './shared.dart';
import '../models/models.dart';

class FileJFormField extends PropertyFieldWidget<dynamic> {
  const FileJFormField({
    Key? key,
    required SchemaProperty property,
    required final ValueSetter<dynamic> onSaved,
    ValueChanged<dynamic>? onChanged,
    required this.fileHandler,
    final String? Function(dynamic)? customValidator,
  }) : super(
          key: key,
          property: property,
          onSaved: onSaved,
          onChanged: onChanged,
          customValidator: customValidator,
        );

  final Future<List<SchemaFormFile>?> Function(SchemaProperty property)
      fileHandler;

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

    return FormField<List<SchemaFormFile>>(
      key: Key(widget.property.idKey),
      validator: (value) {
        if ((value == null || value.isEmpty) && widget.property.required) {
          return widgetBuilderInherited.uiConfig.requiredText ?? 'Required';
        }

        if (widget.customValidator != null)
          return widget.customValidator!(value);
        return null;
      },
      onSaved: (newValue) {
        if (newValue != null) {
          final response = widget.property.isMultipleFile
              ? newValue.map((f) => f.value).toList()
              : (newValue.first.value);

          widget.onSaved(response);
        }
      },
      builder: (field) {
        final images = _extractImages(field.value);
        final shouldBuildImages = widget.property.filePreview &&
            widgetBuilderInherited.uiConfig.imagesBuilder != null &&
            images != null &&
            images.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.property.title} ${widget.property.required ? "*" : ""}',
              style: widgetBuilderInherited.uiConfig.fieldTitle,
            ),
            const SizedBox(height: 10),
            if (shouldBuildImages)
              widgetBuilderInherited.uiConfig.imagesBuilder!(images!),
            _buildButton(widgetBuilderInherited, field),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: field.value?.length ?? 0,
              itemBuilder: (context, index) {
                final currentFile = field.value![index];
                final name = currentFile.name;
                return ListTile(
                  title: Text(name,
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
                            ..removeWhere((element) => element.name == name));
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

  void change(
    FormFieldState<List<SchemaFormFile>> field,
    List<SchemaFormFile>? values,
  ) {
    field.didChange(values);

    if (widget.onChanged != null) {
      final response = widget.property.isMultipleFile
          ? values?.map((e) => e.value).toList()
          : (values != null && values.isNotEmpty ? values.first.value : null);
      widget.onChanged!(response);
    }
  }

  List<Uint8List>? _extractImages(List<SchemaFormFile>? data) {
    return data
        // filter only images
        ?.where(
          (e) =>
              lookupMimeType(e.name, headerBytes: e.bytes)
                  ?.startsWith('image/') ==
              true,
        )
        // map as only bytes
        .map((e) => e.bytes)
        .toList();
  }

  VoidCallback? _onTap(FormFieldState<List<SchemaFormFile>> field) {
    if (widget.property.readOnly) return null;

    return () async {
      final result = await widget.fileHandler(widget.property);

      if (result != null) {
        change(field, result);
      }
    };
  }

  Widget _buildButton(
    WidgetBuilderInherited widgetBuilderInherited,
    FormFieldState<List<SchemaFormFile>> field,
  ) {
    final addFileButtonBuilder =
        widgetBuilderInherited.uiConfig.addFileButtonBuilder;

    if (addFileButtonBuilder != null &&
        addFileButtonBuilder(_onTap(field), widget.property) != null) {
      return addFileButtonBuilder(_onTap(field), widget.property)!;
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

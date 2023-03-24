import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_builder/src/fields/fields.dart';

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

  final Future<List<XFile>?> Function() fileHandler;

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

    return FormField<List<XFile>>(
      key: Key(widget.property.idKey),
      validator: (value) {
        if ((value == null || value.isEmpty) && widget.property.required) {
          return 'Required';
        }

        if (widget.customValidator != null)
          return widget.customValidator!(value);
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

  void change(FormFieldState<List<XFile>> field, List<XFile>? values) {
    field.didChange(values);

    if (widget.onChanged != null) {
      final response = widget.property.isMultipleFile
          ? values
          : (values != null && values.isNotEmpty ? values.first : null);
      widget.onChanged!(response);
    }
  }

  VoidCallback? _onTap(FormFieldState<List<XFile>> field) {
    if (widget.property.readOnly) return null;

    return () async {
      final result = await widget.fileHandler();

      if (result != null) {
        change(field, result);
      }
    };
  }

  Widget _buildButton(
    WidgetBuilderInherited widgetBuilderInherited,
    FormFieldState<List<XFile>> field,
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

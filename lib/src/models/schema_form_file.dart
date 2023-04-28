import 'dart:typed_data';

/// Representation of a file in the schema form
///
/// It holds the title that will be displayed in the form
class SchemaFormFile {
  SchemaFormFile({
    required this.name,
    required this.value,
    required this.bytes,
  });

  /// The name of the file, used for comsetic reasons
  String name;

  /// The value of the file, used for the form
  String value;

  /// The bytes of the file, used for cosmetic reasons when displaying previews
  Uint8List bytes;

  SchemaFormFile copyWith({
    String? name,
    String? value,
    Uint8List? bytes,
  }) {
    return SchemaFormFile(
      name: name ?? this.name,
      value: value ?? this.value,
      bytes: bytes ?? this.bytes,
    );
  }
}

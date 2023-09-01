import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_builder/src/models/models.dart';

class GeneralSubtitle extends StatelessWidget {
  const GeneralSubtitle({
    Key? key,
    required this.title,
    this.description,
    this.mainSchemaTitle,
    this.nainSchemaDescription,
  }) : super(key: key);

  final String title;
  final String? description, mainSchemaTitle, nainSchemaDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        if (mainSchemaTitle != title && title != kNoTitle) ...[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Divider()
        ],
        if (description != null && description != nainSchemaDescription)
          Text(
            description!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

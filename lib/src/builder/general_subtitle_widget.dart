import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';

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
      children: [
        if (mainSchemaTitle != title && title != kNoTitle)
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        if (description != null && description != nainSchemaDescription)
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyText2,
          ),
      ],
    );
  }
}

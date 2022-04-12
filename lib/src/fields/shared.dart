import 'package:flutter/material.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).errorColor, fontSize: Theme.of(context).textTheme.caption!.fontSize),
      ),
    );
  }
}

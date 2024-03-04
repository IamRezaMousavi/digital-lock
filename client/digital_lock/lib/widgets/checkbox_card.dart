import 'package:flutter/material.dart';

// ignore: camel_case_types
typedef onChangedFunction = void Function(bool?);

class CheckboxCard extends StatefulWidget {
  const CheckboxCard({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final bool value;
  final onChangedFunction onChanged;

  @override
  State<CheckboxCard> createState() => _CheckboxCardState();
}

class _CheckboxCardState extends State<CheckboxCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(widget.text),
      trailing: Checkbox(
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    ));
  }
}

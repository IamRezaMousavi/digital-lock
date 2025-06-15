import 'package:flutter/material.dart';

// ignore: camel_case_types
typedef onChangedFunction = void Function(bool);

class SwitchCard extends StatefulWidget {
  const SwitchCard({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final bool value;
  final onChangedFunction onChanged;

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text(widget.text),
      trailing: Switch(value: widget.value, onChanged: widget.onChanged),
    ),
  );
}

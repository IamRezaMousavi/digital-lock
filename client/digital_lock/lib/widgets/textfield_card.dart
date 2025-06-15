import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldCard extends StatefulWidget {
  TextFieldCard({
    super.key,
    required this.title,
    required this.description,
    required this.controller,
    this.suffixText,
    this.inputType,
    required this.onActive,
  });

  final String title;
  final String description;
  final TextEditingController controller;
  String? suffixText;
  TextInputType? inputType;
  Function(bool?) onActive;

  @override
  State<TextFieldCard> createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.description),
            Checkbox(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value!;
                  widget.onActive(value);
                });
              },
            ),
          ],
        ),
        TextField(
          enabled: isActive,
          controller: widget.controller,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.title,
            suffixText: widget.suffixText,
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

// ignore: camel_case_types
typedef stateChanged = void Function(bool isValid, String phoneNumber);

class PhoneNumberInput extends StatefulWidget {
  final stateChanged onStateChanged;
  final phoneController = TextEditingController();
  PhoneNumberInput({super.key, required this.onStateChanged});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  RegExp exp = RegExp(r'^(\+98|0)?9\d{9}$');
  bool isValid = false;

  String? phonenumberValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter phone number';
    } else if (!exp.hasMatch(value)) {
      return 'Please enter valid phone number';
    } else {
      return null;
    }
  }

  checkIsValid(String value) {
    isValid = exp.hasMatch(value);
    setState(() {});
    widget.onStateChanged(isValid, widget.phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.phoneController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Phone Number',
        errorText: phonenumberValidator(widget.phoneController.text),
      ),
      onChanged: (value) {
        checkIsValid(value);
      },
    );
  }
}

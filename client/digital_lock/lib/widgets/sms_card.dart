// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

import '../utils/models.dart';

typedef onSendFunction = void Function();
typedef onSelectFunction = void Function();
typedef onDeleteFunction = void Function();

class SmsCard extends StatefulWidget {
  const SmsCard({
    super.key,
    required this.message,
    this.onSend,
    this.onSelect,
    this.onDelete,
  });

  final Message message;
  final onSendFunction? onSend;
  final onSelectFunction? onSelect;
  final onDeleteFunction? onDelete;

  @override
  State<SmsCard> createState() => _SmsCardState();
}

class _SmsCardState extends State<SmsCard> {
  @override
  Widget build(BuildContext context) {
    var title = '';
    if (widget.message.text != null) {
      try {
        final messageText =
            MessageText.fromMap(jsonDecode(widget.message.text!));
        title = '${messageText.name} (${messageText.code})';
      } catch (e) {
        // Json Decode can't parse message text
        title = widget.message.text!;
      }
    }

    if (widget.message.date != null) {
      // convert timestamp to human readable
      final dateTime = DateFormat('yyyy-MM-dd HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(widget.message.date!));
      title += ' $dateTime';
    }

    return Card(
      child: ListTile(
          title: title.isNotEmpty ? Text(title) : const Text('Null'),
          subtitle: widget.message.address != null
              ? Text(widget.message.address!)
              : const Text('Null'),
          trailing: OutlinedButton(
              onPressed: widget.onSend, child: const Text('Show')),
          onTap: widget.onSelect,
          onLongPress: widget.onDelete),
    );
  }
}

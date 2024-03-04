// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/models.dart';

typedef onSendFunction = void Function();
typedef onSelectFunction = void Function();
typedef onDeleteFunction = void Function();

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.user,
    this.onSend,
    this.onSelect,
    this.onDelete,
  });

  final User user;
  final onSendFunction? onSend;
  final onSelectFunction? onSelect;
  final onDeleteFunction? onDelete;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    String title = widget.user.name;

    if (widget.user.date != null) {
      String dateTime = DateFormat('yyyy-MM-dd HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(widget.user.date!));
      title += ' $dateTime';
    }

    return Card(
      child: ListTile(
          title: Text(title),
          trailing: OutlinedButton(
            onPressed: widget.onSend,
            child: const Text('Send'),
          ),
          onTap: widget.onSelect,
          onLongPress: widget.onDelete),
    );
  }
}

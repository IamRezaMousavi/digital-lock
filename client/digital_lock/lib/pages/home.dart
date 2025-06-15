import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';
import 'package:provider/provider.dart';

import '../utils/data_storage.dart';
import '../utils/models.dart';
import '../utils/db.dart';
import '../utils/sms.dart';

import '../widgets/awesome_snackbar.dart';
import '../widgets/my_textfield.dart';
import '../widgets/sms_card.dart';

import './app_settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Message> messages = [];
  int? selectedIndex;
  final textController = TextEditingController();

  @override
  Future<void> initState() async {
    await MessagesDB.instance.getMessages().then((messagesList) {
      setState(() {
        messages = messagesList;
      });
    });
    reciveSms((SmsMessage message) async {
      final newMessage = Message(
        address: message.address,
        text: message.body,
        date: message.date,
      );
      final id = await MessagesDB.instance.add(newMessage);
      setState(() {
        newMessage.id = id;
        messages.insert(0, newMessage);
      });
    });
    super.initState();
  }

  Future<void> _refresh() => Future.delayed(const Duration(seconds: 4));

  @override
  Widget build(BuildContext context) {
    final dataStorage = Provider.of<DataStorage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Digital Lock')),
        leading: IconButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AppSettingsPage()),
            );
          },
          icon: const Icon(Icons.settings),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            selectedIndex != null
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
        onPressed: () async {
          if (selectedIndex != null) {
            final message = messages[selectedIndex!];
            final newMessage = Message(
              id: message.id,
              address: message.address,
              text: textController.text,
              date: message.date,
            );
            await MessagesDB.instance.update(newMessage);
            setState(() {
              messages[selectedIndex!] = newMessage;
            });
          } else {
            final newMessage = Message(
              address: '+9893****1378',
              text: textController.text,
              date: DateTime.now().millisecondsSinceEpoch,
            );
            final id = await MessagesDB.instance.add(newMessage);
            setState(() {
              newMessage.id = id;
              messages.insert(0, newMessage);
            });
          }
          setState(() {
            textController.clear();
            selectedIndex = null;
          });
        },
      ),
      body: Column(
        children: [
          MyTextField(controller: textController, label: 'Search'),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child:
                  messages.isEmpty
                      ? const Center(child: Text('List is empty'))
                      : ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return SmsCard(
                            message: message,
                            onSend: () async {
                              var status = '';
                              var isOk = false;
                              if (dataStorage.phoneNumber.isNotEmpty) {
                                status = 'Ok!';
                                isOk = true;
                              } else {
                                status = 'Not Valid!';
                                isOk = false;
                              }
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: status,
                                      message: message.text ?? '',
                                      contentType:
                                          isOk
                                              ? ContentType.success
                                              : ContentType.failure,
                                    ),
                                  ),
                                );
                            },
                            onSelect: () {
                              setState(() {
                                if (selectedIndex == null) {
                                  textController.text = message.text ?? '';
                                  selectedIndex = index;
                                } else {
                                  textController.text = '';
                                  selectedIndex = null;
                                }
                              });
                            },
                            onDelete: () {
                              setState(() async {
                                await MessagesDB.instance.remove(message.id!);
                                messages.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

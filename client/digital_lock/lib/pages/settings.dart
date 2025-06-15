import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import '../widgets/textfield_card.dart';

import '../utils/sms.dart';
import '../utils/data_storage.dart';

import '../consts.dart';

import './app_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final dataStorage = Provider.of<DataStorage>(context);

    var welcomeMessageChanged = false;
    final welcomeMessageController = TextEditingController();

    var errorMessageChanged = false;
    final errorMessageController = TextEditingController();

    var phoneNumberChanged = false;
    final phoneNumberController = TextEditingController();

    var passwordChanged = false;
    final passwordController = TextEditingController();

    var relayTimeChanged = false;
    final relayTimeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Settings')),
        leading: IconButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AppSettingsPage()),
            );
          },
          icon: const Icon(Icons.settings),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFieldCard(
                  title: 'Welcome Message',
                  description: 'Set Welcome Message',
                  controller: welcomeMessageController,
                  onActive: (isActive) {
                    welcomeMessageChanged = isActive!;
                  },
                ),
                TextFieldCard(
                  title: 'Error Message',
                  description: 'Set Error Message',
                  controller: errorMessageController,
                  onActive: (isActive) {
                    errorMessageChanged = isActive!;
                  },
                ),
                TextFieldCard(
                  title: 'Phone Number',
                  description: 'Set Mobile Phone Number',
                  controller: phoneNumberController,
                  inputType: TextInputType.number,
                  onActive: (isActive) {
                    phoneNumberChanged = isActive!;
                  },
                ),
                TextFieldCard(
                  title: 'Password',
                  description: 'Set New Password',
                  controller: passwordController,
                  onActive: (isActive) {
                    passwordChanged = isActive!;
                  },
                ),
                TextFieldCard(
                  title: 'Relay Time',
                  description: 'Set Relay Time',
                  controller: relayTimeController,
                  inputType: TextInputType.number,
                  suffixText: 'S',
                  onActive: (isActive) {
                    relayTimeChanged = isActive!;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final req = {};
              req['code'] = Mode.GET_SETTINGS_FROM_SMS.index;
              if (dataStorage.phoneNumber.isEmpty) {
                return;
              }

              if (welcomeMessageChanged) {
                req['welMes'] = welcomeMessageController.text;
              }

              if (errorMessageChanged) {
                req['errMes'] = errorMessageController.text;
              }

              if (phoneNumberChanged) {
                req['phoneNum'] = phoneNumberController.text;
              }

              if (passwordChanged) {
                req['passw'] = passwordController.text;
              }

              if (relayTimeChanged) {
                req['relayTime'] = relayTimeController.text;
              }

              final reqMessage = jsonEncode(req);
              await sendSms(dataStorage.phoneNumber, reqMessage);
            },
            child: const Row(
              children: [Text('Send New Settings'), Icon(Icons.send)],
            ),
          ),
        ],
      ),
    );
  }
}

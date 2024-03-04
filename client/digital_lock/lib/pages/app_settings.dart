import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/switch_card.dart';
import '../widgets/phone_number_input.dart';

import '../utils/theme.dart';
import '../utils/data_storage.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    final dataStorage = Provider.of<DataStorage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('App Settings'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SwitchCard(
                text: "Enable Dark Mode",
                value: appTheme.darktheme,
                onChanged: (value) {
                  setState(() {
                    appTheme.tagglethememode();
                  });
                }),
            Card(
              child: () {
                final phoneInput = PhoneNumberInput(
                  onStateChanged: (isValid, phoneNumber) {
                    if (isValid) {
                      dataStorage.setPhoneNumber(phoneNumber);
                    }
                  },
                );
                phoneInput.phoneController.text = dataStorage.phoneNumber;
                return phoneInput;
              }(),
            ),
          ],
        ),
      ),
    );
  }
}

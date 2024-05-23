import 'package:digital_lock/utils/data_storage.dart';
import 'package:digital_lock/widgets/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home.dart';
import './settings.dart';
import './users.dart';

import '../widgets/salomon_bottom_bar.dart';

import '../utils/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _children = const [
    HomePage(),
    UserPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dataStorage = Provider.of<DataStorage>(context, listen: false);
      if (dataStorage.phoneNumber.isEmpty) {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Phone Number is not set',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Please enter the phone number:'),
                  PhoneNumberInput(
                    onStateChanged: (isValid, phoneNumber) {
                      if (isValid) {
                        dataStorage.setPhoneNumber(phoneNumber);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (dataStorage.phoneNumber.isNotEmpty) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Set'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    final pageitems = [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text('Home'),
        selectedColor: Colors.green,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.supervised_user_circle),
        title: const Text('Users'),
        selectedColor: Colors.purple,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.settings),
        title: const Text('Settings'),
        selectedColor: Colors.orange,
      ),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            appTheme.changeThemeColor(pageitems[index].selectedColor!);
          });
        },
        currentIndex: _currentIndex,
        items: pageitems,
      ),
    );
  }
}

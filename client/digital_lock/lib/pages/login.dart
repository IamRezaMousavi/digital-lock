import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './main.dart';

import '../widgets/my_textfield.dart';

import '../utils/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    final appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Digital Lock'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: appTheme.darktheme
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined),
                onPressed: () {
                  appTheme.tagglethememode();
                },
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/icon.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 50),
                MyTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                ),
                MyTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                FilledButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

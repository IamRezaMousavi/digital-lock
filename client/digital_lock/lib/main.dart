import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/login.dart';

import './utils/theme.dart';
import './utils/data_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => DataStorage())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: appTheme.themecolor,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: appTheme.themecolor,
        useMaterial3: true,
      ),
      themeMode: appTheme.darktheme ? ThemeMode.dark : ThemeMode.light,
      home: const LoginPage(),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/models.dart';
import '../utils/db.dart';

import '../widgets/awesome_snackbar.dart';
import '../widgets/my_textfield.dart';
import '../widgets/user_card.dart';

import './app_settings.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  int? selectedIndex;
  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  Future<void> initState() async {
    await UsersDB.instance.getUsers().then((usersList) {
      setState(() {
        users = usersList;
      });
    });
    super.initState();
  }

  Future<void> _refresh() => Future.delayed(const Duration(seconds: 4));

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Users'),
        ),
        leading: IconButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AppSettingsPage(),
            ));
          },
          icon: const Icon(Icons.settings),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: selectedIndex != null
            ? const Icon(Icons.edit)
            : const Icon(Icons.add),
        onPressed: () async {
          if (selectedIndex != null) {
            final user = users[selectedIndex!];
            final newUser = User(
              id: user.id,
              name: nameController.text,
              date: user.date,
            );
            await UsersDB.instance.update(newUser);
            setState(() {
              users[selectedIndex!] = newUser;
            });
          } else {
            final newUser = User(
              name: nameController.text,
              date: DateTime.now().millisecondsSinceEpoch,
            );
            final id = await UsersDB.instance.add(newUser);
            setState(() {
              newUser.id = id;
              users.insert(0, newUser);
            });
          }
          setState(() {
            nameController.clear();
            idController.clear();
            selectedIndex = null;
          });
        },
      ),
      body: Column(
        children: [
          MyTextField(
            controller: idController,
            label: 'ID',
            textInputType: TextInputType.number,
          ),
          MyTextField(
            controller: nameController,
            label: 'Name',
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: _refresh,
            child: users.isEmpty
                ? const Center(
                    child: Text('There is No User'),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserCard(
                        user: user,
                        onSend: () {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Ok',
                                message: 'Please don`t press again',
                                contentType: ContentType.success,
                              ),
                            ));
                        },
                        onSelect: () {
                          setState(() {
                            if (selectedIndex == null) {
                              nameController.text = user.name;
                              idController.text = user.id.toString();
                              selectedIndex = index;
                            } else {
                              nameController.clear();
                              idController.clear();
                              selectedIndex = null;
                            }
                          });
                        },
                        onDelete: () {
                          setState(() async {
                            await UsersDB.instance.remove(user.id!);
                            users.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          )),
        ],
      ),
    );
}

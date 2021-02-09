import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final MyUser myUser;
  const HomeAppBar(this.myUser);
  @override
  Widget build(BuildContext context, watch) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Clinic App',
          style: const TextStyle(
            letterSpacing: 2,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          PopupMenuButton(
            elevation: 5,
            onSelected: (String value) {
              debugPrint(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                enabled: true,
                height: 30,
                // value: 'Value1',
                child: Row(
                  children: [
                    const Text('Check my messages'),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Colors.red,
                      child: Text(
                        '2',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                enabled: true,
                height: 30,
                child: InkWell(
                  onTap: () {
                    context.read(authProvider).logout();
                    Navigator.of(context).pop();
                  },
                  child: Text('Sign out'),
                ),
              ),
            ],
            child: Stack(
              children: [
                CircleAvatar(
                  maxRadius: 22,
                  backgroundColor: Colors.blueGrey,
                  child: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: (myUser != null)
                        ? NetworkImage(myUser.photo)
                        : const AssetImage('assets/images/empty_user.png'),
                  ),
                ),
                const CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

import 'package:clinic_app/models/users_model.dart';
import 'package:flutter/material.dart';

Widget homeAppBar(MyUser myUser) {
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
              value: 'Value1',
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
            const PopupMenuItem<String>(
              value: 'Value2',
              child: Text('Sign out'),
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

import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'contact_creator_dialog.dart';

class NavigationDrawer extends StatelessWidget {
  final MyUser myUser;

  const NavigationDrawer({
    this.myUser,
  }) : assert(myUser != null);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CreateDrawerHeader(myUser: myUser),
            CreateDrawerBodyItems(),
          ],
        ),
      ),
    );
  }
}

class CreateDrawerBodyItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerBodyItem(
            icon: Icons.people_outlined,
            text: 'My patients',
            onTap: () {
              Navigator.of(context).popAndPushNamed('/full-patients-list-page');
            }),
        DrawerBodyItem(
            icon: Icons.medical_services_outlined,
            text: 'Available medicines',
            onTap: () {
              Navigator.of(context).popAndPushNamed('/medicines-list-page');
            }),
        DrawerBodyItem(
            icon: Icons.room_preferences_outlined,
            text: 'Rooms detail',
            onTap: () {
              Navigator.of(context).popAndPushNamed('/rooms-list-page');
            }),
        DrawerBodyItem(
            icon: Icons.schedule_outlined,
            text: 'My schedule',
            onTap: () {
              Navigator.of(context).popAndPushNamed('/schedule-page');
            }),
        const Divider(),
        DrawerBodyItem(
          icon: Icons.login_outlined,
          text: 'Sign Out',
          onTap: () {
            context.read(authProvider).logout();
          },
        ),
        ListTile(
          title: const Text('Contact'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox();
                });
          },
        ),
        const Divider(),
        Consumer(
          builder: (_, watch, __) {
            return ListTile(
              leading: DayNightSwitcher(
                isDarkModeEnabled: watch(themeProvider).darkTheme,
                onStateChanged: (val) {
                  context.read(themeProvider).setDarkTheme(val);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class CreateDrawerHeader extends StatelessWidget {
  final MyUser myUser;

  const CreateDrawerHeader({
    this.myUser,
  }) : assert(myUser != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      height: 190,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                maxRadius: 54,
                backgroundColor: Colors.blueGrey,
                child: CircleAvatar(
                  maxRadius: 52,
                  backgroundImage: (myUser != null)
                      ? NetworkImage(myUser.photo)
                      : const AssetImage('assets/images/empty_user.png'),
                ),
              ),
            ),
            Center(
                child: (myUser != null)
                    ? Text(
                        'Dr. ${myUser.firstName} ${myUser.lastName}',
                        style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      )
                    : const Text('')),
          ],
        ),
      ),
    );
  }
}

class DrawerBodyItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;

  const DrawerBodyItem({
    @required this.icon,
    @required this.text,
    @required this.onTap,
  })  : assert(icon != null),
        assert(text != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class NavigationDrawer extends StatelessWidget {
  final MyUser myUser;
  const NavigationDrawer({this.myUser});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          CreateDrawerHeader(myUser),
          CreateDrawerBodyItems(),
        ],
      ),
    );
  }
}

class CreateDrawerBodyItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerBodyItem(Icons.people_outlined, 'My patients', () {
          Navigator.of(context).popAndPushNamed('/full-patients-list-page');
        }),
        DrawerBodyItem(Icons.medical_services_outlined, 'Available medicines',
            () {
          Navigator.of(context).popAndPushNamed('/medicines-list-page');
        }),
        DrawerBodyItem(Icons.room_preferences_outlined, 'Rooms detail', () {
          Navigator.of(context).popAndPushNamed('/rooms-list-page');
        }),
        DrawerBodyItem(Icons.schedule_outlined, 'My schedule', () {
          Navigator.of(context).popAndPushNamed('/schedule-page');
        }),
        const Divider(),
        DrawerBodyItem(Icons.login_outlined, 'Sign Out', () {
          context.read(authProvider).logout();
        }),
        ListTile(
          title: const Text('App version 1.0.0'),
          onTap: () {
            _showDialog(context);
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
  const CreateDrawerHeader(this.myUser);
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

Widget checkPhoto(MyUser myUser) {
  return Container();
}

class DrawerBodyItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  const DrawerBodyItem(this.icon, this.text, this.onTap);
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

Future _showDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text('Clinic App'),
            content: Container(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('App version 1.0.0'),
                  const Text('Contact creator'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

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
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            CreateDrawerHeader(myUser),
            createDrawerBodyItem(
                icon: Icons.people_outlined,
                text: 'My patients',
                onTap: () {
                  Navigator.of(context)
                      .popAndPushNamed('/full-patients-list-page');
                }),
            createDrawerBodyItem(
                icon: Icons.medical_services_outlined,
                text: 'Available medicines',
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/medicines-list-page');
                }),
            createDrawerBodyItem(
                icon: Icons.room_preferences_outlined,
                text: 'Rooms detail',
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/rooms-list-page');
                }),
            createDrawerBodyItem(
                icon: Icons.schedule_outlined,
                text: 'My schedule',
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/schedule-page');
                }),
            const Divider(),
            createDrawerBodyItem(
                icon: Icons.login_outlined,
                text: 'Sign Out',
                onTap: () {
                  context.read(authProvider).logout();
                }),
            const Divider(),
            ListTile(
              title: const Text('App version 1.0.0'),
              onTap: () {
                _showDialog(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Consumer(
                builder: (_, watch, __) {
                  return DayNightSwitcher(
                    // isDarkModeEnabled: watch(myThemeDataProvider).myThemeState,
                    isDarkModeEnabled: false,
                    onStateChanged: (isDarkModeEnabled) {
                      // context
                      //     .read(myThemeDataProvider)
                      //     .changeMyTheme(isDarkModeEnabled);
                      isDarkModeEnabled = !isDarkModeEnabled;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
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

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  const CommonAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.blueGrey),
      leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronCircleLeft,
              size: 25, color: Colors.blueGrey[500]),
          onPressed: () => Navigator.of(context).pop()),
      title: Text(
        '$title',
        style: TextStyle(color: Colors.blueGrey[700]),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.0);
}

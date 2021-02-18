import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:clinic_app/pages/common_states_widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class VideoChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CommonAppBar('Video chat'),
      body: Stack(
        children: [
          AppCommonBackground(),
          Center(
            child: Text('Under construction'),
          ),
        ],
      ),
    );
  }
}

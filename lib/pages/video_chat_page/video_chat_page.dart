import 'package:clinic_app/core/common_states_widgets/app_common_background.dart';
import 'package:clinic_app/core/common_states_widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/models/users_model.dart';

class VideoChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CommonAppBar('Video chat - ${patient.firstName}'),
      body: Stack(
        children: [
          const AppCommonBackground(),
          Center(
            child: Text('Under construction'),
          ),
        ],
      ),
    );
  }
}

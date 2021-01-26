import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/providers/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FullPatientsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read(patientProvider).getAllPatients();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'My patients',
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: -200,
            bottom: -200,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 500,
            ),
          ),
          Positioned(
            right: -200,
            top: -200,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 500,
            ),
          ),
          Container(
            child: Consumer(
              builder: (context, watch, child) {
                final state = watch(patientProvider.state);
                if (state is PatientInitial) {
                  return Center(child: Text(''));
                } else if (state is PatientLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PatientLoaded) {
                  return BuildPatientsList(state?.patientList);
                } else if (state is PatientError) {
                  return BuildError(state.message);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BuildError extends ConsumerWidget {
  final String message;
  BuildError(this.message);
  @override
  Widget build(BuildContext context, watch) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$message'),
            MaterialButton(
                child: Text('Try again'),
                onPressed: () {
                  context.read(patientProvider).getAllPatients();
                }),
          ],
        ),
      ),
    );
  }
}

class BuildPatientsList extends StatelessWidget {
  final List<MyUser> patients;
  BuildPatientsList(this.patients);

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      borderWidth: 1.0,
      springAnimationDurationInMilliseconds: 500,
      animSpeedFactor: 1.5,
      height: 80,
      color: Colors.blueGrey,
      onRefresh: () async {
        await context.read(patientProvider).getAllPatients();
      },
      child: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          if (patients.isNotEmpty) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/patient-detail-page',
                        arguments: patients[index]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      backgroundColor: Colors.blueGrey[300],
                      child: CircleAvatar(
                        maxRadius: 28,
                        minRadius: 28,
                        backgroundImage: NetworkImage(patients[index].photo),
                      ),
                    ),
                    title: Text(
                        '${patients[index].firstName} ${patients[index].lastName}'),
                    subtitle: Text('${patients[index].email}'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                Divider(indent: 20, endIndent: 20, thickness: 1),
              ],
            );
          }
          return Center(child: Text('No patients to show'));
        },
      ),
    );
  }
}

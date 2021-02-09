import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/services/patient_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FullPatientsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final getAllPatients = watch(getAllPatientsFutureProvider);
    return getAllPatients.when(
      loading: () => BuildLoading(),
      error: (Object error, stack) => BuildError(error.toString()),
      data: (list) => BuildPatientsListData(list),
    );
  }
}

class BuildPatientsListData extends StatelessWidget {
  final List<MyUser> patientsList;
  const BuildPatientsListData(this.patientsList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        showChildOpacityTransition: true,
        borderWidth: 1.0,
        springAnimationDurationInMilliseconds: 500,
        animSpeedFactor: 1.5,
        height: 80,
        color: Colors.blueGrey,
        onRefresh: () async {
          await context.refresh(getAllPatientsFutureProvider);
        },
        child: Stack(
          children: [
            PatientListBackgroud(),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                BuildSliverAppBar(),
                BuildSliverPatientsList(patientsList),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSliverPatientsList extends StatelessWidget {
  final List<MyUser> patients;
  const BuildSliverPatientsList(this.patients);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (patients.isNotEmpty) {
            return Column(
              children: [
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/patient-detail-page',
                        arguments: patients[index]);
                  },
                  child: FadeInRight(
                    duration: Duration(milliseconds: 80 * index),
                    child: ListTile(
                      leading: Hero(
                        tag: patients[index].userId,
                        child: CircleAvatar(
                          maxRadius: 30,
                          minRadius: 30,
                          backgroundColor: Colors.blueGrey[300],
                          child: CircleAvatar(
                            maxRadius: 28,
                            minRadius: 28,
                            backgroundImage:
                                NetworkImage(patients[index].photo),
                          ),
                        ),
                      ),
                      title: Text(
                          '${patients[index].firstName} ${patients[index].lastName}'),
                      subtitle: Text('${patients[index].email}'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                Divider(indent: 20, endIndent: 20, thickness: 1),
              ],
            );
          } else {
            return Center(child: Text('No patients to show'));
          }
        },
        childCount: patients.length,
      ),
    );
  }
}

class BuildSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronCircleLeft,
            size: 25,
            color: Colors.blueGrey[500],
          ),
          onPressed: () => Navigator.of(context).pop()),
      title: Text(
        'My patients',
        style: TextStyle(color: Colors.blueGrey[900]),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      automaticallyImplyLeading: false,
      expandedHeight: 120.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
                bottom: -40,
                right: -40,
                child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      color: Colors.blueGrey[300],
                    ))),
            Positioned(
                top: -20,
                left: -20,
                child: Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      color: Colors.blueGrey[100],
                    ))),
          ],
        ),
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  final MyUser patient;
  const PatientTile(this.patient);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 30,
        minRadius: 30,
        backgroundColor: Colors.blueGrey[300],
        child: CircleAvatar(
          maxRadius: 28,
          minRadius: 28,
          backgroundImage: NetworkImage(patient.photo),
        ),
      ),
      title: Text('${patient.firstName} ${patient.lastName}'),
      subtitle: Text('${patient.email}'),
      trailing: Icon(Icons.chevron_right),
    );
  }
}

class PatientListBackgroud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }
}

import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_appbar.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_body_page.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_drawer_page.dart';
import 'package:clinic_app/pages/lost_connection_page/lost_connection_page.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final myUser = watch(getFutureMyUser);
    return ConnectivityBuilder(
      builder: (context, isConnected, status) {
        if (isConnected != null && isConnected) {
          return myUser.when(
            loading: () => BuildLoading(),
            error: (err, stack) => BuildError(err),
            data: (myUser) => BuildHomePageLoaded(myUser),
          );
        } else {
          return ConnectionLostPage();
        }
      },
    );
  }
}

class BuildHomePageLoaded extends StatelessWidget {
  final MyUser myUser;
  const BuildHomePageLoaded(this.myUser);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(myUser),
      drawer: NavigationDrawer(
        myUser: myUser,
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        borderWidth: 1.0,
        springAnimationDurationInMilliseconds: 500,
        animSpeedFactor: 1.5,
        height: 80,
        color: Colors.blueGrey,
        onRefresh: () => context.refresh(getFutureMyUser),
        child: HomeBodyPage(myUser: myUser),
      ),
    );
  }
}

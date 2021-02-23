import 'package:clinic_app/core/common_states_widgets/build_error.dart';
import 'package:clinic_app/core/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_appbar.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_body_page.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_drawer_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final myUser = watch(getFutureMyUser);
    return myUser.when(
      loading: () => const BuildLoading(),
      error: (error, stack) => BuildError(message: error),
      data: (myUser) => BuildHomePageLoaded(myUser: myUser),
    );
  }
}

class BuildHomePageLoaded extends StatelessWidget {
  final MyUser myUser;

  const BuildHomePageLoaded({
    Key key,
    @required this.myUser,
  })  : assert(myUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(myUser: myUser),
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

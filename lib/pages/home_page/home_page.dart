import 'package:clinic_app/pages/home_page/home_page_widgets/home_appbar.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_body_page.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_drawer_page.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final myUser = watch(getFutureMyUser);
    return ConnectivityBuilder(
      builder: (context, isConnected, status) {
        if (isConnected != null && isConnected) {
          return myUser.when(
            loading: () => const Scaffold(
                body: Center(child: CircularProgressIndicator())),
            error: (err, stack) => Center(
                child: Text(
                    'Error, try reloading the screen throught pulling down: $err')),
            data: (myUser) {
              return Scaffold(
                appBar: homeAppBar(myUser),
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
            },
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Check your internet connection'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(strokeWidth: 1),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

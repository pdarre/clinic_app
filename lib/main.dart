import 'package:clinic_app/pages/selector_page/selector_page.dart';
import 'package:clinic_app/utils/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

FirebaseAnalytics analytics = FirebaseAnalytics();

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: watch(myThemeDataProvider).myTheme,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: Scaffold(
        body: FutureBuilder(
          future: initFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SelectorPage();
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      routes: MyRoutes.routes,
    );
  }
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
}

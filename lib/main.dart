import 'package:flutter/material.dart';
import 'core/common_states_widgets/build_error.dart';
import 'core/common_states_widgets/build_loading.dart';
import 'core/utils/routes.dart';
import 'pages/home_page/home_page.dart';
import 'pages/login_page/login_page.dart';
import 'pages/lost_connection_page/lost_connection_page.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers_access/providers.dart';
import 'providers/theme_provider/themes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // timeDilation = 3.0;
  runApp(
    ProviderScope(child: MyApp()),
  );
}

FirebaseAnalytics analytics = FirebaseAnalytics();

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final isDarkFromPreferences = watch(retrieveThemeFromPreferences);
    context.read(themeProvider).getThemeFromPreferences();
    return ConnectivityBuilder(
      builder: (context, isConnected, status) {
        if (isConnected != null && isConnected) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: isDarkFromPreferences.when(
              loading: () => const BuildLoading(),
              error: (error, stack) => BuildError(message: error),
              data: (isDark) => BuildInitialPage(isDark: isDark),
            ),
          );
        } else {
          return MaterialApp(
            home: LostConnectionPage(),
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class BuildInitialPage extends StatelessWidget {
  bool isDark;
  BuildInitialPage({this.isDark});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        isDark = watch(themeProvider).darkTheme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? ThemeData.dark() : ThemeData.light(),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          home: AuthenticationWrapper(),
          routes: MyRoutes.routes,
        );
      },
    );
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final firebaseUser = watch(userAuthStream);
    return firebaseUser.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text(error.toString()))),
      data: (user) => user != null ? HomePage() : LoginPage(),
    );
  }
}

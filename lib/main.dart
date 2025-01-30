import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutr/core/riverpod_observer.dart';
import 'package:tutr/core/singletons/shared_prefs.dart';
import 'package:tutr/routes/generated_routes.dart';
import 'package:tutr/routes/route_names.dart';
import 'package:tutr/routes/routes_navigation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(ProviderScope(observers: [TuTrRiverpodObserver()], child: MyApp()));
}

class MyApp extends StatelessWidget with GeneratedRoutes {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.welcomeScreen,
      onGenerateRoute: (settings) {
        return RoutesNavigation().generate(settings);
      },
    );
  }
}

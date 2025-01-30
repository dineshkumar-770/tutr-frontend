import 'package:flutter/cupertino.dart';
import 'package:tutr/models/route_arguments/auth_arguments.dart';
import 'package:tutr/routes/generated_routes.dart';
import 'package:tutr/routes/route_names.dart';

class RoutesNavigation with GeneratedRoutes {
 Route<dynamic>? generate(settings) {
    switch (settings.name) {
      case RouteNames.welcomeScreen:
        return CupertinoPageRoute(
          builder: (context) => routes[RouteNames.welcomeScreen]!(context, {}),
        );

      case RouteNames.loginTeacher:
        return CupertinoPageRoute(
          builder: (context) => routes[RouteNames.loginTeacher]!(context, settings.arguments as UserAuthType),
        );

      case RouteNames.loginStudent:
        return CupertinoPageRoute(
          builder: (context) => routes[RouteNames.loginStudent]!(context, settings.arguments as UserAuthType),
        );

      case RouteNames.registerStudent:
        return CupertinoPageRoute(
          builder: (context) => routes[RouteNames.registerStudent]!(context, settings.arguments as UserAuthType),
        );
      default:
        return null;
    }
  }
}

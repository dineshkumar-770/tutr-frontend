import 'package:flutter/material.dart';
import 'package:tutr/models/route_arguments/auth_arguments.dart';
import 'package:tutr/routes/route_names.dart';
import 'package:tutr/views/screens/auth/login_screen.dart';
import 'package:tutr/views/screens/auth/register_screen.dart';
import 'package:tutr/views/screens/root_view/welcome_screen.dart';

mixin GeneratedRoutes {
  final Map<String, Widget Function(BuildContext, dynamic)> _routes = {
    RouteNames.loginTeacher: (context, args) => LoginScreen(authType: args as UserAuthType),
    RouteNames.welcomeScreen: (context, args) => WelcomeScreen(),
    RouteNames.loginStudent: (context, args) => LoginScreen(authType: args as UserAuthType),
    RouteNames.registerStudent: (context, args) => RegisterScreen(registerType: args as UserAuthType)
  };

  Map<String, Widget Function(BuildContext, dynamic)> get routes {
    return _routes;
  }
}

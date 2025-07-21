import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/routes/app_route_navigations.dart';
import 'package:tutr_frontend/utils/adeptiveness.dart';
import 'package:tutr_frontend/utils/bloc_observer.dart';
import 'package:tutr_frontend/viewmodels/auth_bloc/bloc/auth_bloc.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  initializeLocationDI();
  Bloc.observer = MyBlocObserver();
  await Prefs.init();
  runApp(ToastificationWrapper(child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRoutesNavigation _appRoutesNavigation = AppRoutesNavigation();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(context: context),
        ),
        BlocProvider.value(value: locatorDI<HomeScreenBloc>()),
        BlocProvider<TeacherViewGroupBloc>(
          create: (context) => TeacherViewGroupBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: AppRouteNames.splashScreen,
        onGenerateRoute: (settings) {
          return _appRoutesNavigation.generate(settings);
        },
      ),
    );
  }
}

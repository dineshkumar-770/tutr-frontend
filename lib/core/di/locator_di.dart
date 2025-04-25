import 'package:get_it/get_it.dart';
import 'package:tutr_frontend/core/common/app_popups.dart';
import 'package:tutr_frontend/core/repository/api_calls.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';

final GetIt locatorDI = GetIt.instance;

void initializeLocationDI() {
  locatorDI.registerLazySingleton<ApiCalls>(
    () => ApiCalls(),
  );

  locatorDI.registerLazySingleton<Helper>(
    () => Helper(),
  );

  locatorDI.registerLazySingleton<HomeScreenBloc>(
    () => HomeScreenBloc(),
  );

  locatorDI.registerLazySingleton<AppPopups>(
    () => AppPopups(),
  );
}

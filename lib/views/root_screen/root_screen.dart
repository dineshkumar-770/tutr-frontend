import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';
import 'package:tutr_frontend/viewmodels/root_screen_bloc/cubit/root_screen_cubit.dart';
import 'package:tutr_frontend/views/app_settings/app_settings.dart';
import 'package:tutr_frontend/views/create_group/create_group_screen.dart';
import 'package:tutr_frontend/views/home_screen/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userType = locatorDI<Helper>().getUserType();
    // final isTeacher = userType == ConstantStrings.teacher;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<RootScreenDartCubit, RootScreenDartState>(
          builder: (context, state) {
            if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) {
              return _buildTeacherView(state.navBarItems);
            } else if (locatorDI<Helper>().getUserType() == ConstantStrings.student) {
              return _buildStudentView(state.navBarItemsForStudent);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<RootScreenDartCubit, RootScreenDartState>(
        builder: (context, state) {
          if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) {
            return BottomNavigationBar(
              backgroundColor: AppColors.backgroundColor,
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              enableFeedback: true,
              elevation: 1,
              iconSize: 25,
              selectedFontSize: 12,
              selectedItemColor: AppColors.primaryColor,
              unselectedFontSize: 10,
              onTap: (value) {
                if (value == 1 || value == 2) {
                  context.read<HomeScreenBloc>().add(FetchUserProfileEvent(context: context));
                }
                context.read<RootScreenDartCubit>().switchBottomBar(value, locatorDI<Helper>().getUserType());
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view),
                  label: "Home",
                  activeIcon: Icon(Icons.grid_view_rounded),
                  tooltip: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: "Create Group",
                  activeIcon: Icon(Icons.group_rounded),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: "Settings",
                  activeIcon: Icon(Icons.settings),
                ),
              ],
            );
          } else if (locatorDI<Helper>().getUserType() == ConstantStrings.student) {
            return BottomNavigationBar(
              backgroundColor: AppColors.backgroundColor,
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              enableFeedback: true,
              elevation: 1,
              iconSize: 25,
              selectedFontSize: 12,
              selectedItemColor: AppColors.primaryColor,
              unselectedFontSize: 10,
              onTap: (value) {
                if (value == 1) {
                  context.read<HomeScreenBloc>().add(FetchUserProfileEvent(context: context));
                }
                context.read<RootScreenDartCubit>().switchBottomBar(value, locatorDI<Helper>().getUserType());
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view),
                  label: "Home",
                  activeIcon: Icon(Icons.grid_view_rounded),
                  tooltip: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: "Settings",
                  activeIcon: Icon(Icons.settings),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildStudentView(NavBarItemsForStudent navBarItems) {
    switch (navBarItems) {
      case NavBarItemsForStudent.HOME:
        return BlocProvider(
          create: (context) => HomeScreenBloc()..add(FetchHomeScreenDataEvent()),
          child: HomeScreen(),
        );
      case NavBarItemsForStudent.SETTINGS:
        return AppSettings();

      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTeacherView(
    NavBarItems navBarItems,
  ) {
    switch (navBarItems) {
      case NavBarItems.HOME:
        return BlocProvider(
          create: (context) => HomeScreenBloc()..add(FetchHomeScreenDataEvent()),
          child: HomeScreen(),
        );

      case NavBarItems.CREATEGROUP:
        // Ye tab student ke liye kabhi activate nahi hoga, so safe to skip
        return CreateGroupScreen();

      case NavBarItems.SETTINGS:
        return AppSettings();

      case NavBarItems.TuTrREELS:
        return Center(child: Text("TuTr REELS Coming soon!"));
    }
  }
}

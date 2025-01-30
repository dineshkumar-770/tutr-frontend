import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tutr/features/groups_and_manage/controller/group_manage_controller.dart';
import 'package:tutr/features/groups_and_manage/views/teacher/create_group.dart';
import 'package:tutr/features/groups_and_manage/views/teacher/teacher_homescreen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootScreenState = ref.watch(groupManageNotifierProvider);
    final providerFunc = ref.read(groupManageNotifierProvider.notifier);
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: rootScreenState.bottomBarIndex,
          onTap: (i) {
            providerFunc.switchBottomBarTab(i);
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.grid_view_outlined),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.group_add_outlined),
              title: Text("Create Group"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.ads_click),
              title: Text("My Promotions"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
        body: indexedScreen(rootScreenState.bottomBarIndex));
  }

  Widget indexedScreen(int index) {
    switch (index) {
      case 0:
        return TeacherHomescreen();

      case 1:
        return CreateGroup();
      case 2:
        return Center(
          child: Text("Screen $index"),
        );
      case 3:
        return Center(
          child: Text("Screen $index"),
        );
      default:
        return SizedBox();
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'root_screen_cubit.dart';

class RootScreenDartState extends Equatable {
  final int currentIndex;
  final NavBarItems navBarItems;
  final NavBarItemsForStudent navBarItemsForStudent;

  const RootScreenDartState({
    required this.currentIndex,
    required this.navBarItems,
    required this.navBarItemsForStudent,
  });

  factory RootScreenDartState.init() {
    return RootScreenDartState(
        currentIndex: 0, navBarItems: NavBarItems.HOME, navBarItemsForStudent: NavBarItemsForStudent.HOME);
  }

  @override
  List<Object> get props => [currentIndex, navBarItems, navBarItemsForStudent];

  RootScreenDartState copyWith({
    int? currentIndex,
    NavBarItems? navBarItems,
    NavBarItemsForStudent? navBarItemsForStudent,
  }) {
    return RootScreenDartState(
      currentIndex: currentIndex ?? this.currentIndex,
      navBarItems: navBarItems ?? this.navBarItems,
      navBarItemsForStudent: navBarItemsForStudent ?? this.navBarItemsForStudent,
    );
  }
}

enum NavBarItems { HOME, CREATEGROUP, SETTINGS, TuTrREELS }

enum NavBarItemsForStudent { HOME, SETTINGS, TuTrREELS }

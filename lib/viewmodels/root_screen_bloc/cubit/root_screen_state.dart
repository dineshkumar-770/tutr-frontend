part of 'root_screen_cubit.dart';

class RootScreenDartState extends Equatable {
  final int currentIndex;
  final NavBarItems navBarItems;

  const RootScreenDartState({
    required this.currentIndex,
    required this.navBarItems,
  });

  factory RootScreenDartState.init() {
    return RootScreenDartState(currentIndex: 0, navBarItems: NavBarItems.HOME);
  }

  @override
  List<Object> get props => [currentIndex, navBarItems];

  RootScreenDartState copyWith({
    int? currentIndex,
    NavBarItems? navBarItems,
  }) {
    return RootScreenDartState(
      currentIndex: currentIndex ?? this.currentIndex,
      navBarItems: navBarItems ?? this.navBarItems,
    );
  }
}

enum NavBarItems { HOME, CREATEGROUP, SETTINGS, TuTrREELS }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'root_screen_state.dart';

class RootScreenDartCubit extends Cubit<RootScreenDartState> {
  RootScreenDartCubit() : super(RootScreenDartState.init());

  void switchBottomBar(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(currentIndex: index, navBarItems: NavBarItems.HOME));
      case 1:
        emit(state.copyWith(currentIndex: index, navBarItems: NavBarItems.CREATEGROUP));
      case 2:
        emit(state.copyWith(currentIndex: index, navBarItems: NavBarItems.SETTINGS));
      case 3:
        emit(state.copyWith(currentIndex: index, navBarItems: NavBarItems.TuTrREELS));
      default:
        emit(state.copyWith(currentIndex: index, navBarItems: NavBarItems.HOME));
    }
  }
}

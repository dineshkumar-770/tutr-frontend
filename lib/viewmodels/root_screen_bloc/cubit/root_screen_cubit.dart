import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';

part 'root_screen_state.dart';

class RootScreenDartCubit extends Cubit<RootScreenDartState> {
  RootScreenDartCubit() : super(RootScreenDartState.init());

  void switchBottomBar(int index, String userType) {
    //NavBarItemsForStudent
    if (userType == ConstantStrings.teacher) {
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
    } else if (userType == ConstantStrings.student) {
      switch (index) {
        case 0:
          emit(state.copyWith(currentIndex: index, navBarItemsForStudent: NavBarItemsForStudent.HOME));
        case 1:
          emit(state.copyWith(currentIndex: index, navBarItemsForStudent: NavBarItemsForStudent.SETTINGS));
        case 2:
          emit(state.copyWith(currentIndex: index, navBarItemsForStudent: NavBarItemsForStudent.TuTrREELS));

        default:
          emit(state.copyWith(currentIndex: index, navBarItemsForStudent: NavBarItemsForStudent.HOME));
      }
    }
  }
}

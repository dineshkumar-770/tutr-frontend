// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeScreenDataEvent extends HomeScreenEvent {
  @override
  List<Object> get props => [];
}

class FetchUserProfileEvent extends HomeScreenEvent {
  final BuildContext context;

  const FetchUserProfileEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class SelectClassForGroupcreationEvent extends HomeScreenEvent {
  final String value;

  const SelectClassForGroupcreationEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class CreateGroupEvent extends HomeScreenEvent {
  final String groupClass;
  final String groupDescription;
  final String groupTitle;
  final BuildContext context;
  const CreateGroupEvent({
    required this.groupClass,
    required this.groupDescription,
    required this.groupTitle,
    required this.context,
  });
  @override
  List<Object> get props => [groupClass, groupDescription, groupTitle,context];
}

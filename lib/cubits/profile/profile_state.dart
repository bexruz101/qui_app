part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileErrorState extends ProfileState {
  final String errorText;
  ProfileErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}

class ProfileSuccessState extends ProfileState {
  final UserData userData;

  ProfileSuccessState({required this.userData});
  
  @override
  List<Object?> get props => [userData];
}

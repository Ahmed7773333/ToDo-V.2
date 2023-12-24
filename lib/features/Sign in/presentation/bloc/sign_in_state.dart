part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class FirstInState extends SignInState {}

class ChoosePhotoState extends SignInState {}

class ChooseNameState extends SignInState {}

class ChoosePasswordState extends SignInState {}

class ChangeShowState extends SignInState {}

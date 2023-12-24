// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class FirstInEvent extends SignInEvent {
  UserDb user;
  FirstInEvent({
    required this.user,
  });
}

class ChoosePhoto extends SignInEvent {
  Uint8List photo;
  ChoosePhoto({
    required this.photo,
  });
}

class ChooseName extends SignInEvent {
  String name;
  ChooseName({
    required this.name,
  });
}

class ChoosePassword extends SignInEvent {
  String password;
  ChoosePassword({
    required this.password,
  });
}

class ChangeShow extends SignInEvent {
  bool isShow;
  ChangeShow({
    required this.isShow,
  });
}

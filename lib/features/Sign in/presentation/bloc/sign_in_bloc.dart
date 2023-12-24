import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/user_db.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  static SignInBloc get(context) => BlocProvider.of(context);
  String name = '';
  String password = '';
  Uint8List image = Uint8List(0);
  bool isShow = true;
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      if (event is FirstInEvent) {
        emit(SignInInitial());
        UserDbHelper.add(event.user);
        emit(FirstInState());
      } else if (event is ChooseName) {
        emit(SignInInitial());
        name = event.name;
        emit(ChooseNameState());
      } else if (event is ChoosePassword) {
        emit(SignInInitial());
        password = event.password;
        emit(ChoosePasswordState());
      } else if (event is ChoosePhoto) {
        emit(SignInInitial());
        image = event.photo;
        emit(ChoosePhotoState());
      } else if (event is ChangeShow) {
        emit(SignInInitial());
        isShow = event.isShow;
        emit(ChangeShowState());
      }
    });
  }
}

// ignore: depend_on_referenced_packages
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/common/enum_status.dart';
import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/usecase/get_create_user.dart';
import 'package:flutter/material.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit(this.getCreateUser) : super(CreateUserInitial());

  final GetCreateUser getCreateUser;
  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final email = TextEditingController();

  init() {
    emit(CreateUserLoaded(null, 'Ouh lalala...', EnumStatus.empty));
  }

  getUserCreated(BuildContext context) async {
    emit(CreateUserLoaded(null, 'Please wait...', EnumStatus.loading));
    final input = InputCreateUserModel(
      firstName: firstName.text, 
      lastName: lastName.text, 
      email: email.text,
    );
    final result = await getCreateUser.fetchCreateUser(input);
    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed')
        )
      );
      emit(CreateUserError(l.toString(), EnumStatus.error));
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successfully')
        )
      );
      emit(CreateUserLoaded(r, 'Create user successfully', EnumStatus.loaded));
    });
  }
}

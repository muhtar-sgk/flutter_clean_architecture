part of 'create_user_cubit.dart';

abstract class CreateUserState {}

class CreateUserInitial extends CreateUserState {}

class CreateUserLoaded extends CreateUserState {
  CreateUserLoaded(this.createUserEntity, this.message, this.enumStatus);
  
  final CreateUserEntity? createUserEntity;
  final String message;
  final EnumStatus enumStatus;
}

class CreateUserError extends CreateUserState {
  CreateUserError(this.message, this.enumStatus);

  final String message;
  final EnumStatus enumStatus;
}

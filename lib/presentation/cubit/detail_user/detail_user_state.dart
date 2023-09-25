part of 'detail_user_cubit.dart';

abstract class DetailUserState {}

class DetailUserInitial extends DetailUserState {}

class DetailUserLoaded extends DetailUserState {
  DetailUserLoaded(this.detailUserEntity, this.message);

  final DetailUserEntity detailUserEntity;
  final String message;
}

class DetailUserError extends DetailUserState {
  DetailUserError(this.message);
  final String message;
}

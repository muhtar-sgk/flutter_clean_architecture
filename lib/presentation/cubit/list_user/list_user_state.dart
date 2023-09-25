part of 'list_user_cubit.dart';

@immutable
abstract class ListUserState {}

class ListUserInitial extends ListUserState {}

class ListUserLoaded extends ListUserState {
  ListUserLoaded(this.list, this.message, {this.page = 1});

  final List<ListUserEntity> list;
  final String message;
  final int page;
}

class ListUserError extends ListUserState {
  ListUserError(this.message);
  
  final String message;
}
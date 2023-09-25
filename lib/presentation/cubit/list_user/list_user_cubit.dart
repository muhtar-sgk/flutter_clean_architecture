// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/usecase/get_list_user.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  ListUserCubit(this.getListUser) : super(ListUserInitial());

  final GetListUser getListUser;
  static final controller = RefreshController();

  getUserList() async {
    final result = await getListUser.fetchListUser(1);
    result.fold((l) {
      emit(ListUserError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(ListUserLoaded(r, 'Fetch user data successfully'));
      controller.refreshCompleted();
    });
  }

  getRefresh() {
    getUserList();
  }

  getLoadMore() async {
    var myState = state as ListUserLoaded;
    int totalPages = myState.page + 1;

    final result = await getListUser.fetchListUser(totalPages);
    result.fold((l) {
      emit(ListUserError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<ListUserEntity> oldData = myState.list;
      List<ListUserEntity> result = [...oldData, ...r];

      emit(ListUserLoaded(result, "Get data successfully", page: totalPages));
      controller.loadComplete();
    }); 
  }
}

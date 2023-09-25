// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/domain/entities/list_comment_entity.dart';
import 'package:clean_architecture/domain/usecase/get_list_comment.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'list_comment_state.dart';

class ListCommentCubit extends Cubit<ListCommentState> {
  ListCommentCubit(this.getListComment) : super(ListCommentInitial());

  final GetListComment getListComment;
  static final controller = RefreshController();

  getCommentList() async {
    final result = await getListComment.fetchListComment(1);
    result.fold((l) {
      emit(ListCommentError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(ListCommentLoaded(r, 'Fetch comment data sucessfully'));
      controller.refreshCompleted();
    });
  }

  getRefresh() {
    getCommentList();
  }

  getLoadMore() async {
    var myState = state as ListCommentLoaded;
    int currentPage = myState.pages + 1;
    print('current pages $currentPage');

    final result = await getListComment.fetchListComment(currentPage);
    result.fold((l) {
      emit(ListCommentError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<ListCommentEntity> oldData = myState.list;
      List<ListCommentEntity> result = [...oldData, ...r];

      emit(ListCommentLoaded(result, 'Fetch comment data sucessfully', pages: currentPage));
      controller.loadComplete();
    });
  }


}

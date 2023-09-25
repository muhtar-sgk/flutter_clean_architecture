import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/usecase/get_list_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_post_state.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit(this.getListPost) : super(ListPostInitial());

  final GetListPost getListPost;
  static final controller = RefreshController();

  getPostList() async {
    final result = await getListPost.fetchListPost(1);
    result.fold((l) {
      emit(ListPostError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(ListPostLoaded(r, "Get data successfully"));
      controller.refreshCompleted();
    });
  }

  getRefresh() {
    getPostList();
  }

  getLoadMore() async {
    var myState = state as ListPostLoaded;
    int totalPages = myState.pages + 1;

    final result = await getListPost.fetchListPost(totalPages);
    result.fold((l) {
      emit(ListPostError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<ListPostEntity> oldData = myState.list;
      List<ListPostEntity> result = [...oldData, ...r];

      emit(ListPostLoaded(result, "Get data successfully", pages: totalPages));
      controller.loadComplete();
    }); 
  }
}

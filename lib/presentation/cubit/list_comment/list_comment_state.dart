part of 'list_comment_cubit.dart';

@immutable
abstract class ListCommentState {}

class ListCommentInitial extends ListCommentState {}

class ListCommentLoaded extends ListCommentState {
  ListCommentLoaded(this.list, this.message, {this.pages = 1});

  final List<ListCommentEntity> list;
  final String message;
  final int pages;
}

class ListCommentError extends ListCommentState {
  ListCommentError(this.message);
  
  final String message;
}

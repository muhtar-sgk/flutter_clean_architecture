import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListPostState {}

class ListPostInitial extends ListPostState {}

class ListPostLoaded extends ListPostState {
  ListPostLoaded(this.list, this.message, {this.pages = 1});

  final List<ListPostEntity> list;
  final String message;
  final int pages;
}

class ListPostError extends ListPostState {
  ListPostError(this.message);
  final String message;
}

import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/data/model/create_user_model.dart';
import 'package:clean_architecture/data/model/detail_user_model.dart';
import 'package:clean_architecture/data/model/list_comment_model.dart';
import 'package:clean_architecture/data/model/list_post_model.dart';
import 'package:clean_architecture/data/model/list_user_model.dart';

abstract class RemoteData {
  Future<List<ListUserModel>> listUserModel(int page);
  Future<List<ListPostModel>> listPostModel(int pages);
  Future<List<ListCommentModel>> listCommentModel(int pages);
  Future<DetailUserModel> detailUserModel(String id);
  Future<CreateUserModel> createUserModel(InputCreateUserModel inputCreateUserModel);
}
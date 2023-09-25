import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/entities/list_comment_entity.dart';
import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:dartz/dartz.dart';
abstract class RepositoriesDomain {
  Future<Either<String, List<ListUserEntity>>> getListUser(int page);
  Future<Either<String, List<ListPostEntity>>> getListPost(int pages);
  Future<Either<String, List<ListCommentEntity>>> getListComment(int pages);
  Future<Either<String, CreateUserEntity>> getCreateUser(InputCreateUserModel inputCreateUserModel);
  Future<Either<String, DetailUserEntity>> getDetailUser(String id);
}
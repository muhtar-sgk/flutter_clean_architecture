import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/data/repositories/remote_data_impl.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/entities/list_comment_entity.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class RepositoryDomainImpl implements RepositoriesDomain {
  const RepositoryDomainImpl(this.remoteDataImpl);
  final RemoteDataImpl remoteDataImpl;

  @override
  Future<Either<String, CreateUserEntity>> getCreateUser(InputCreateUserModel inputCreateUserModel) async {
    try {
      final result = await remoteDataImpl.createUserModel(inputCreateUserModel);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailUserEntity>> getDetailUser(String id) async {
    try {
      final result = await remoteDataImpl.detailUserModel(id);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ListCommentEntity>>> getListComment(int pages) async {
    try {
      final result = await remoteDataImpl.listCommentModel(pages);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ListPostEntity>>> getListPost(int pages) async {
    try {
      final result = await remoteDataImpl.listPostModel(pages);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ListUserEntity>>> getListUser(int page) async {
    try {
      final result = await remoteDataImpl.listUserModel(page);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

}
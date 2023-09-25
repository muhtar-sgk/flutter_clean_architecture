import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetCreateUser {
  const GetCreateUser(this.repositoriesDomain);
  
  final RepositoriesDomain repositoriesDomain;

  Future<Either<String, CreateUserEntity>> fetchCreateUser(InputCreateUserModel inputCreateUserModel) {
    return repositoriesDomain.getCreateUser(inputCreateUserModel);
  }
}
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetDetailUser {
  const GetDetailUser(this.repositoriesDomain);
  
  final RepositoriesDomain repositoriesDomain;

  Future<Either<String, DetailUserEntity>> fetchDetailUser(String id) {
    return repositoriesDomain.getDetailUser(id);
  }
}
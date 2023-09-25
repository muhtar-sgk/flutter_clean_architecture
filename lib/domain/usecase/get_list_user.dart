import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetListUser {
  const GetListUser(this.repositoriesDomain);
  
  final RepositoriesDomain repositoriesDomain;

  Future<Either<String, List<ListUserEntity>>> fetchListUser(int page) {
    return repositoriesDomain.getListUser(page);
  }
}
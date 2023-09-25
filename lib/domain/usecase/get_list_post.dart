import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetListPost {
  const GetListPost(this.repositoriesDomain);
  
  final RepositoriesDomain repositoriesDomain;

  Future<Either<String, List<ListPostEntity>>> fetchListPost(int pages) {
    return repositoriesDomain.getListPost(pages);
  }
}
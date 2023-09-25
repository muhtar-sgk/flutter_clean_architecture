import 'package:clean_architecture/domain/entities/list_comment_entity.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetListComment {
  const GetListComment(this.repositoriesDomain);
  
  final RepositoriesDomain repositoriesDomain;

  Future<Either<String, List<ListCommentEntity>>> fetchListComment(int pages) {
    return repositoriesDomain.getListComment(pages);
  }
}
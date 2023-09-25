import 'package:clean_architecture/data/repositories/remote_data_impl.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:clean_architecture/data/repositories/repository_domain_impl.dart';
import 'package:clean_architecture/domain/usecase/get_create_user.dart';
import 'package:clean_architecture/domain/usecase/get_detail_user.dart';
import 'package:clean_architecture/domain/usecase/get_list_comment.dart';
import 'package:clean_architecture/domain/usecase/get_list_post.dart';
import 'package:clean_architecture/domain/usecase/get_list_user.dart';
import 'package:clean_architecture/presentation/cubit/create_user/create_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/detail_user/detail_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/list_comment/list_comment_cubit.dart';
import 'package:clean_architecture/presentation/cubit/list_post/list_post_cubit.dart';
import 'package:clean_architecture/presentation/cubit/list_user/list_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final locator = GetIt.instance;

void initialize() {
  
  // usecase
  locator.registerFactory(() => GetCreateUser(locator()));
  locator.registerFactory(() => GetDetailUser(locator()));
  locator.registerFactory(() => GetListComment(locator()));
  locator.registerFactory(() => GetListPost(locator()));
  locator.registerFactory(() => GetListUser(locator()));

  // state management cubit
  locator.registerFactory(() => ListUserCubit(locator()));
  locator.registerFactory(() => ListPostCubit(locator()));
  locator.registerFactory(() => ListCommentCubit(locator()));
  locator.registerFactory(() => CreateUserCubit(locator()));
  locator.registerFactory(() => DetailUserCubit(locator()));

  // repository domain implementation 
  locator.registerFactory<RepositoriesDomain>(() => RepositoryDomainImpl(locator()));

  // repository remote data implementatioin
  locator.registerFactory(() => RemoteDataImpl(locator()));

  // external library
  locator.registerFactory(() => Client());
}
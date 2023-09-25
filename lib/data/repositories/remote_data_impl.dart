import 'dart:convert';

import 'package:clean_architecture/common/constant.dart';
import 'package:clean_architecture/common/input_create_user_model.dart';
import 'package:clean_architecture/data/datasource/remote_data.dart';
import 'package:clean_architecture/data/model/list_user_model.dart';
import 'package:clean_architecture/data/model/list_post_model.dart';
import 'package:clean_architecture/data/model/list_comment_model.dart';
import 'package:clean_architecture/data/model/detail_user_model.dart';
import 'package:clean_architecture/data/model/create_user_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataImpl implements RemoteData {
  const RemoteDataImpl(this.client);
  final http.Client client;

  @override
  Future<CreateUserModel> createUserModel(InputCreateUserModel inputCreateUserModel) async {
    final request = await client.post(
      Uri.parse('${Constant.baseUrl}user/create'),
      headers: {
        "app-id": Constant.appId
      },
      body: {
        "firstName": inputCreateUserModel.firstName,
        "lastName": inputCreateUserModel.lastName,
        "email": inputCreateUserModel.email
      }
    );

    final response = jsonDecode(request.body);
    print('Check response $response');
    return CreateUserModel.fromJson(response);
  }

  @override
  Future<DetailUserModel> detailUserModel(String id) async {
    final request = await client.get(
      Uri.parse('${Constant.baseUrl}user/${id}'),
      headers: {
        "app-id": Constant.appId
      },
    );

    final response = jsonDecode(request.body);
    return DetailUserModel.fromJson(response);
  }

  @override
  Future<List<ListCommentModel>> listCommentModel(int pages) async {
    final request = await client.get(
      Uri.parse('${Constant.baseUrl}comment?page=${pages.toString()}&limit=10'),
      headers: {
        "app-id": Constant.appId
      },
    );

    final response = jsonDecode(request.body);
    final List data = response['data'];

    return data.map((e) => ListCommentModel.fromJson(e)).toList();
  }

  @override
  Future<List<ListPostModel>> listPostModel(int pages) async {
    final request = await client.get(
      Uri.parse('${Constant.baseUrl}post?page=${pages}&limit=10'),
      headers: {
        "app-id": Constant.appId
      },
    );

    final response = jsonDecode(request.body);
    final List data = response['data'];

    return data.map((e) => ListPostModel.fromJson(e)).toList();
  }

  @override
  Future<List<ListUserModel>> listUserModel(int page) async {
    final request = await client.get(
      Uri.parse('${Constant.baseUrl}user?page=${page.toString()}&limit=10'),
      headers: {
        "app-id": Constant.appId
      },
    );

    final response = jsonDecode(request.body);
    final List data = response['data'];

    return data.map((e) => ListUserModel.fromJson(e)).toList();
  }
}
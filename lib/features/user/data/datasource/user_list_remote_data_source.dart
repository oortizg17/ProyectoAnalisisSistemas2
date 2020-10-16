import 'dart:convert';

import 'package:ProyectoAnalisis2/core/errors/exception.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class UserListRemoteDataSource {
  Future<User> getUserListRemoteDataSource();
}

class UserListRemoteDataSourceImpl implements UserListRemoteDataSource {
  final http.Client client;
  UserListRemoteDataSourceImpl({@required this.client});
  @override
  Future<User> getUserListRemoteDataSource() =>
      _getTriviaFromUrl('https://reqres.in/api/users');

  Future<User> _getTriviaFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

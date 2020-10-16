import 'dart:convert';

import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class UserListLocalDataSource {
  Future<User> getLastUserList();
  Future<void> cacheUserList(User user);
}

const CACHED_USERLIST = 'CACHE_USER_LIST';

class UserListLocalDataSourceImpl implements UserListLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserListLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<User> getLastUserList() {
    final jsonString = sharedPreferences.getString(CACHED_USERLIST);
    if (jsonString != null) {
      return Future.value(User.fromJson(json.decode(jsonString)));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cacheUserList(User userCache) {
    return sharedPreferences.setString(
        CACHED_USERLIST, json.encode(userCache.toJson()));
  }
}

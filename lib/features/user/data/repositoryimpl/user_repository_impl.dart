import 'package:ProyectoAnalisis2/core/errors/exception.dart';
import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/core/errors/network/network.dart';
import 'package:ProyectoAnalisis2/features/user/data/datasource/user_list_local_data_source.dart';
import 'package:ProyectoAnalisis2/features/user/data/datasource/user_list_remote_data_source.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:ProyectoAnalisis2/features/user/domain/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

typedef Future<User> _ConcreteOrRandomChooser();

class UserRepositoryImpl implements UserRepository {
  final UserListRemoteDataSource remoteDataSource;
  final UserListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getUserList() async {
    return await _getUsers(() {
      return remoteDataSource.getUserListRemoteDataSource();
    });
  }

  Future<Either<Failure, User>> _getUsers(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await getConcreteOrRandom();
        localDataSource.cacheUserList(remoteUser);
        return Right(remoteUser);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUserList();
        return Right(localUser);
      } on CacheException {
        return left(
          CacheFailure(),
        );
      }
    }
  }
}

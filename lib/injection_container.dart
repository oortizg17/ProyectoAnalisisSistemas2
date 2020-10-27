import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/user/presentation/bloc/userbloc/user_bloc.dart';
import 'package:ProyectoAnalisis2/core/errors/network/network.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ProyectoAnalisis2/features/user/domain/usecases/get_list_user.dart';
import 'package:ProyectoAnalisis2/features/user/domain/repository/user_repository.dart';
import 'package:ProyectoAnalisis2/features/user/data/repositoryimpl/user_repository_impl.dart';
import 'package:ProyectoAnalisis2/features/user/data/datasource/user_list_local_data_source.dart';
import 'package:ProyectoAnalisis2/features/user/data/datasource/user_list_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => UserBloc(random: sl()),
  );

//UseCases
  sl.registerLazySingleton(
    () => GetUserList(
      sl(),
    ),
  );

//Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data source
  sl.registerLazySingleton<UserListRemoteDataSource>(
    () => UserListRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<UserListLocalDataSource>(
    () => UserListLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //!Core

  sl.registerLazySingleton<NetworkInfo>(
    () => NetWorkInfoImpl(sl()),
  );

  //!External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  HydratedBloc.storage = await HydratedStorage.build();
}

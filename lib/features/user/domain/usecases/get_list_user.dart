import 'package:dartz/dartz.dart';
import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/core/usecases/usecase.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:ProyectoAnalisis2/features/user/domain/repository/user_repository.dart';


class GetUserList implements UserCase<User, NoParams> {
  final UserRepository repository;

  GetUserList(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async{

    return await repository.getUserList();
  }
  
}
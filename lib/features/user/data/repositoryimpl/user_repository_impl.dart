
import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:ProyectoAnalisis2/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository{




  @override
  Future<Either<Failure, User>> getUserList() {
    

  }
  
}



import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository  {
  
  Future<Either<Failure, User>> getUserList();

}
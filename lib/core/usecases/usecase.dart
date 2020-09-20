import 'package:dartz/dartz.dart';
import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:equatable/equatable.dart';


abstract class UserCase<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}

class  NoParams extends Equatable {
  @override

  List<Object> get props => throw UnimplementedError();
  
}
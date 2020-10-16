import 'dart:async';

import 'package:ProyectoAnalisis2/core/errors/failure.dart';
import 'package:ProyectoAnalisis2/core/usecases/usecase.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:ProyectoAnalisis2/features/user/domain/usecases/get_list_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server faiulure';
const String CACHE_FAILURE_MESSAGE = 'Cached faiulure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - the must  be a positive integer or zero';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final GetUserList getUserList;
  UserBloc({@required GetUserList random})
      : assert(random != null),
        getUserList = random,
        super(Empty() ?? Empty()) {
    hydrate();
  }

  @override
  UserState fromJson(Map<String, dynamic> fromjson) {
    try {
      final writejson = User.fromJson(fromjson);
      return Loaded(user: writejson);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    if (state is Loaded) {
      return state.user.toJson();
    } else {
      return null;
    }
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserForRandom) {
      yield Loading();
      final failureOrRandom = await getUserList(NoParams());
      yield* _eitherLoadOrErrorState(failureOrRandom);
    }
  }

  Stream<UserState> _eitherLoadOrErrorState(
      Either<Failure, User> failureOrRandom) async* {
    yield failureOrRandom.fold(
      (failure) => Error(_mapFailureToMessage(failure)),
      (users) => Loaded(user: users),
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
      break;

    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
      break;
    default:
      return 'Unexpected error';
  }
}

import 'dart:async';

import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'share_data_event.dart';
part 'share_data_state.dart';

class ShareDataBloc extends Bloc<ShareDataEvent, ShareDataState> {
  ShareDataBloc() : super(ShareDataInitial());

  @override
  Stream<ShareDataState> mapEventToState(
    ShareDataEvent event,
  ) async* {
    if (event is ShareDataBetweenPage) {
      yield ShareDataLoaded(event.userInfo);
    } else if (event is ResetState) {
      yield ShareDataInitial();
    }
  }
}

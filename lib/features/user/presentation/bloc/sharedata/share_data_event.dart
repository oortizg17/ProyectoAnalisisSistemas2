part of 'share_data_bloc.dart';

abstract class ShareDataEvent extends Equatable {
  const ShareDataEvent();

  @override
  List<Object> get props => [];
}

class ShareDataBetweenPage extends ShareDataEvent {
  final UserInfo userInfo;

  ShareDataBetweenPage({@required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

class ResetState extends ShareDataEvent {}

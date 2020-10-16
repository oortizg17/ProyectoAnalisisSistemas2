part of 'share_data_bloc.dart';

abstract class ShareDataState extends Equatable {
  const ShareDataState();

  @override
  List<Object> get props => [];
}

class ShareDataInitial extends ShareDataState {}

class ShareDataLoading extends ShareDataState {}

class ShareDataLoaded extends ShareDataState {
  final UserInfo userInfo;

  ShareDataLoaded(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}

import 'package:MVVM_API/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable{
  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState{}

class UsersLoaded extends UsersState{
  final List<User> users;
  UsersLoaded({this.users});
}

class UsersListError extends UsersState{
  final error;
  UsersListError({this.error});
}

class UsersInitState extends UsersState{}
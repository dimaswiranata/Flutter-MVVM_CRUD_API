import 'dart:io';

import 'package:MVVM_API/api/exceptions.dart';
import 'package:MVVM_API/api/services.dart';
import 'package:MVVM_API/bloc/events.dart';
import 'package:MVVM_API/bloc/state.dart';
import 'package:MVVM_API/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UsersEvents, UsersState>{

  final UsersRepo userRepo;
  List<User> user;

  UserBloc({this.userRepo}) : super(UsersInitState());

  @override
  Stream<UsersState> mapEventToState(UsersEvents event) async* {
    switch (event){
      case UsersEvents.fetchUsers:
        yield UsersLoading();
        try{
          user = await userRepo.getUserList();
          yield UsersLoaded(users: user);
        } on SocketException {
          yield UsersListError(
            error: NoInternetException('No Internet')
          );
        } on HttpException {
          yield UsersListError(
            error: NoServiceFoundException('No Service Found')
          );
        } on FormatException {
          yield UsersListError(
            error: InvalidFormatException('Invalid Response Format')
          );
        } catch (e) {
          yield UsersListError(
            error: UnknownException('Unknown Error')
          );
        }
        break;
    }
  }

}
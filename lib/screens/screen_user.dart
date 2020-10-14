import 'package:MVVM_API/bloc/bloc.dart';
import 'package:MVVM_API/bloc/events.dart';
import 'package:MVVM_API/bloc/state.dart';
import 'package:MVVM_API/model/user.dart';
import 'package:MVVM_API/widgets/loading.dart';
import 'package:MVVM_API/widgets/user_card.dart';
import 'package:MVVM_API/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState(){ // spt useEffect di React
    super.initState();
    _loadData();
  }

  _loadData() async {
    context.bloc<UserBloc>().add(UsersEvents.fetchUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<UserBloc, UsersState>(
          builder: (
            BuildContext context,
            UsersState state
          ){
            if(state is UsersListError){
              final error = state.error;
              String message = '${error.message}\nTap to Retry';  // \n => enter
              return ErrorTxt(
                message : message,
                onTap: _loadData,
              );
            }
            if (state is UsersLoaded){
              List<User> users = state.users;
              return _list(users);
            }
            return Loading();
          }
        ),
      ]
    );
  }

  Widget _list(List<User> users){
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index){
          User user = users[index];
          return UserCard(user: user);
        },
      )
    );
  }
}
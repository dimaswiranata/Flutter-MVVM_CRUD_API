import 'package:MVVM_API/model/user.dart';
import 'package:http/http.dart'as http;
import 'dart:convert' as convert;

abstract class UsersRepo{
  Future<List<User>> getUserList();
}

class UserServices implements UsersRepo{
  @override
  Future<List<User>> getUserList() async {
    var apiResult = await http.get("https://reqres.in/api/users?page=2");
    var jsonObject = convert.jsonDecode(apiResult.body);
    List<dynamic> user = (jsonObject as Map<String, dynamic>)['data'];

    List<User> users = [];
    for (int i = 0; i < user.length; i++)
      users.add(User.createUserFromAPI(user[i]));
    return users;
  }
}
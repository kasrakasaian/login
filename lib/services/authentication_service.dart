import 'package:badge/models/user.dart';
import 'package:hive/hive.dart';

import '../models/global_enums.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('user_box');
    //
    // await _users.clear();
    // await _users.add(User('ali', 'pass'));
    // await _users.add(User('kasra', 'pass'));
    // await _users.add(User('reza', 'pass'));
    // await _users.add(User('saied', 'pass'));
  }

  List<User> getUserList() => _users.values.toList();

  List<User> removeThisUserFromList(String user, List<User> users) {
    List<User> res = List<User>.from(users);
    res.removeWhere((element) => element.username == user);
    return res;
  }

  Future<AuthenticationEnum> authenticateUser(
      String username, String pass) async {
    try {
      if(username.toLowerCase() == 'admin' && pass == '123'){
        return AuthenticationEnum.registered;
      }
      final success = _users.values.any((element) =>
          element.username == username && element.password == pass);
      AuthenticationEnum result = success
          ? AuthenticationEnum.registered
          : AuthenticationEnum.notRegistered;
      return result;
    } on Exception catch (_) {
      return AuthenticationEnum.connectionError;
    }
  }

  Future<SignUpEnum> addUser(String username, String pass) async {
    try {
      final sameUser = _users.values.any((element) =>
          element.username.toLowerCase() == username.toLowerCase());
      if (sameUser) {
        return SignUpEnum.uniqueUserError;
      } else {
        await _users.add(User(username, pass));
        return SignUpEnum.successful;
      }
    } on Exception catch (_) {
      return SignUpEnum.connectionError;
    }
  }
}

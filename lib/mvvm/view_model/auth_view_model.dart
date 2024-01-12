import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mapdemo/mvvm/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo=AuthRepository();

  bool _loading =false;
  bool get loading=>_loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data,BuildContext context) async{
      setLoading(true);
      _myRepo.loginApi(data).then((value) {
        if (kDebugMode) {
          print(value['token'].toString());
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
      });
  }
}
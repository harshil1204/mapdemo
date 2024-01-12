import 'package:mapdemo/mvvm/data/network/BaseApiServices.dart';
import 'package:mapdemo/mvvm/data/network/NetworkApiService.dart';
import 'package:mapdemo/mvvm/res/app_url.dart';

class AuthRepository{
  BaseApiServices _apiServices=NetworkApiService();

  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response=await _apiServices.getPostApiSerice(AppUrl.loginUrl, data);
      return response;
    }
    catch(e){
    throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data)async{
    try{
      dynamic response=await _apiServices.getPostApiSerice(AppUrl.signUpUrl, data);
      return response;
    }
    catch(e){
    throw e;
    }
  }


}
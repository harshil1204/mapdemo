import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapdemo/mvvm/data/app_exception.dart';
import 'package:mapdemo/mvvm/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiServices{

  @override
  Future getGetApiService(String url) async{
    dynamic responseJson;
   try{
    final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    responseJson=returnResponse(response);
   }
   on SocketException {
     throw FetchDataException('No Internet Connection');
   }

   return responseJson;
  }

  @override
  Future getPostApiSerice(String url,dynamic data) async{
    dynamic responseJson;
    try{
      final response = await http.post(
        Uri.parse(url),
        body: data
      ).timeout(const Duration(seconds: 10));
      responseJson=returnResponse(response);

    }
    on SocketException{
      throw FetchDataException('Non internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('error occured while comminicating server'+response.statusCode.toString());
    }
  }


}
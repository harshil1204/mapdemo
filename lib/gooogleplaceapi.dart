import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class PlaceaApi extends StatefulWidget {
  const PlaceaApi({super.key});

  @override
  State<PlaceaApi> createState() => _PlaceaApiState();
}

class _PlaceaApiState extends State<PlaceaApi> {
  TextEditingController textEditingController=TextEditingController();
  var uuid=Uuid();
  String _SessionToken="1234";
  List<dynamic> _placeList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(() {
      onChange();
    });
  }

  onChange(){
    if(_SessionToken==null){
    setState(() {
      _SessionToken=uuid.v4();
    });
    }
    getSuggestion(textEditingController.text);

  }

  getSuggestion(String input) async{
    String placeApi="AIzaSyCAfuCBvtXpmsdtzoIypxot4PdD4AgDfQE";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$placeApi&sessiontoken=$_SessionToken';
    var response=await http.get(Uri.parse(request));
    if(response.statusCode==200){
      print(response.body.toString());
    setState(() {

      _placeList=jsonDecode(response.body.toString());
    });
    }
    else{
      throw Exception("failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Search place"),),
      body: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            decoration:InputDecoration(

            ),
          ),
        ],
      ),
    );
  }
}

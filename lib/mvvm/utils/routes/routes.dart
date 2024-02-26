import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapdemo/homescreen.dart';
import 'package:mapdemo/mvvm/utils/routes/routes_name.dart';
import 'package:mapdemo/mvvm/view/home_screen.dart';
import 'package:mapdemo/mvvm/view/login_screen.dart';
import 'package:mapdemo/second/map_page.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args=settings.arguments;
    switch(settings.name){
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);
      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => const MyHomePage(),);
       case RouteName.mapPage:
        return MaterialPageRoute(builder: (context) => const MapPage(),);
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        },);
    }
  }
}
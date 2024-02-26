import 'package:flutter/material.dart';
import 'package:mapdemo/mvvm/utils/routes/routes.dart';
import 'package:mapdemo/mvvm/utils/routes/routes_name.dart';
import 'package:mapdemo/mvvm/view_model/auth_view_model.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel(),),
        ],
            child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteName.mapPage,
      onGenerateRoute: Routes.generateRoute,
      // home: const LoginScreen(),
    ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valetparking/login.dart';

import 'adminviewpark.dart';
import 'keyindetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('jwt');
  //print(token);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: token == 'admin' ? LotData():token=='customer' ? KeyinDetails():LoginPage(),
    
    //home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

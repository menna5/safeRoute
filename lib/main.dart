// ignore_for_file: unused_element, duplicate_import, unused_import, avoid_print, await_only_futures

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safe_route/routes/car_information/car_information.dart';
import 'package:safe_route/routes/home/home.dart';
import 'package:safe_route/routes/login/login.dart';
import 'package:safe_route/routes/profile/profile.dart';
import 'package:safe_route/routes/register/register.dart';

import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

int carId = 0;
List carData = [];
void _connect(op) async {
  if (op == 'ID'){
    var response = await http.get(Uri.parse("http://10.0.0.1:4000/car_id"));
    if (response.statusCode == 200) {
    final jsonSendData = json.decode(response.body);
    carId = jsonSendData;
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  else if (op == 'Data') {
    var response = await http.get(Uri.parse("http://10.0.0.1:4000/car_data"));
    if (response.statusCode == 200) {
    final jsonSendData = json.decode(response.body);
    carData.addAll(jsonSendData);
    }
    else {
    print('Request failed with status: ${response.statusCode}.');
  }
  } 
}
int printable(i){
  if(i == 1){
    print('Hi');}
  else {
    print('Bye');
  }
  return 0;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
  print('out');
  runApp(const MyApp());
  //_connect('ID');
  await printable(1);
  const oneSec = Duration(seconds:1);
  // Timer.periodic(oneSec, (Timer) {_connect('Data');});
  Timer.periodic(oneSec, (Timer) async {await printable(2);});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      routes:{
        Home.routeName :(_) => Home(),
        CarInfo.routeName:(_)=>CarInfo(),
        Profile.routeName:(_) =>Profile(),
        Login.routeName:(_)=>Login(),
        Register.routeName:(_)=>Register(),
      },
      initialRoute: Login.routeName,

    );
  }
}
//Get
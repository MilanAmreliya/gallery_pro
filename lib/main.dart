import 'package:flutter/material.dart';
import 'package:gallery/view/all_quotes_screen.dart';
import 'package:gallery/view/lock/set_password_screen.dart';
import 'package:gallery/view/splash_screen.dart';
import 'package:gallery/view/write_quotes_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      title: 'Gallery',
      debugShowCheckedModeBanner: false,
      // home: SetPassword(),
      home: SplashScreen(),
    );
  }
}

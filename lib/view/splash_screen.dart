import 'dart:async';
import 'package:gallery/model/pref_man.dart';
import 'package:gallery/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'lock/confirm_pass.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (PreferenceManager.getPassON() == true &&
          PreferenceManager.getPassword() != null) {
        Get.to(ConfiemPassword());
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset("assets/icons/ic_gallery.png", scale: 5),
            const SizedBox(height: 10),
            const Text(
              "Gallery",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

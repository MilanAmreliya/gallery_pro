import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery/model/pref_man.dart';
import 'package:gallery/view/lock/set_password_screen.dart';
import 'package:gallery/view/setting_screen.dart';
import 'package:get/get.dart';

import '../../customPackage/lib/passcode_screen.dart';

class ChnagePassWodStep1 extends StatefulWidget {
  const ChnagePassWodStep1({Key? key}) : super(key: key);
  @override
  _ChnagePassWodStep1State createState() => _ChnagePassWodStep1State();
}

class _ChnagePassWodStep1State extends State<ChnagePassWodStep1> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
      title: Text(
        'Verify password',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      passwordEnteredCallback: _onPasscodeEntered,
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
      deleteButton: Text(
        'Delete',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Delete',
      ),
      shouldTriggerVerification: _verificationNotifier.stream,
      backgroundColor: Colors.black.withOpacity(0.8),
      cancelCallback: _onPasscodeCancelled,
      isValidCallback: () {
        print('okookko${_verificationNotifier.stream}');
        Get.back();
      },
      passwordDigits: 4,
      // bottomWidget: _buildPasscodeRestoreButton(),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    print('ppppp   ${enteredPasscode}');

    if (PreferenceManager.getPassword() == enteredPasscode) {
      print('getpass ${PreferenceManager.getPassword()}');
      Get.to(SetPassword());
    }
  }

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset passcode",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: const TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              child: Text(
                "I understand",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            child: Text(
              "Reset passcode",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            onPressed: _resetAppPassword,
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
          ),
        ),
      );

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }
}

import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<String> title = [
    "1) Why should i Use this App?",
    "2) What is Strength of this App compare to Other App?",
    "3) What is Security Question?",
    "4) How to Create App Lock Password?",
    "5) How to Recover Forgot LockPassword?",
    "6) How to Create Vault Password?",
    "7) How to Recover Forgot Vault Password?",
    "8) How to Change vault Password?",
    "9) Is Lock and Vault Password are same?",
    "10) What to recover password if i forgot password & security question as well?",
    "11) How to Hide photo/video?",
    "12) How to Unhide photo/video?",
    "13) Where is my hidden data in SB gallery app?",
    "14) How to find Video Editing Tools in SB Gallery App?",
    "15) How to find Photo Editing Tools in SB Gallery App?",
    "16) How to change Theme Color of App?",
    "17) How to find duplicate photos in my folder?",
    "18) Can i Create Quotes with my photo? How?",
    "19) How to create Video status in SB Gallery App?",
    "20) How to Copy Photos/Videos?",
    "21) How to Move Photos & Videos?",
    "22) How to Delete or Hide Photos/Videos?",
    "23) How to Create New Albums",
    "24) Can i Create Photo Collage with my family/friends or other?",
    "25) How to disable Gallery Notifications?",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                collapsedIconColor: Colors.black,
                title: Text(
                  title[index],
                  style: TextStyle(color: Colors.black),
                ),
                children: <Widget>[
                  Divider(color: Colors.grey),
                  SizedBox(height: 5),
                  ListTile(
                      title: Text(
                    'Every Update it is comming with new features, Now it has All Gallery features,photo editing,video editing, video status,photo quotes,vault,photo collage,Applock,find duplicate photos etc.',
                    style: TextStyle(
                        fontSize: 12, color: Colors.black54, height: 2),
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

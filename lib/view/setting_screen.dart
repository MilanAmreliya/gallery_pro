import 'package:flutter/material.dart';
import 'package:gallery/model/pref_man.dart';
import 'package:gallery/view/r/help_screen.dart';
import 'package:get/get.dart';

import 'lock/change_pass_step1.dart';
import 'lock/set_password_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = PreferenceManager.getPassON() == true ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff78909c)),
                      child: Center(
                          child: Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  PreferenceManager.setPassOn(
                                      value: isSwitched);
                                });
                              },
                              activeTrackColor: Colors.grey,
                              activeColor: Colors.green)),
                    ),
                    const Text("Lock Off",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(SetPassword());
                  },
                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffff2c55),
                          ),
                          child: Image.asset("assets/icons/ic_valult.png",
                              scale: 18, color: Colors.white)),
                      const Text("Vault", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            int? selectedRadio = 0;
                            return AlertDialog(
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        List<Widget>.generate(8, (int index) {
                                      return Row(
                                        children: [
                                          Radio<int>(
                                            value: index,
                                            groupValue: selectedRadio,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedRadio = value;
                                                PreferenceManager.setGrid(
                                                    value: value!);
                                                print(
                                                    '--select   $selectedRadio');
                                              });
                                            },
                                          ),
                                          Text(index == 0 ? "Auto" : "$index"),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff0379fd)),
                        child: const Icon(Icons.grid_on,
                            color: Colors.white, size: 30),
                      ),
                    ),
                    const Text("Grid Value",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffaa00ff)),
                      child: const Icon(Icons.photo,
                          color: Colors.white, size: 30),
                    ),
                    const Text("Duplicate Photo",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.to(ChnagePassWodStep1());
                },
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xfffa9c06)),
                      child: const Icon(Icons.vpn_key_outlined,
                          size: 30, color: Colors.white),
                    ),
                    const Text("Change Lock",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff6200e9),
                    ),
                  ),
                  const Text("Theme", style: TextStyle(color: Colors.white))
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(HelpScreen());
                },
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff35c847)),
                      child: const Icon(Icons.help_outline,
                          size: 30, color: Colors.white),
                    ),
                    const Text("Help", style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State createState() => new MyHomePageState();
}

enum Fruit {
  apple,
  banana,
}

class MyHomePageState extends State<MyHomePage> {
  ValueNotifier<Fruit> _selectedItem = ValueNotifier<Fruit>(Fruit.apple);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton<Fruit>(
          itemBuilder: (BuildContext context) {
            return List<PopupMenuEntry<Fruit>>.generate(
              Fruit.values.length,
              (int index) {
                return PopupMenuItem(
                  value: Fruit.values[index],
                  child: AnimatedBuilder(
                    child: Text(Fruit.values[index].toString()),
                    animation: _selectedItem,
                    builder: (BuildContext context, child) {
                      return RadioListTile<Fruit>(
                        value: Fruit.values[index],
                        groupValue: _selectedItem.value,
                        title: child,
                        onChanged: (value) {
                          _selectedItem.value = value!;
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

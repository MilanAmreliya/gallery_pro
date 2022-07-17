import 'package:flutter/material.dart';

import 'package:gallery/view/explore_screen.dart';
import 'package:gallery/view/setting_screen.dart';
import 'package:get/get.dart';

import 'gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<bool> showExitPopup() async {
    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 130,
            width: Get.width,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Are you sure to exit ?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red),
                        child: const Center(child: Text("Cancel")),
                      ),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red),
                        child: const Center(child: Text("Ok")),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          );
        });
  }

  TabController? tabController;
  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(30, 30, 0, 50),
      color: Colors.black,
      items: [
        const PopupMenuItem<String>(
            child: Text(
              'New Directory',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            value: 'New Directory'),
        const PopupMenuItem<String>(
            child: Text('New Album',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'New Album'),
        const PopupMenuItem<String>(
            child: Text('Sort by',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Sort by'),
        const PopupMenuItem<String>(
            child: Text('Refresh(Media Scan)',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Refresh(Media Scan)'),
        const PopupMenuItem<String>(
            child: Text('Open camera',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Open camera'),
        const PopupMenuItem<String>(
            child: Text('Share',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Share'),
        const PopupMenuItem<String>(
            child: Text('Privacy Policy',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Privacy Policy'),
        const PopupMenuItem<String>(
            child: Text('Documentation',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Documentation'),
      ],
      elevation: 8.0,
    );
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Gallery"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.account_circle)),
              IconButton(
                  onPressed: () {
                    Get.to(SettingScreen());
                  },
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {
                    _showPopupMenu();
                  },
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
          body: Column(
            children: [
              TabBar(
                  controller: tabController,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.blueAccent,
                  indicator: const UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 6, color: Colors.blueAccent),
                      insets: EdgeInsets.symmetric(horizontal: 50)),
                  tabs: const [
                    Tab(
                      text: "Photos",
                    ),
                    Tab(text: "Videos"),
                    Tab(text: "Explore"),
                  ]),
              const Divider(color: Colors.grey),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    GalleryScreen(isSelected: true),
                    GalleryScreen(isSelected: false),
                    ExploreScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: showExitPopup);
  }
}

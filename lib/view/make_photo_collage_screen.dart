import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery/view/share_image_screen.dart';
import 'package:get/get.dart';
import 'package:image_collage_widget/image_collage_widget.dart';
import 'package:image_collage_widget/utils/CollageType.dart';
import 'package:screenshot/screenshot.dart';

class MakePhotoCollageScreen extends StatefulWidget {
  const MakePhotoCollageScreen({Key? key}) : super(key: key);

  @override
  State<MakePhotoCollageScreen> createState() => _MakePhotoCollageScreenState();
}

class _MakePhotoCollageScreenState extends State<MakePhotoCollageScreen> {
  List<Map<String, dynamic>> categoryItems = [
    {'icon': "assets/icons/ic_templates.png", 'label': "Templates"},
    {'icon': "assets/icons/ic_border.png", 'label': "Border"},
    {'icon': "assets/icons/ic_ratio.png", 'label': "Ratio"},
    {'icon': "assets/icons/ic_background.png", 'label': "Background"},
    {'icon': "assets/icons/ic_stickers.png", 'label': "Stickers"},
    {'icon': "assets/icons/ic_add.png", 'label': "Add"},
  ];
  // int collageTypeSelected = 0;
  CollageType? collageType;
  final _controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: Get.height * 0.066,
        title: const Text("Collage Photo"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: GestureDetector(
              onTap: () async {
                _controller.capture().then(
                      (Uint8List? image) => Get.to(
                        ShareImageScreen(
                          bytes: image,
                        ),
                      ),
                    );
              },
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.20,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: buildImageCollageWidget(context),
      ),
      bottomNavigationBar: SizedBox(
        height: Get.height * 0.07,
        child: Padding(
          padding: EdgeInsets.only(
            left: Get.width * 0.02,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                categoryItems.length,
                (index) => InkWell(
                  onTap: () {
                    if (index == 0) {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: Get.height * 0.18,
                            width: double.infinity,
                            color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      "Templates",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              collageType = CollageType.HSplit;
                                            },
                                          );
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.09,
                                          width: Get.height * 0.09,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.022),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5)),
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              collageType = CollageType.VSplit;
                                            },
                                          );
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.09,
                                          width: Get.height * 0.09,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.022),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5)),
                                          child: VerticalDivider(
                                            thickness: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              collageType =
                                                  CollageType.FourSquare;
                                            },
                                          );
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.09,
                                          width: Get.height * 0.09,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.022),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5)),
                                          child: Stack(
                                            children: const [
                                              Align(
                                                alignment: Alignment.center,
                                                child: VerticalDivider(
                                                  thickness: 2,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Divider(
                                                  thickness: 2,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              collageType =
                                                  CollageType.ThreeHorizontal;
                                            },
                                          );
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.09,
                                          width: Get.height * 0.09,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.022),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.5),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.044,
                                                child: Divider(
                                                  thickness: 2,
                                                  height: 0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.04,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    VerticalDivider(
                                                      thickness: 2,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Column(
                      children: [
                        Image.asset(
                          categoryItems[index]['icon'],
                          height: Get.height * 0.03,
                          width: Get.height * 0.03,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(categoryItems[index]['label'])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Screenshot buildImageCollageWidget(BuildContext context) {
    return Screenshot(
      controller: _controller,
      child: ImageCollageWidget(
        collageType: collageType ?? CollageType.HSplit,
        withImage: true,
      ),
    );
  }
}

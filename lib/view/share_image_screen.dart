import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../const/contant.dart';

class ShareImageScreen extends StatefulWidget {
  final bytes;

  const ShareImageScreen({Key? key, this.bytes}) : super(key: key);

  @override
  State<ShareImageScreen> createState() => _ShareImageScreenState();
}

class _ShareImageScreenState extends State<ShareImageScreen> {
  List<Map<String, dynamic>> items = [
    {
      "icon": "assets/icons/download (1).png",
      "label": "DOWNLOAD",
    },
    {
      "icon": "assets/icons/whatsapp.png",
      "label": "WHATSAPP",
    },
    {
      "icon": "assets/icons/facebook.png",
      "label": "FACEBOOK",
    },
    {
      "icon": "assets/icons/instagram (1).png",
      "label": "INSTAGRAM",
    },
    {
      "icon": "assets/icons/more.png",
      "label": "MORE",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: writeQuotesBgColor,
      appBar: AppBar(
        titleSpacing: 10,
        elevation: 0,
        toolbarHeight: Get.height * 0.07,
        backgroundColor: writeQuotesBgColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              //Get.back();
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text("Share Photo"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/icons/ic_filter.png',
                height: Get.height * 0.033,
                width: Get.height * 0.033,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          createdImage(context),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: List.generate(
                  5,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: InkResponse(
                          onTap: () async {
                            if (index == 0) {
                              await saveImage(widget.bytes).then(
                                (value) => Fluttertoast.showToast(
                                    msg: "Saved to Gallery!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.yellow,
                                    textColor: Colors.white,
                                    fontSize: 16.0),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.yellow,
                                child: Image.asset(items[index]['icon'],
                                    height: 25, width: 25),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(items[index]['label'])
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ),
      ),
    );
  }

  Padding createdImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: Get.height * 0.48,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(widget.bytes),
          ),
        ),
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }
}

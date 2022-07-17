import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../const/contant.dart';

class ShareQuotesScreen extends StatefulWidget {
  final String? quotes;
  final Color? color;

  const ShareQuotesScreen({Key? key, this.quotes, this.color})
      : super(key: key);

  @override
  State<ShareQuotesScreen> createState() => _ShareQuotesScreenState();
}

class _ShareQuotesScreenState extends State<ShareQuotesScreen> {
  final _controller = ScreenshotController();

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
        backgroundColor: writeQuotesBgColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              //Get.back();
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text("Share quotes"),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
          createdQuote(context),
          SizedBox(
            height: Get.height * 0.03,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: InkResponse(
                            onTap: () async {
                              if (index == 0) {
                                final image =
                                    await _controller.captureFromWidget(
                                  Material(
                                    child: createdQuote(context),
                                  ),
                                );
                                await saveImage(image).then(
                                  (value) => Fluttertoast.showToast(
                                      msg: "Saved to Gallery!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: writeQuotesColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: writeQuotesColor,
                                  child: Image.asset(
                                    items[index]['icon'],
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(items[index]['label'])
                              ],
                            ),
                          ),
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container createdQuote(BuildContext context) {
    return Container(
      height: Get.height * 0.48,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: widget.color,
          gradient: LinearGradient(
            colors: [
              Colors.green.shade200,
              Colors.blue.shade200,
              Colors.purple.shade200,
              Colors.purple.shade200,
              Colors.pink.shade200,
              Colors.deepOrange.shade200,
              Colors.orange.shade200,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
      child: Center(
        child: Text(
          widget.quotes == null ? "Text Show Here" : widget.quotes.toString(),
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
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

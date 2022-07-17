import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gallery/model/pref_man.dart';
import 'package:get/get.dart';
import 'package:image_editor_dove/image_editor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoDetailScreen extends StatefulWidget {
  final file;
  final String? path;
  final imageName;
  final medium;

  const PhotoDetailScreen(
      {Key? key, required this.file, this.imageName, this.path, this.medium})
      : super(key: key);

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  List<String> items = [
    'assets/icons/ic_slideshow.png',
    "assets/icons/ic_edit.png",
    "assets/icons/ic_delete.png",
    'assets/icons/ic_share.png'
  ];
  File? _image;

  Future<void> toImageEditor(File origin) async {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditor(
        originImage: origin,
      );
    })).then((result) {
      if (result is EditorImageResult) {
        setState(() {
          _image = result.newFile;
        });
      }
    }).catchError((er) {
      debugPrint(er);
    });
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(30, 30, 0, 50),
      color: Colors.black,
      items: [
        const PopupMenuItem<String>(
            child: Text(
              'Set as Wallpaper',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            value: 'Set as Wallpaper '),
        const PopupMenuItem<String>(
            child: Text(
              'Rename',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            value: 'Rename'),
        const PopupMenuItem<String>(
            child: Text('Use as',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Use as'),
        const PopupMenuItem<String>(
            child: Text('Details',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            value: 'Details'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    File m;
    // print('image    ${m.path}');
    File mmmm = File(widget.file.path);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Image.asset(
                  'assets/icons/ic_gallery.png',
                  height: 28,
                  width: 28,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        widget.imageName,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      // PreferenceManager.allClearPreferenceManager();
                      print(
                          '----get valu  ${PreferenceManager.getLikePhoto()}');
                      print(
                          '----get  ${PreferenceManager.getLikePhoto().runtimeType}');

                      List likPhoto = PreferenceManager.getLikePhoto() == null
                          ? []
                          : PreferenceManager.getLikePhoto();

                      if (likPhoto.contains(widget.file.path)) {
                        likPhoto.remove(widget.file.path);
                      } else {
                        likPhoto.add(widget.file.path);
                      }
                      PreferenceManager.setLikePhoto(value: likPhoto);
                      print('----get  ${PreferenceManager.getLikePhoto()}');
                    },
                    icon: const Icon(
                      Icons.favorite_outline,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      _showPopupMenu();
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 30,
                    )),
              ],
            ),
            SizedBox(
              height: Get.height * 0.16,
            ),
            Image.file(
              widget.file,
              height: Get.height / 2,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: List.generate(
            items.length,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.height * 0.044,
                    vertical: Get.height * 0.022,
                  ),
                  child: InkResponse(
                    onTap: () async {
                      if (index == 3) {
                        Share.shareFiles([widget.path!]);
                      } else if (index == 1) {
                        await toImageEditor(widget.file).then(
                          (value) async => ImageGallerySaver.saveImage(
                            await _image!.readAsBytes(),
                          ),
                        );
                      } else if (index == 2) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.red.shade400,
                                        child: Image.asset(
                                          'assets/icons/ic_delete.png',
                                          height: 18,
                                          width: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Text(
                                    "Are you sure you want to Delete?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05,
                                    vertical: Get.height * 0.011,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "CANCEL",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "DELETE",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageSlideShowScreen(
                              medium: widget.medium,
                            ),
                          ),
                        );
                      }
                    },
                    child: Image.asset(
                      items[index],
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ),
                  ),
                )),
      ),
    );
  }
}

class ImageSlideShowScreen extends StatelessWidget {
  final List<Medium>? medium;

  const ImageSlideShowScreen({Key? key, this.medium}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Colors.transparent,
          indicatorBackgroundColor: Colors.transparent,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 3000,
          isLoop: true,
          children: List.generate(
            medium!.length,
            (index) => FadeInImage(
              height: Get.height / 1,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: PhotoProvider(mediumId: medium![index].id),
            ),
          ),
        ),
      ),
    );
  }
}

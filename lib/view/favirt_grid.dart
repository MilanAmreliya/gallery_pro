import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/model/pref_man.dart';
import 'package:gallery/view/photo_detail_screen.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';

class FavGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<FavGrid> {
  List favList = [];
  Medium? medium;
  @override
  void initState() {
    favList = PreferenceManager.getLikePhoto();
    super.initState();
  }

  // Future<File?> getFile(Medium medium) async {
  //   setState(
  //     () async {
  //       file = await convertMediumToFile(medium);
  //     },
  //   );
  //   return file;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              "assets/icons/ic_gallery.png",
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            const Text("Gallery"),
          ],
        ),
      ),
      body: GridView.builder(
          itemCount: favList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.6, crossAxisCount: 3, mainAxisSpacing: 5),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(PhotoDetailScreen(
                  file: File(favList[index]),
                  path: favList[index],
                  imageName: '',
                  medium: 'image',
                ));
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
                child: Image.file(File(favList[index]), fit: BoxFit.cover),
              ),
            );
          }),
    );
  }
}

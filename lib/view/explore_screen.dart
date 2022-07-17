import 'package:flutter/material.dart';
import 'package:gallery/view/create_poster_screen.dart';
import 'package:gallery/view/my_videos_screen.dart';
import 'package:gallery/view/trash_bin_screen.dart';
import 'package:gallery/view/write_quotes_screen.dart';
import 'package:get/get.dart';

import 'make_photo_collage_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> exploreTitle = ["CREATE", "MY", "WRITE", "CREATE", "MY", "MAKE"];
  List<String> exploreName = [
    "Posters",
    "Trash Bin",
    "Quotes",
    "Video Story",
    "Videos",
    "Photo Collage"
  ];
  List<String> images = [
    "assets/icons/ic_poster.png",
    "assets/icons/ic_bin.png",
    "assets/icons/ic_quotes.png",
    "assets/icons/ic_video.png",
    "assets/icons/ic_folder.png",
    "assets/icons/ic_freme.png",
  ];
  List<Color> colors = [
    const Color(0xff0bd788),
    const Color(0xfffb814a),
    const Color(0xffffbd60),
    const Color(0xffed4647),
    const Color(0xff5273fb),
    const Color(0xff23c1fe),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: GridView.builder(
          itemCount: exploreTitle.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (index == 2) {
                  //Get.to(WriteQuotesScreen());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteQuotesScreen(),
                      ));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrashBinScreen(),
                      ));
                  //Get.to(TrashBinScreen());
                } else if (index == 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyVideosScreen(),
                      ));
                  // Get.to(MyVideosScreen());
                } else if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePosterScreen(),
                      ));
                  // Get.to(MyVideosScreen());
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakePhotoCollageScreen(),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          images[index],
                          scale: 30,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            exploreTitle[index],
                            style: TextStyle(
                              color: Colors.white,
                              //fontSize: Get.width * 0.022,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            exploreName[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.033),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

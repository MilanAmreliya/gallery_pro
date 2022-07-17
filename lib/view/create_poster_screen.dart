import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePosterScreen extends StatefulWidget {
  const CreatePosterScreen({Key? key}) : super(key: key);

  @override
  State<CreatePosterScreen> createState() => _CreatePosterScreenState();
}

class _CreatePosterScreenState extends State<CreatePosterScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<String> items = ["All", "Banner", "Post", "Story"];
  List<String> categoryItems = [
    "Advertisement",
    "Anniversary",
    "Birthday",
    "Collage",
    "Invitation",
  ];

  int selected = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          size: 0,
        ),
        title: const Text(
          "Poster Maker",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.blueAccent,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 5, color: Colors.blueAccent),
                insets: EdgeInsets.symmetric(horizontal: 70)),
            tabs: const [
              Tab(
                text: "Templates",
              ),
              Tab(text: "Categories"),
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: List.generate(
                            items.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selected = index;
                                  },
                                );
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.03,
                                  vertical: 12,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.4)),
                                  color: selected == index
                                      ? Colors.blue
                                      : Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    items[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: List.generate(
                    categoryItems.length,
                    (index) => Container(
                      height: 80,
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.height * 0.022,
                        vertical: Get.height * 0.011,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          categoryItems[index],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

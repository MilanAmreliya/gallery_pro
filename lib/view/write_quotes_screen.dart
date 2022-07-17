import 'package:flutter/material.dart';
import 'package:gallery/const/contant.dart';
import 'package:gallery/view/add_text_screen.dart';
import 'package:gallery/view/all_quotes_screen.dart';
import 'package:gallery/view/share_quotes_screen.dart';
import 'package:get/get.dart';

class WriteQuotesScreen extends StatefulWidget {
  final String? text;

  const WriteQuotesScreen({Key? key, this.text}) : super(key: key);

  @override
  State<WriteQuotesScreen> createState() => _WriteQuotesScreenState();
}

class _WriteQuotesScreenState extends State<WriteQuotesScreen> {
  TextEditingController? quotesController;

  List<Map<String, dynamic>> categoryItems = [
    {"icon": "assets/icons/ic_background.png", "title": "Background"},
    {"icon": "assets/icons/ic_quote.png", "title": "Quotes"},
    {"icon": "assets/icons/ic_typography.png", "title": "Typography"},
    {"icon": "assets/icons/ic_text.png", "title": "Text"}
  ];
  List<Color> colorList = [
    Colors.redAccent,
    Colors.orange,
    Colors.blue,
    Colors.indigo,
    Colors.black,
    Colors.yellow,
    Colors.white,
    Colors.pink,
    Colors.deepPurple,
    Colors.brown,
    Colors.grey,
    Colors.red,
    Colors.green,
    Colors.greenAccent
  ];
  int? selectedBg;
  var image;
  @override
  void initState() {
    quotesController = TextEditingController(
      text: widget.text,
    );
    print("jakkks${widget.text}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Get.back();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkResponse(
              onTap: () async {
                quotesController?.text == ""
                    ? const SizedBox()
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShareQuotesScreen(
                                  quotes: quotesController?.text,
                                  color: selectedBg == null
                                      ? Colors.red
                                      : colorList[selectedBg!],
                                )));
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: writeQuotesColor,
                child: Icon(Icons.check, size: 23, color: writeQuotesBgColor),
              ),
            ),
          )
        ],
        title: const Text("Custom quotes"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            selectedBg == null
                ? createdQuote(context)
                : Container(
                    height: Get.height * 0.48,
                    width: double.infinity,
                    decoration: BoxDecoration(color: colorList[selectedBg!]),
                    child: Center(
                        child: TextFormField(
                      controller: quotesController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white, fontSize: 27),
                      cursorHeight: 50,
                      cursorColor: Colors.cyanAccent,
                      decoration: InputDecoration(
                        hintText: "Text Show Here",
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 40),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.07,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                  ),
            SizedBox(height: Get.height * 0.06),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Column(
                      children: [
                        InkResponse(
                          onTap: () {
                            if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllQuotesScreen()));
                              //Get.to(const AllQuotesScreen());
                            } else if (index == 0) {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    height: 500,
                                    child: GridView.builder(
                                      itemCount: 14,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        // childAspectRatio: 2 / 2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                selectedBg = index;
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: colorList[index],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            } else if (index == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTextScreen(
                                      color: colorList[selectedBg!]),
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                              radius: Get.width * 0.057,
                              backgroundColor: writeQuotesColor,
                              child: Image.asset(
                                categoryItems[index]['icon'],
                                height: 28,
                                width: 28,
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.007,
                        ),
                        Text(
                          categoryItems[index]['title'],
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container createdQuote(BuildContext context) {
    return Container(
      height: Get.height * 0.48,
      width: double.infinity,
      decoration: BoxDecoration(
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
        ),
      ),
      child: Center(
          child: TextFormField(
        controller: quotesController,
        maxLines: 5,
        style: const TextStyle(color: Colors.white, fontSize: 30),
        cursorHeight: 50,
        cursorColor: Colors.cyanAccent,
        decoration: InputDecoration(
          hintText: "Text Show Here",
          hintStyle: const TextStyle(color: Colors.white, fontSize: 40),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.07,
          ),
          border: InputBorder.none,
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gallery/view/write_quotes_screen.dart';
import 'package:get/get.dart';

import '../api_services/enum.dart';
import '../const/contant.dart';

class AddTextScreen extends StatefulWidget {
  final String? text;
  final Color? color;
  const AddTextScreen({Key? key, this.text, this.color}) : super(key: key);

  @override
  State<AddTextScreen> createState() => _AddTextScreenState();
}

class _AddTextScreenState extends State<AddTextScreen> {
  int? selectedBg;
  TextEditingController? quotesController;
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
  var image;
  TextMode currentMode = TextMode.normal;
  bool bold = false;
  bool italic = false;
  bool underline = false;
  bool rubbish = false;
  @override
  void initState() {
    quotesController = TextEditingController(text: widget.text);
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WriteQuotesScreen(text: quotesController?.text)));
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: writeQuotesColor,
                child: Icon(Icons.check, size: 23, color: writeQuotesBgColor),
              ),
            ),
          )
        ],
        title: const Text("Add Text"),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
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
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    bold = !bold;
                    currentMode =
                        bold == true ? TextMode.bold : TextMode.normal;
                  });
                },
                icon: const Icon(Icons.format_bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    underline = !underline;
                    currentMode = underline == true
                        ? TextMode.underline
                        : TextMode.normal;
                  });
                },
                icon: const Icon(Icons.format_underline),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    italic = !italic;
                    currentMode =
                        italic == true ? TextMode.italic : TextMode.normal;
                  });
                },
                icon: const Icon(Icons.format_italic),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    rubbish = !rubbish;
                    currentMode =
                        rubbish == true ? TextMode.rubbish : TextMode.normal;
                  });
                },
                icon: const Icon(Icons.format_list_bulleted),
              ),
            ],
          ),
        ],

        // Helper metho
      ),
    );
  }

  Container createdQuote(BuildContext context) {
    return Container(
      height: Get.height * 0.48,
      width: double.infinity,
      color: widget.color,
      child: Center(
          child: TextFormField(
        controller: quotesController,
        maxLines: 5,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            decoration: underline == true
                ? TextDecoration.underline
                : rubbish == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
            fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
            fontStyle: italic == true ? FontStyle.italic : FontStyle.normal),
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

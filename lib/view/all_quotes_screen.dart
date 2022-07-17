import 'package:flutter/material.dart';
import 'package:gallery/api_services/get_quotes_services.dart';
import 'package:gallery/const/contant.dart';
import 'package:gallery/view/write_quotes_screen.dart';
import 'package:get/get.dart';
import '../model/quotes_model.dart';

class AllQuotesScreen extends StatefulWidget {
  const AllQuotesScreen({Key? key}) : super(key: key);

  @override
  State<AllQuotesScreen> createState() => _AllQuotesScreenState();
}

class _AllQuotesScreenState extends State<AllQuotesScreen> {
  int categorySelected = 0;
  //QuotesController quotesController = Get.put(QuotesController());

  List<String> categoryItems = [
    "LOVE",
    "FRIENDSHIP",
    "MOTIVATIONAL",
    "POSITIVE",
    "SPIRITUAL",
    "TRUST",
    "TRAVELLING",
    "SAD",
    "NATURE",
    "LIFE",
    "BUSINESS",
    "FUNNY",
  ];
  @override
  Widget build(BuildContext context) {
    //var categoryName;
    return Scaffold(
      backgroundColor: writeQuotesColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  IconButton(
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
                  Text(
                    "Quotes",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              height: Get.height * 0.08,
              child: ListView.builder(
                itemCount: categoryItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          categorySelected = index;
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          decoration: BoxDecoration(
                            color: categorySelected == index
                                ? Colors.white
                                : writeQuotesBgColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Text(
                            categoryItems[index],
                            style: TextStyle(
                                color: categorySelected == index
                                    ? writeQuotesBgColor
                                    : Colors.white,
                                fontSize: 18),
                          )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(
              child: Container(
                  //height: Get.height / 1.3,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: Get.width * 0.03,
                    right: Get.width * 0.03,
                    top: Get.height * 0.04,
                  ),
                  decoration: const BoxDecoration(
                    color: writeQuotesBgColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: ListView.builder(
                    itemCount: categorySelected == 0
                        ? love.length
                        : categorySelected == 1
                            ? friendship.length
                            : categorySelected == 2
                                ? motivational.length
                                : categorySelected == 3
                                    ? positive.length
                                    : categorySelected == 4
                                        ? spiritiual.length
                                        : categorySelected == 5
                                            ? trust.length
                                            : categorySelected == 6
                                                ? travelling.length
                                                : categorySelected == 7
                                                    ? sad.length
                                                    : categorySelected == 8
                                                        ? nature.length
                                                        : categorySelected == 9
                                                            ? life.length
                                                            : categorySelected ==
                                                                    10
                                                                ? business
                                                                    .length
                                                                : categorySelected ==
                                                                        11
                                                                    ? funny
                                                                        .length
                                                                    : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteQuotesScreen(
                                  text: categorySelected == 0
                                      ? love[index]
                                      : categorySelected == 1
                                          ? friendship[index]
                                          : categorySelected == 2
                                              ? motivational[index]
                                              : categorySelected == 3
                                                  ? positive[index]
                                                  : categorySelected == 4
                                                      ? spiritiual[index]
                                                      : categorySelected == 5
                                                          ? trust[index]
                                                          : categorySelected ==
                                                                  6
                                                              ? travelling[
                                                                  index]
                                                              : categorySelected ==
                                                                      7
                                                                  ? sad[index]
                                                                  : categorySelected ==
                                                                          8
                                                                      ? nature[
                                                                          index]
                                                                      : categorySelected ==
                                                                              9
                                                                          ? life[
                                                                              index]
                                                                          : categorySelected == 10
                                                                              ? business[index]
                                                                              : categorySelected == 11
                                                                                  ? funny[index]
                                                                                  : "",
                                ),
                              ));
                          // Get.to(WriteQuotesScreen(
                          //   text: quotes.quotesContent.toString(),
                          // ));
                        },
                        child: Container(
                          height: Get.height * 0.13,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: Get.height * 0.011),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.height * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: writeQuotesColor, width: 3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categorySelected == 0
                                    ? love[index]
                                    : categorySelected == 1
                                        ? friendship[index]
                                        : categorySelected == 2
                                            ? motivational[index]
                                            : categorySelected == 3
                                                ? positive[index]
                                                : categorySelected == 4
                                                    ? spiritiual[index]
                                                    : categorySelected == 5
                                                        ? trust[index]
                                                        : categorySelected == 6
                                                            ? travelling[index]
                                                            : categorySelected ==
                                                                    7
                                                                ? sad[index]
                                                                : categorySelected ==
                                                                        8
                                                                    ? nature[
                                                                        index]
                                                                    : categorySelected ==
                                                                            9
                                                                        ? life[
                                                                            index]
                                                                        : categorySelected ==
                                                                                10
                                                                            ? business[index]
                                                                            : categorySelected == 11
                                                                                ? funny[index]
                                                                                : "",
                                maxLines: 3,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  List<String> love = [
    "We accept the love we think we deserve",
    "Love all,trust a few,do wrong to none.",
    "Love is like the wind,you can't see it but you can feel it",
    "If you can make a women laugh,you can make her do anything",
    "I am happiest when i'm right next to you",
    "The water shines only by the sun.And it is you who are my sun.",
    "My night has become a sunny dawn because of you.",
    "I swear I couldn't love you more than I do right now, and yet I know I will tomorrow.",
    "The best thing to hold onto in life is each other.",
    "I love you begins by me, but it ends up by you",
    "you may hold my hand for a while, but you hold my heart forever",
    "There is madness in loving you, a lack of reason that makes it feel so flawless.",
    "I know I am in love with you because my reality is finally better than my dreams",
    "You know its love when all you want is that person to be happy, even if you're not part of their happiness",
    "your love is all i need to feel complete",
    "I will love you until the stars go out, and the tides no longer turn.",
    "Come live in my heart and pay no rent.",
    "Every time i see you, i fall in love all over again",
    "You are my song. you are my song of love",
    "If I know what love is,it is because of you.",
    "The first time you touched me, i knew I was born to be yours."
        "To lose balance sometimes for love is part of living a balanced life."
  ];
  List<String> friendship = [
    "A real friend is one who walks in when the rest of the world walks out.",
    "There's not a word yet for old friends who've just met.",
    "There's not a word yet for old friends who've just met.",
    "A single rose can be my garden... a single friend, my world.",
    "What you do not want done to yourself, do not do to others.",
    "A true friend never gets in your way unless you happen to be going down.",
    "Be slow in choosing a friend, slower in changing.",
    "Friendship is one mind in two bodies.",
    "There is nothing on this earth more to be prized than true friendship.",
    "I would rather walk with a friend in the dark, than alone in the light.",
    "Friendship multiplies the good of life and divides the evil.",
    "Friendship is essentially a partnership.",
    "Friends show their love in times of trouble, not in happiness.",
    "True friendship ought never to conceal what it thinks.",
    "Friendship is always a sweet responsibility, never an opportunity.",
    "The most I can do for my friend is simply be his friend.",
    "A best friend is someone who makes you laugh even when you think you'll never smile again.",
  ];
  List<String> motivational = [
    "Only I can change my life. No one can do it for me.",
    "What you do not want done to yourself, do not do to others.",
    "With the new day comes new strength and new thoughts.",
    "Quality is an act, it is a habit",
    "Life is 10% what happens to you and 90% how you react on it.",
    "The secret of getting ahead is getting started.",
    "It does not matter how slowly you go as long as you do not stop.",
    "The way get started is to quit talking and begin doing",
    "Don't let yesterday take up too much of today.",
    "Knowing is not enough, we must apply. Wishing is not enough, we must for.",
    "It's not whether you get knocked down; it's whether you get up.",
    "Today's accomplishments were yesterday's impossibilities.",
    "The future belongs to the competent. Get good, get better, be the best!",
  ];
  List<String> positive = [
    "Positivity always win always",
    "Keep looking up... that's the secret of life.",
    "The first step is you have to say that you can.",
    "Once you choose hope, anything's possible.",
    "You can, you should, and if you're brave enough to start, you will.",
    "The best way to predict the future is to create it.",
    "The Best Is Yet To be",
    "We can change our lives. We can do, have, and be exactly what we wish.",
    "A problem is a chance for you to do your best.",
    "The most important thing is to look ahead. The past is your anchor.",
    "Victory is in having done your best. If you've done your best, you've won.",
    "With the new day comes new strength and new thoughts.",
  ];
  List<String> spiritiual = [
    "There is nothing more important than this moment.",
    "Follow your intuition; it will always lead you to the right destination.",
    "I believe, and therefore anything is possible.",
    "The most important time in the world is the time you make for yourself.",
    "I have so much to do that I shall spend the first three hours in prayer.",
    "You'll be calm the day you learn to sit alone and do nothing.",
    "The personal life deeply lived always expands into truths beyond itself.",
    "The next message you need is always right where you are.",
    "Awakening is not changing who you are, but discarding who you are not.",
    "Equanimity arises when we accept the way things are.",
    "I Close My Eye in order to see",
    "Don't try to steer the river",
    "The spiritual journey is the unlearning of fear and the acceptance of love.",
    "He who is filled with love is filled with God himself.",
    "Fools laugh at others. Wisdom laughs at itself.",
  ];
  List<String> trust = [
    "Love all, trust a few, do wrong to none.",
    "I'm not upset that you lied to me; I'm upset that from now on I can't believe you.",
    "The entire world is made of faith, and trust, and pixie dust.",
    "The best way to find out if you can trust somebody is to trust them.",
    "Have enough courage to trust love one more time and always one more time.",
    "Never be afraid to trust an unknown future to a known God.",
    "For there to be betrayal, there would have to have been trust first.",
    "Trust is like a vase... once it's broken, though you can fix it, the vase will never be same again.",
    "Trust is the easiest thing in the world to loose, and the hardest thing in the world to get back.",
    "It is an equal failing to trust everybody, and to trust nobody.",
    "Respect people who trust you. It takes a lot for people to trust you, so treat their trust like precious porcelain.",
    "Trust is letting go of needing to know all the details before you open your heart.",
    "Building trust means thinking about trust in a positive way.",
  ];
  List<String> travelling = [
    "The world is a book and those who do not travel read only a page.",
    "Not all those who wander are lost.",
    "Life is either a daring adventure or nothing at all.",
    "Take only memories, leave only footprints.",
    "Travel makes one modest; you see what a tine place you occupy in the world.",
    "Never go on trips with anyone you do not love.",
    "Like all great travellers, I have seen more than I remember and remember more than I have seen.",
    "Travelling- it leave you speechless, and then turns you into a storyteller.",
    "If you think adventure is dangerous, try routine, it's lethal.",
    "Great things never came from comfort zones.",
    "If you are always trying to be normal, you will never know how amazing you can be.",
    "Great things never came from comfort zones.",
    "Fear is only temporary. Regrets last forever.",
    "It is not the destination where you end up but the mishaps and memories you create along the way.",
    "I don't know where I am going, but I am on my way.",
  ];
  List<String> sad = [
    "a lot of you cared just not enough",
    "tears are words the hearts can't express",
    "life is made of so many partings welded to gather",
    "the funniest people are the saddest one"
  ];
  List<String> nature = [
    "A dripping june set all in tune",
    "Nature is art of god",
    "A short horse is soon curried",
    "No man fears whats he has seen grow",
    "The afternoon knows what the morning never expected",
    "The day has eyes; the night has ears."
  ];
  List<String> life = [
    "A dripping june set all in tune",
    "Nature is art of god",
    "A short horse is soon curried",
    "No man fears whats he has seen grow",
    "The afternoon knows what the morning never expected",
    "The day has eyes; the night has ears."
  ];
  List<String> business = [
    "A dripping june set all in tune",
    "Nature is art of god",
    "A short horse is soon curried",
    "No man fears whats he has seen grow",
    "The afternoon knows what the morning never expected",
    "The day has eyes; the night has ears."
  ];
  List<String> funny = [
    "A dripping june set all in tune",
    "Nature is art of god",
    "A short horse is soon curried",
    "No man fears whats he has seen grow",
    "The afternoon knows what the morning never expected",
    "The day has eyes; the night has ears."
  ];
}

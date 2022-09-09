import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/header.dart';
import '../../Models/restaurant.dart';
import '../../Widgets/appBar.dart';
import '../../Widgets/drawer.dart';

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
int _current = 0;
List<headerModel> imgList = [];
List<restaurantModel> restaurantList = [];
List<Widget> ImageSliders = [];
final CarouselController _controller = CarouselController();
const Color mainColor = Color(0xFF22A45D);

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => homePageState();
}

class homePageState extends State<homePage> {
  String dropDownValue = 'Zagazig';
  var places = ["Alexandria", "Cairo", "Kafr El-Shaikh", "Mansoura", "Zagazig"];

  Widget appBarWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  size: 18,
                )),
            Container(
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45, right: 10),
                    child: const Text(
                      "DELIVERY TO",
                      style: TextStyle(
                          fontSize: 12,
                          color: mainColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    alignment: Alignment.center,
                    underline: Container(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                    dropdownColor: Theme.of(context).canvasColor,
                    elevation: 0,
                    isDense: true,
                    iconEnabledColor: Colors.black,
                    value: dropDownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: places.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shopping_cart),
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 20),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: mainColor,
                    child: Text("0",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      appBar: appBar(
          context: context, mainWidget: appBarWidget(), height: 70, shadow: 1),
      body: FutureBuilder(
          future: getListWidgets(),
          builder: (context, snapshot) => ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        items: ImageSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 5),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        const Text(
                          "All Restaurants",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: mainColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          restaurantWidget(230, false),
                          restaurantWidget(290, true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )),
    );
  }
}

//Custom restaurants widget
Widget restaurantWidget(double height, bool isTall) {
  return Flexible(
    child: ListView.builder(
        reverse: !isTall,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isTall
            ? restaurantList.length - 1 < 0
                ? 0
                : restaurantList.length - 1
            : restaurantList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 170,
                              height: height,
                              child: Image.network(
                                isTall
                                    ? restaurantList[index].tall_link == ""
                                        ? restaurantList[index].link
                                        : restaurantList[index].tall_link
                                    : restaurantList[index].link,
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(20, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            height: height,
                            width: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.speed,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${restaurantList[index].time} min",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 10),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.monetization_on_outlined,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              restaurantList[index].price,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Container(
                                            decoration: ShapeDecoration
                                                .fromBoxDecoration(
                                                    BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: mainColor)),
                                            width: 40,
                                            height: 22,
                                            child: Center(
                                              child: Text(
                                                restaurantList[index].reviews,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: Text(restaurantList[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 2),
                      child: Text(restaurantList[index].type,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            )),
  );
}

//Get Restaurants Data from firestore
Future<void> getRestaurants() async {
  List<restaurantModel> temp = [];
  await FirebaseFirestore.instance
      .collection('restaurants')
      .get()
      .then((value) {
    if (value != null) {
      value.docs.forEach((element) {
        temp.add(restaurantModel.fromJson(element.data()));
      });
    } else {
      print('Document does not exist on the database');
    }
    restaurantList = temp;
  });
}

//Get Carousel Slider Data
Future<void> getPhotos() async {
  List<headerModel> temp = [];
  await FirebaseFirestore.instance.collection('headers').get().then((value) {
    if (value != null) {
      value.docs.forEach((element) {
        temp.add(headerModel.fromJson(element.data()));
      });
    } else {
      print('Document does not exist on the database');
    }
    imgList = temp;
  });
}

Future<void> getListWidgets() async {
  await getPhotos();
  getRestaurants();
  List<Widget> imageSliders = imgList.map((item) {
    return Container(
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: [
              Image.network(
                item.Link,
                fit: BoxFit.cover,
                height: 1000,
                width: 1000,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    item.Name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }).toList();
  ImageSliders = imageSliders;
}

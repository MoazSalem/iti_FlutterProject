import 'package:flutter/material.dart';
import 'package:foodly/Screens/NavBar/homePage.dart';
import 'package:foodly/Widgets/appBar.dart';
import '../../Widgets/category_item.dart';
import '../../Widgets/drawer.dart';
import '../../app_data.dart';

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final TextEditingController searchC = TextEditingController();
bool search = false;

class searchPage extends StatefulWidget {
  bool noAppbar;

  searchPage({Key? key, this.noAppbar = false}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  Widget restaurantWidget() {
    return Flexible(
      child: searchedRestaurantList.length == 0
          ? Center(
              child: Text(
              "No Search Results",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ))
          : ListView.builder(
              reverse: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchedRestaurantList.length,
              itemBuilder: (context, index) => Center(
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
                                  width: 400,
                                  height: 150,
                                  child: Image.network(
                                    searchedRestaurantList[index].link,
                                    fit: BoxFit.fitWidth,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
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
                                height: 150,
                                width: 400,
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
                                            "${searchedRestaurantList[index].time} min",
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
                                                  Icons
                                                      .monetization_on_outlined,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  searchedRestaurantList[index]
                                                      .price,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: Container(
                                                decoration: ShapeDecoration
                                                    .fromBoxDecoration(
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: mainColor)),
                                                width: 40,
                                                height: 22,
                                                child: Center(
                                                  child: Text(
                                                    searchedRestaurantList[
                                                            index]
                                                        .reviews,
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
                          child: Text(searchedRestaurantList[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 2),
                          child: Text(searchedRestaurantList[index].type,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                  )),
    );
  }

  void searchRestaurants(String query) {
    final searched = restaurantList.where((restaurant) {
      final title = restaurant.name.toString().toLowerCase();
      final type = restaurant.type.toString().toLowerCase();
      return title.contains(query.toLowerCase()) || type.contains(query.toLowerCase());
    }).toList();
    setState(() {
      searchedRestaurantList = searched;
      searchC.text == "" ? search = false : search = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      key: scaffoldKey,
      appBar: widget.noAppbar
          ? null
          : appBar(
              height: 70,
              context: context,
              mainWidget: titleWidget(context, "Search",
                  Drawer: true, scaffoldKey: scaffoldKey),
              shadow: 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: searchC,
                onChanged: searchRestaurants,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Find A Restaurant"),
              ),
            ),
            search
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        restaurantWidget(),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 7 / 9,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: Categories_data.map((e) => GestureDetector(
                          onTap: () {
                            searchC.text = e.title.toLowerCase();
                            searchRestaurants(e.title.toLowerCase());
                          },
                          child: categoryitem(e.title, e.imageUrl))).toList(),
                    ),
                  ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodly/Widgets/appBar.dart';
import '../../Widgets/category_item.dart';
import '../../Widgets/drawer.dart';
import '../../app_data.dart';

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      key: scaffoldKey,
      appBar: appBar(
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
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Find A Restaurant"
                ),
              ),
            ),
            SizedBox(height: 10,),
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 7 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children:
                  Categories_data.map((e) => categoryitem(e.title, e.imageUrl))
                      .toList(),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

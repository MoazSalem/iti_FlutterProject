import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget titleWidget(BuildContext context, String title,
    {double? titleSize, bool Drawer = false, scaffoldKey}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Drawer
            ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  icon: const Icon(
                    FontAwesomeIcons.bars,
                    size: 18,
                  )),
            )
            : Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 21,
                    )),
              ),
        Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: titleSize ?? 21, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget appBar(
    {required double height,
    required BuildContext context,
    required mainWidget,
    required double shadow}) {
  return PreferredSize(
      preferredSize: Size(double.infinity, height),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: shadow,
        shadowColor: Colors.grey.shade100,
        flexibleSpace: mainWidget,
        centerTitle: true,
      ));
}

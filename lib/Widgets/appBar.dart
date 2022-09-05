import 'package:flutter/material.dart';

Widget titleWidget(BuildContext context,String title, {double? titleSize}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,size: 21,)),
        ),
        Center(
          child: Text(
            title,
            style:
                TextStyle(fontSize: titleSize ?? 21, fontWeight: FontWeight.w500),
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

import 'package:flutter/material.dart';
import 'package:foodly/Screens/Drawer/devTeam.dart';
import '../Screens/Drawer/aboutApp.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      DrawerHeader(
        padding: EdgeInsets.all(0),
        child: Container(
          child: Image.asset(
            "assets/onBoarding/2.png",
            scale: 2,
          ),
          color: Color(0xFFf1efdd),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => aboutApp(),
              ));
        },
        title: const Text("About App"),
        subtitle: const Text("Info about the app"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.info,
            color: Color(0xFF22A45D),
          ),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => devTeam(),
              ));
        },
        title: const Text("Dev Team"),
        subtitle: const Text("Info about the team behind the app"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.people,
            color: Color(0xFF22A45D),
          ),
        ),
      ),
    ]));
  }
}

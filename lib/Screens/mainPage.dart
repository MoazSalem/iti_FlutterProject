import 'NavBar/homePage.dart';
import 'NavBar/searchPage.dart';
import 'NavBar/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int Index = 0;
  List<Widget> page = [const homePage(),
    const searchPage(),
    const profilePage(),
  ];

  onIndexChanged(int index) {
    Index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        selectedFontSize: 13,
        currentIndex: Index,
        onTap: onIndexChanged,
        items: [
          BottomNavigationBarItem(icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(FontAwesomeIcons.houseChimney,size: 18,),
          ),label: "Home"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.search,size: 18,),
              ), label: "Search"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.solidUser,size: 18,),
              ), label: "Profile")
        ],
      ),
      extendBody: true,
      body: page[Index],
    );
  }
}

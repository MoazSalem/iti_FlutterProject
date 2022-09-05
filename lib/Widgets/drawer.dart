import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodly/Screens/Drawer/devTeam.dart';
import 'package:foodly/Screens/Start/start_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Drawer/aboutApp.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      DrawerHeader(
        padding: const EdgeInsets.all(0),
        child: Container(
          color: const Color(0xFFf1efdd),
          child: Image.asset(
            "assets/onBoarding/2.png",
            scale: 2,
          ),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const aboutApp(),
              ));
        },
        title: const Text("About App"),
        subtitle: const Text("Info about the app"),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
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
                builder: (context) => const devTeam(),
              ));
        },
        title: const Text("Dev Team"),
        subtitle: const Text("Info about the team behind the app"),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.people,
            color: Color(0xFF22A45D),
          ),
        ),
      ),
      const Divider(),
      ListTile(
        onTap: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Start(),
              ));
          final prefs = await SharedPreferences.getInstance();
          FirebaseAuth.instance.signOut();
          prefs.setBool("LoggedIn", false);
          //prefs.setString("UID", "0");
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Bye!',
              message: 'Sign Out Successful',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        title: const Text("Sign Out"),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.logout_rounded,
            color: Color(0xFF22A45D),
          ),
        ),
      ),
    ]));
  }
}

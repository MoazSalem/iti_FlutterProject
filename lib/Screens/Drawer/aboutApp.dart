import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly/Widgets/appBar.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/MoazSalem/iti_FlutterProject');

class aboutApp extends StatelessWidget {
  const aboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          appBar: appBar(
              height: 70,
              context: context,
              mainWidget: titleWidget(context, "About App"),
              shadow: 1),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
            child: Column(children: [
              Center(
                  child: Image.asset(
                "assets/onBoarding/3.png",
                height: 200,
                width: 250,
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                "Food Ordering App with a modern UI that uses Firebase Authentication and Firestore Database",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 20,),
              Text(
                "This app was made by a group of 5 students for iti summer training project.",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => _launchUrl(),
                child: Container(
                  height: 60,
                  width: 400,
                  child: Center(
                    child: Text(
                      "Click here to Check the App On Github",
                      style: (TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

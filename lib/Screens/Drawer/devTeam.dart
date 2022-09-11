import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly/Widgets/appBar.dart';
const Color mainColor = Color(0xFF22A45D);
class devTeam extends StatelessWidget {
  const devTeam({Key? key}) : super(key: key);

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
              mainWidget: titleWidget(context, "Dev Team"),
              shadow: 1),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(1),
                      borderRadius: BorderRadius.circular(25)),
                  height: 80,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      title: Text("Moaz Talaat Salem ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      subtitle: Text(
                        "CSE ZU ENG",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25)),
                  height: 80,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      title: Text("Sherif Magdy Marwan",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      subtitle: Text(
                        "FCIS",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25)),
                  height: 80,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      title: Text("Mohamed Ashraf Elmatboly",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      subtitle: Text(
                        "FCIS",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25)),
                  height: 80,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      title: Text("Nada Elsaid AbdElaziz",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      subtitle: Text(
                        "FCIS",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25)),
                  height: 80,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      title: Text("Nadeen AbdElazim AbdElazim Ibrahim",
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                      subtitle: Text(
                        "FCIS",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ))
            ]),
          ),
        ));
  }
}

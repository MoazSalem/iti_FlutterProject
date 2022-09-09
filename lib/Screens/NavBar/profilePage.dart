import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodly/Widgets/appBar.dart';
import '../../Models/user.dart';
import '../../Widgets/drawer.dart';

UserModel User = UserModel(name: "name", email: "email", phone: "phone");
bool isLoading = true;
GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    UserModel? temp;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value != null) {
        temp = UserModel.fromJson(value.data() as Map<String, dynamic>);
        User = temp!;
        setState(() {
          isLoading = false;
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
      key: scaffoldKey,
      appBar: appBar(height: 70, context: context, mainWidget: titleWidget(context, "Profile",Drawer: true,scaffoldKey: scaffoldKey), shadow: 1),
      drawer: MyDrawer(),
            body: ListView(
              children: [
                SizedBox(height: 40,),
                CircleAvatar(radius:50 ,backgroundColor:Theme.of(context).primaryColor,child:Icon(Icons.person_rounded,size: 50,color: Colors.white,) ,),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                    Text(User.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 30,),
                ListTile(title: Text("Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),subtitle: Text(User.email,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),),
                SizedBox(height: 10),
                ListTile(title: Text("Phone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),subtitle: Text(User.phone,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),),
              ],
            ),
          );
  }
}

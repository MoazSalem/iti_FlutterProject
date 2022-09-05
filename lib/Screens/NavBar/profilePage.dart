import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Models/user.dart';

UserModel User = UserModel(name: "name", email: "email", phone: "phone");
bool isLoading = true;

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
    return SafeArea(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(User.name),
                    Text(User.email),
                    Text(User.phone)
                  ],
                ),
              ),
            ),
    );
  }
}

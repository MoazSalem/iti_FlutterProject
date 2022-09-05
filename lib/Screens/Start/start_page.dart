import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:foodly/Widgets/button.dart';
import '../Auth/signin_page.dart';
import '../Auth/signup_page.dart';

class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          body: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 60,
                ),
                child: Center(
                  child: Text("Welcome",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 40),
                child: Center(
                  child: Text(
                    "Order Food Without Leaving Your Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, right: 20.0, left: 20.0, bottom: 40.0),
                  child: Image(
                    image: AssetImage('assets/onBoarding/3.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Button(
                  label: "Sign in",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black54),
                  ),
                  TextButton(
                    child: const Text(
                      "Create New Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

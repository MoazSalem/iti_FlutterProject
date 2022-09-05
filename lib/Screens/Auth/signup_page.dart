import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:foodly/Widgets/appBar.dart';
import 'package:foodly/Widgets/button.dart';
import 'package:foodly/Screens/Start/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Firestore/Users.dart';

Color underLine = Colors.grey.shade300;
late String UID;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordHidden = true;
  bool isLoading = false;
  String name = "";
  String email = "";
  String phone = "";
  String password = "";
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          height: 70,
          context: context,
          mainWidget: titleWidget(context, "Sign Up"),
          shadow: 0),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length < 2) {
                            return "Name must be at least 2 letters long";
                          }
                        },
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: underLine),
                          ),
                          labelText: "Name",
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: TextFormField(
                        focusNode: emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length < 5) {
                            return "email must be more 6 letters";
                          }
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: underLine),
                          ),
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.mail),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          phone = value.toString();
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: underLine),
                          ),
                          labelText: "Phone",
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: TextFormField(
                        obscureText: isPasswordHidden,
                        focusNode: passwordFocusNode,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "password must be more 8 letters";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: underLine),
                            ),
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                isPasswordHidden = !isPasswordHidden;
                                setState(() {});
                              },
                              icon: Icon(isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      child: TextFormField(
                        obscureText: isPasswordHidden,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "password must be more 8 letters";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: underLine),
                            ),
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                isPasswordHidden = !isPasswordHidden;
                                setState(() {});
                              },
                              icon: Icon(isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Button(
                          label: "sign up",
                          onTap: () async {
                            //  if (_formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              isLoading = true;
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password);
                              await userSetup(
                                  name: name, email: email, phone: phone);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const mainPage()),
                              );
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("LoggedIn", true);
                              //prefs.setString("UID", UID);
                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Hello There!',
                                  message: 'Sign Up Successful',
                                  contentType: ContentType.success,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Something is wrong!',
                                  message: 'Error: ${e.toString()}',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

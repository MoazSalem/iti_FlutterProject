import 'package:flutter/material.dart';
import 'package:foodly/Widgets/appBar.dart';
import 'package:foodly/Widgets/button.dart';
import 'package:foodly/Screens/Start/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

Color underLine = Colors.grey.shade300;
late String UID;

class _SignInScreenState extends State<SignInScreen> {
  bool isPasswordHidden = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: appBar(
            height: 70,
            context: context,
            mainWidget: titleWidget(context, "Sign in"),
            shadow: 0),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : InkWell(
                onTap: () {
                  emailFocusNode.unfocus();
                  passwordFocusNode.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
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
                            horizontal: 18.0, vertical: 5),
                        child: TextFormField(
                          focusNode: passwordFocusNode,
                          obscureText: isPasswordHidden,
                          validator: (value) {
                            if (value!.length < 8) {
                              return "password must be at least 8 letters";
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Button(
                          label: "sign in",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                UserCredential user = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                print("user: ${user.user?.email}");
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
                                    message: 'Log in successful',
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
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Something is wrong!',
                                  message:
                                      'Please check the information you entered!',
                                  contentType: ContentType.failure,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

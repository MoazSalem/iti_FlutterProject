import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly/Widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'start_page.dart';

class introPage extends StatefulWidget {
  const introPage({Key? key}) : super(key: key);

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    index == 2 ? isLastPage = true : isLastPage = false;
                  });
                },
                controller: controller,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 350,
                              height: 350,
                              child: const Center(
                                child: Image(
                                    image:
                                        AssetImage('assets/onBoarding/1.png')),
                              )),
                          const Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              textAlign: TextAlign.center,
                              "All Your Favorites",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Order from the best local restaurants with easy, on-demand delivery.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).canvasColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                              width: 300,
                              height: 300,
                              child: const Image(
                                  image:
                                      AssetImage('assets/onBoarding/2.png'))),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Free Delivery Offers",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Free delivery for new customers with Visa and others payment methods.",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).canvasColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 350,
                            height: 350,
                            child: const Image(
                                image: AssetImage('assets/onBoarding/3.png'))),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Choose Your Food",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Easily find your type of food craving and you’ll get delivery in wide range.",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: isLastPage
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Button(
                      label: "Get Started",
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool("showHome", true);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Start()));
                      }),
                )
              : Container(
                  color: Colors.grey.shade100,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            onPressed: () => controller.jumpToPage(2),
                          ),
                          Center(
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: WormEffect(
                                  activeDotColor:
                                      Theme.of(context).primaryColor,
                                  dotHeight: 5,
                                  dotWidth: 10,
                                  spacing: 5),
                            ),
                          ),
                          TextButton(
                            child: const Text("Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            onPressed: () => controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut),
                          )
                        ]),
                  ),
                ),
        ));
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:foodly/Widgets/appBar.dart';
import 'package:foodly/Widgets/button.dart';
import 'homePage.dart';

late double total;

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    setState(() {
      cart.removeWhere((item) => item.count == 0);
      double temp = 0;
      cart.forEach((element) {
        temp += element.price * element.count;
      });
      total = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          height: 70,
          context: context,
          mainWidget: titleWidget(context, "Cart"),
          shadow: 1),
      body: cart.length == 0
          ? Center(
              child: Text(
                "Your Cart Is Empty",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 6,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        int Count = cart[index].count;
                        return ListTile(
                          title: Text(cart[index].name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "${cart[index].price} EGP",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  constraints: BoxConstraints(maxWidth: 40),
                                  onPressed: () {
                                    setState(() {
                                      Count++;
                                      cart[index].count = Count;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 28,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(Count.toString()),
                                ),
                                IconButton(
                                  constraints: BoxConstraints(maxWidth: 40),
                                  onPressed: () {
                                    setState(() {
                                      Count == 0 ? null : Count--;
                                      cart[index].count = Count;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Center(
                    child: Text(
                  "To Be Paid: $total EGP",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Button(
                      label: "Confirm Purchase",
                      onTap: () {
                        cart.forEach((element) {
                          element.count = 0;
                        });
                        cart = [];
                        cartCount = 0;
                        total = 0;
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: "Order is on it's Way",
                            message:
                                'Order Confirmed and now is being processed',
                            contentType: ContentType.success,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
    );
  }
}

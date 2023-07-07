import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/home_page.dart';
import 'package:provider/provider.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';

class editProductQuantity extends StatelessWidget {
  editProductQuantity(
      {super.key,
      required this.activeUserId,
      required this.cartData,
      required this.activeIndex});
  Map<String, dynamic> cartData;
  String activeUserId;
  int activeIndex;
  final TextEditingController customQuantityController =
      TextEditingController();
  final TextEditingController customAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double initialDisc = 0.0;
    double initialQuant = 0.00;
    if (cartData.isNotEmpty && cartData["cartItems"].length > 0) {
      initialDisc = cartData["cartItems"][activeIndex]["discount"];
      initialQuant = cartData["cartItems"][activeIndex]["quantity"];
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 32.0),
        child: Hero(
            tag: 'edit quantity',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (BuildContext context) {
                      return refreshQuantity();
                    }),
                    //ChangeNotifierProvider(create: (BuildContext context) {
                    // return numberOfBillers();
                    //}),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Consumer<refreshQuantity>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black),
                                  )),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Price per Unit",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black),
                                  )),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          cartData["cartItems"][activeIndex]
                                      ["unitOfMeasurement"] ==
                                  "pc"
                              ? Row(
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text(
                                            cartData["cartItems"][activeIndex]
                                                ["productName"],
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: myColor
                                                    .AppColor.darkTheme))),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                            "${cartData["cartItems"][activeIndex]["pricePerUnit"]}",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: myColor
                                                    .AppColor.darkTheme))),
                                    SizedBox(
                                      width: 150,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            tooltip: "Decrease quantity",
                                            onPressed: () {
                                              if (cartData["cartItems"]
                                                          [activeIndex]
                                                      ["quantity"] >=
                                                  1) {
                                                cartData["cartItems"]
                                                        [activeIndex]
                                                    ["quantity"] -= 1.0;
                                                cartData["cartItems"]
                                                        [activeIndex]
                                                    ["discount"] = (cartData[
                                                                    "cartItems"]
                                                                [activeIndex]
                                                            ["quantity"] *
                                                        initialDisc) /
                                                    initialQuant;
                                              }
                                              //if (cartData["cartItems"]
                                              // [activeIndex]
                                              // ["quantity"] ==
                                              //  0) {
                                              //cartData["cartItems"].remove(
                                              // cartData["cartItems"]
                                              //  [activeIndex]);

                                              ///then navgigate back
                                              //Navigator.push(
                                              //context,
                                              // MaterialPageRoute(
                                              // builder: (context) {
                                              // return homeSalesPage(
                                              //  userId: activeUserId,
                                              // myCart: cartData,
                                              // );
                                              // },
                                              //),
                                              //);
                                              // }
                                              context
                                                  .read<refreshQuantity>()
                                                  .hitRefresh();
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 14, 178, 85),
                                            ),
                                          ),
                                          Text(
                                              "${cartData["cartItems"][activeIndex]["quantity"]}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: myColor
                                                      .AppColor.darkTheme)),
                                          IconButton(
                                            tooltip: "Increase quantity",
                                            onPressed: () {
                                              cartData["cartItems"][activeIndex]
                                                  ["quantity"] += 1.0;
                                              cartData["cartItems"][activeIndex]
                                                      ["discount"] =
                                                  (cartData["cartItems"]
                                                                  [activeIndex]
                                                              ["quantity"] *
                                                          initialDisc) /
                                                      initialQuant;
                                              context
                                                  .read<refreshQuantity>()
                                                  .hitRefresh();
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 14, 178, 85),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text(
                                            cartData["cartItems"][activeIndex]
                                                ["productName"],
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: myColor
                                                    .AppColor.darkTheme))),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                            "${cartData["cartItems"][activeIndex]["pricePerUnit"]}",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: myColor
                                                    .AppColor.darkTheme))),
                                    SizedBox(
                                        width: 150,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              tooltip: "Decrease quantity",
                                              onPressed: () {
                                                if (cartData["cartItems"]
                                                            [activeIndex]
                                                        ["quantity"] >=
                                                    0.25) {
                                                  cartData["cartItems"]
                                                          [activeIndex]
                                                      ["quantity"] -= 0.25;
                                                  cartData["cartItems"]
                                                          [activeIndex]
                                                      ["discount"] = (cartData[
                                                                      "cartItems"]
                                                                  [activeIndex]
                                                              ["quantity"] *
                                                          initialDisc) /
                                                      initialQuant;
                                                }
                                                //if (cartData["cartItems"]
                                                // [activeIndex]
                                                // ["quantity"] ==
                                                //  0) {
                                                //cartData["cartItems"].remove(
                                                // cartData["cartItems"]
                                                //  [activeIndex]);

                                                ///then navgigate back
                                                //Navigator.push(
                                                //context,
                                                // MaterialPageRoute(
                                                // builder: (context) {
                                                // return homeSalesPage(
                                                //  userId: activeUserId,
                                                // myCart: cartData,
                                                // );
                                                // },
                                                //),
                                                //);
                                                // }
                                                context
                                                    .read<refreshQuantity>()
                                                    .hitRefresh();
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 13,
                                                color: Color.fromARGB(
                                                    255, 14, 178, 85),
                                              ),
                                            ),
                                            Text(
                                                "${cartData["cartItems"][activeIndex]["quantity"]} ${cartData["cartItems"][activeIndex]["unitOfMeasurement"]}",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme)),
                                            IconButton(
                                              tooltip: "Increase quantity",
                                              onPressed: () {
                                                cartData["cartItems"]
                                                        [activeIndex]
                                                    ["quantity"] += 0.25;
                                                cartData["cartItems"]
                                                        [activeIndex]
                                                    ["discount"] = (cartData[
                                                                    "cartItems"]
                                                                [activeIndex]
                                                            ["quantity"] *
                                                        initialDisc) /
                                                    initialQuant;
                                                context
                                                    .read<refreshQuantity>()
                                                    .hitRefresh();
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 13,
                                                color: Color.fromARGB(
                                                    255, 14, 178, 85),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("OR"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        controller: customQuantityController,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            customAmountController.text = "";
                                            if (double.parse(value) > 0) {
                                              cartData["cartItems"][activeIndex]
                                                      ["quantity"] =
                                                  double.parse(value);
                                              cartData["cartItems"][activeIndex]
                                                      ["discount"] =
                                                  (cartData["cartItems"]
                                                                  [activeIndex]
                                                              ["quantity"] *
                                                          initialDisc) /
                                                      initialQuant;
                                              context
                                                  .read<refreshQuantity>()
                                                  .hitRefresh();
                                            }
                                          }
                                        },
                                        validator: (value) {},
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          //border: InputBorder.none,
                                          hintText: 'Enter custom quantity',
                                          hintStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 11),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      96, 0, 0, 0))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      179, 22, 27, 137))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("OR"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        controller: customAmountController,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            if (double.parse(value) > 0) {
                                              customQuantityController.text =
                                                  "";
                                              cartData["cartItems"][activeIndex]
                                                      ["quantity"] =
                                                  double.parse(value);
                                              cartData["cartItems"][activeIndex]
                                                      ["quantity"] =
                                                  double.parse((double.parse(
                                                              value) /
                                                          cartData["cartItems"]
                                                                  [activeIndex]
                                                              ["pricePerUnit"])
                                                      .toStringAsFixed(2));
                                              cartData["cartItems"][activeIndex]
                                                      ["discount"] =
                                                  (cartData["cartItems"]
                                                                  [activeIndex]
                                                              ["quantity"] *
                                                          initialDisc) /
                                                      initialQuant;
                                              context
                                                  .read<refreshQuantity>()
                                                  .hitRefresh();
                                            }
                                          } else {
                                            value = "0.00";
                                            cartData["cartItems"][activeIndex]
                                                    ["quantity"] =
                                                double.parse(value);
                                            cartData["cartItems"][activeIndex]
                                                    ["quantity"] =
                                                double.parse((double.parse(
                                                            value) /
                                                        cartData["cartItems"]
                                                                [activeIndex]
                                                            ["pricePerUnit"])
                                                    .toStringAsFixed(2));
                                            cartData["cartItems"][activeIndex]
                                                    ["discount"] =
                                                (cartData["cartItems"]
                                                                [activeIndex]
                                                            ["quantity"] *
                                                        initialDisc) /
                                                    initialQuant;
                                            context
                                                .read<refreshQuantity>()
                                                .hitRefresh();
                                          }
                                        },
                                        validator: (value) {},
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          //border: InputBorder.none,
                                          hintText: 'Enter custom amount',
                                          hintStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 11),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      96, 0, 0, 0))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      179, 22, 27, 137))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(221, 255, 255, 255),
                                    backgroundColor:
                                        Color.fromARGB(255, 205, 173, 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                  ),
                                  onPressed: () {
                                    cartData["cartItems"][activeIndex]
                                        ["quantity"] = initialQuant;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return homeSalesPage(
                                            userId: activeUserId,
                                            myCart: cartData,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)))),
                              SizedBox(
                                width: 50,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(221, 255, 255, 255),
                                    backgroundColor:
                                        Color.fromARGB(255, 32, 147, 42),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return homeSalesPage(
                                            userId: activeUserId,
                                            myCart: cartData,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text("Update Value",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)))),
                              Expanded(child: Container()),
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

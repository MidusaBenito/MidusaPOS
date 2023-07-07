import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/paused_cart_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:provider/provider.dart';

class resumePausedCart extends StatelessWidget {
  resumePausedCart({
    super.key,
    required this.activeUserId,
    required this.cartData,
  });
  String activeUserId;
  Map<String, dynamic> cartData;
  List<Map<String, dynamic>> new_paused_cart_database =
      pausedCartDetailsPreference.getPausedCartData() ?? [];

  Color activeCustomerColor = Color.fromARGB(255, 205, 173, 14);
  @override
  Widget build(BuildContext context) {
    //new_paused_cart_database = new_paused_cart_database.reversed.toList();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'resumePausedCart',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (BuildContext context) {
                      return updatePausedCarts();
                    }),
                    //ChangeNotifierProvider(create: (BuildContext context) {
                    // return numberOfBillers();
                    //}),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Resume Transaction",
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "Click on any cart to resume transaction",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return homeSalesPage(
                                                  userId: activeUserId,
                                                  myCart: cartData);
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Close",
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Consumer<updatePausedCarts>(
                                  builder: (context, value, child) {
                                return Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: .15, color: Colors.black),
                                      color: Color.fromRGBO(242, 242, 242, .5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: Column(
                                      children: [
                                        //starting here
                                        Expanded(
                                            child: Container(
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount:
                                                  new_paused_cart_database
                                                      .length,
                                              itemBuilder: (context, index) {
                                                var pausedCartInstance =
                                                    new_paused_cart_database[
                                                        index];
                                                double hFactor =
                                                    pausedCartInstance[
                                                            "cartItems"]
                                                        .length
                                                        .toDouble();
                                                return Column(
                                                  children: [
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          //print("clicked");
                                                          cartData =
                                                              pausedCartInstance;
                                                          List<dynamic>
                                                              dynamicCartItems =
                                                              pausedCartInstance[
                                                                  "cartItems"];
                                                          List<
                                                                  Map<String,
                                                                      dynamic>>
                                                              mapCartItems =
                                                              dynamicCartItems
                                                                  .map((dynamic
                                                                      item) {
                                                            // Assuming each dynamic item is a Map<String, dynamic>
                                                            return item as Map<
                                                                String,
                                                                dynamic>;
                                                          }).toList();
                                                          cartData[
                                                                  "cartItems"] =
                                                              mapCartItems;
                                                          //print(mapCartItems
                                                          // .runtimeType);
                                                          new_paused_cart_database
                                                              .removeAt(index);
                                                          await pausedCartDetailsPreference
                                                              .setPausedCartData(
                                                                  new_paused_cart_database);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return homeSalesPage(
                                                                    userId:
                                                                        activeUserId,
                                                                    myCart:
                                                                        cartData);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  width: .15,
                                                                  color: Colors
                                                                      .black),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      25,
                                                                      193,
                                                                      193,
                                                                      0.486),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "Cart Id:",
                                                                        style: TextStyle(
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            fontFamily:
                                                                                'Proxima',
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black)),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                        pausedCartInstance[
                                                                            "cartId"],
                                                                        style: TextStyle(
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            fontFamily:
                                                                                'Proxima',
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black)),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    IconButton(
                                                                        tooltip:
                                                                            "Delete this cart",
                                                                        onPressed:
                                                                            () async {
                                                                          new_paused_cart_database
                                                                              .removeAt(index);
                                                                          await pausedCartDetailsPreference
                                                                              .setPausedCartData(new_paused_cart_database);
                                                                          context
                                                                              .read<updatePausedCarts>()
                                                                              .hitRefresh();
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.deepPurple,
                                                                          size:
                                                                              15,
                                                                        ))
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "Cart items",
                                                                        style: TextStyle(
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            fontFamily:
                                                                                'Proxima',
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black)),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 400,
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            "Product name",
                                                                            style: TextStyle(
                                                                                fontFamily: 'Oswald',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 12,
                                                                                color: Color.fromARGB(255, 0, 0, 0)),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Quantity",
                                                                            style: TextStyle(
                                                                                fontFamily: 'Oswald',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 12,
                                                                                color: Color.fromARGB(255, 0, 0, 0)),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Price per unit",
                                                                            style: TextStyle(
                                                                                fontFamily: 'Oswald',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 12,
                                                                                color: Color.fromARGB(255, 0, 0, 0)),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Discount",
                                                                            style: TextStyle(
                                                                                fontFamily: 'Oswald',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 12,
                                                                                color: Color.fromARGB(255, 0, 0, 0)),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                //widget
                                                                Container(
                                                                    width: 400,
                                                                    height: 17.0 *
                                                                        hFactor,
                                                                    child: ListView.builder(
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        itemCount: pausedCartInstance["cartItems"].length,
                                                                        itemBuilder: (context, index) {
                                                                          var itemInstance =
                                                                              pausedCartInstance["cartItems"][index];
                                                                          return SizedBox(
                                                                            width:
                                                                                400,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    flex: 2,
                                                                                    child: Text(
                                                                                      itemInstance["productName"],
                                                                                      style: TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.w400, fontSize: 11, color: myColor.AppColor.darkTheme),
                                                                                    )),
                                                                                Expanded(
                                                                                    flex: 1,
                                                                                    child: Text(
                                                                                      "${itemInstance["quantity"]}",
                                                                                      style: TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.w400, fontSize: 11, color: myColor.AppColor.darkTheme),
                                                                                    )),
                                                                                Expanded(
                                                                                    flex: 1,
                                                                                    child: Text(
                                                                                      "${itemInstance["pricePerUnit"]}",
                                                                                      style: TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.w400, fontSize: 11, color: myColor.AppColor.darkTheme),
                                                                                    )),
                                                                                Expanded(
                                                                                    flex: 1,
                                                                                    child: Text(
                                                                                      "${itemInstance["discount"]}",
                                                                                      style: TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.w400, fontSize: 11, color: myColor.AppColor.darkTheme),
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          );
                                                                        })),
                                                                //end
                                                                SizedBox(
                                                                  height: 10,
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                );
                                              }),
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/customer_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:provider/provider.dart';

class attachCustomer extends StatelessWidget {
  attachCustomer({
    super.key,
    required this.activeUserId,
    required this.cartData,
  });
  String activeUserId;
  Map<String, dynamic> cartData;
  List<Map<String, dynamic>> new_customer_database =
      customerDetailsPreference.getCustomerData() ?? [];
  List<Map<String, dynamic>> searched_customer_response = [];
  Color activeCustomerColor = Color.fromARGB(255, 205, 173, 14);
  String itemsToShow = "all";
  @override
  Widget build(BuildContext context) {
    new_customer_database
        .sort((a, b) => b["lastUpdatedOn"].compareTo(a["lastUpdatedOn"]));
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'attachCustomerData',
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
                      return updateCustomer();
                    }),
                    ChangeNotifierProvider(create: (BuildContext context) {
                      return displayCustomers();
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
                                        "Attach Customer to Cart",
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
                                          Text("Cart Id:",
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
                                          Text(cartData["cartId"],
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: myColor
                                                      .AppColor.darkTheme))
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
                              Expanded(
                                child: Consumer<displayCustomers>(
                                    builder: (context, value, child) {
                                  return Container(
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
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: TextFormField(
                                                validator: (value) {},
                                                onChanged: (value) {
                                                  searched_customer_response =
                                                      searchedCustomer(
                                                          new_customer_database,
                                                          value);
                                                  context
                                                      .read<displayCustomers>()
                                                      .changeTypeOfDisplay(
                                                          "search");
                                                },
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 12,
                                                ),
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(
                                                      color: Colors.redAccent),
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                  //border: InputBorder.none,
                                                  hintText: 'Search...',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 11),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          96,
                                                                          0,
                                                                          0,
                                                                          0))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      179,
                                                                      22,
                                                                      27,
                                                                      137))),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "Search customer using phone number",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Colors.black))
                                          ],
                                        ),
                                        //content goes here
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "First Name",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "Last Name",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "Phone Number",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Action",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<displayCustomers>(
                                            builder: (context, value, child) {
                                          itemsToShow = value.typeOfDisplay;
                                          return Expanded(child:
                                              Consumer<updateCustomer>(builder:
                                                  (context, value, child) {
                                            return Container(
                                              child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: itemsToShow ==
                                                          "all"
                                                      ? new_customer_database
                                                          .length
                                                      : searched_customer_response
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var customerInstance =
                                                        itemsToShow == "all"
                                                            ? new_customer_database[
                                                                index]
                                                            : searched_customer_response[
                                                                index];
                                                    bool customerFound = false;
                                                    if (customerInstance[
                                                            "customerId"] ==
                                                        cartData[
                                                            "customerId"]) {
                                                      customerFound = true;
                                                    }
                                                    if (new_customer_database
                                                            .length >
                                                        0) {
                                                      return Row(children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              customerInstance[
                                                                  "firstName"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: customerFound ==
                                                                          true
                                                                      ? activeCustomerColor
                                                                      : myColor
                                                                          .AppColor
                                                                          .darkTheme),
                                                            )),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              customerInstance[
                                                                  "lastName"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: customerFound ==
                                                                          true
                                                                      ? activeCustomerColor
                                                                      : myColor
                                                                          .AppColor
                                                                          .darkTheme),
                                                            )),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              customerInstance[
                                                                  "phoneNumber"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: customerFound ==
                                                                          true
                                                                      ? activeCustomerColor
                                                                      : myColor
                                                                          .AppColor
                                                                          .darkTheme),
                                                            )),
                                                        Expanded(
                                                          flex: 1,
                                                          child: IconButton(
                                                            tooltip: customerFound ==
                                                                    true
                                                                ? "Remove this customer from cart"
                                                                : "Attach this customer to cart",
                                                            onPressed: () {
                                                              if (customerFound ==
                                                                  true) {
                                                                cartData[
                                                                        "customerId"] =
                                                                    "_";
                                                              } else {
                                                                cartData[
                                                                        "customerId"] =
                                                                    customerInstance[
                                                                        "customerId"];
                                                              }
                                                              context
                                                                  .read<
                                                                      updateCustomer>()
                                                                  .hitRefresh();
                                                            },
                                                            icon: customerFound ==
                                                                    true
                                                                ? Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    size: 20,
                                                                    color:
                                                                        activeCustomerColor)
                                                                : Icon(
                                                                    Icons
                                                                        .add_circle,
                                                                    size: 20,
                                                                    color: myColor
                                                                        .AppColor
                                                                        .darkTheme),
                                                          ),
                                                        )
                                                      ]);
                                                    } else {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Text(
                                                            "No customer available!",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  Container())
                                                        ],
                                                      );
                                                    }
                                                  }),
                                            );
                                          }));
                                        })
                                      ],
                                    ),
                                  );
                                }),
                              )
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

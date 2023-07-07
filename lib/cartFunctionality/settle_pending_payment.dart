import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_hero_routes.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/cartFunctionality/account_sales.dart';
import 'package:midusa_pos/cartFunctionality/cart_hero_routes.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/customer_utils.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/sale_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:provider/provider.dart';

import '../admin_dashboard_pages/ViewSingleItem/view_transaction.dart';

class settlePendingPayment extends StatelessWidget {
  settlePendingPayment({
    super.key,
    required this.activeUserId,
    required this.cartData,
    required this.transInstance,
  });
  String activeUserId;
  Map<String, dynamic> cartData;
  Map<String, dynamic> transInstance;
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_sale_database =
      saleDetailsPreference.getSaleData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  double returnBalance = 0.00;
  bool buttonVisible = false;
  bool outstandingBalance = false;
  bool balanceToReturn = false;
  double cartTotal = 0.00;
  double amountReceived = 0.00;
  double balanceOutstanding = 0.00;
  double cashReceived = 0.00;
  String paymentType = "";
  bool paymentSelected = false;
  @override
  Widget build(BuildContext context) {
    amountReceived = double.parse(transInstance["cashReceived"]);
    balanceOutstanding = double.parse(transInstance["creditDue"]);
    Map<String, dynamic> tempCart = {};
    tempCart["cartItems"] = transInstance["cartDetails"];
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'settlePendingPayment',
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
                      return clearPendingPayments();
                    }),
                    //ChangeNotifierProvider(create: (BuildContext context) {
                    //return displayCustomers();
                    //}),
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
                                        "Settle pending payment",
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
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
                                  child: Consumer<clearPendingPayments>(
                                      builder: (context, value, child) {
                                    return ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //content goes here
                                              Row(
                                                children: [
                                                  Text(
                                                    "Transaction Id:",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 109, 18, 18)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(transInstance["saleId"],
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor
                                                            .AppColor.darkTheme,
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 400,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "Product name",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Oswald',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              "Quantity",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Oswald',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              "Price per unit",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Oswald',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              "Discount",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Oswald',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              "Total",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Oswald',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      width: 400,
                                                      height: 17.0 *
                                                          transInstance[
                                                                  "cartDetails"]
                                                              .length
                                                              .toDouble(),
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: transInstance[
                                                                  "cartDetails"]
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var itemInstance =
                                                                transInstance[
                                                                        "cartDetails"]
                                                                    [index];
                                                            double total = (itemInstance[
                                                                        "pricePerUnit"] *
                                                                    itemInstance[
                                                                        "quantity"]) -
                                                                itemInstance[
                                                                    "discount"];
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      itemInstance[
                                                                          "productName"],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              11,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme),
                                                                    )),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${itemInstance["quantity"]}",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              11,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme),
                                                                    )),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${itemInstance["pricePerUnit"]}",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              11,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme),
                                                                    )),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${itemInstance["discount"]}",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              11,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme),
                                                                    )),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "$total",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              11,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme),
                                                                    )),
                                                              ],
                                                            );
                                                          }))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              paymentsTotal(tempCart),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Container()),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Text(
                                                            "Total paid:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Oswald',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        10,
                                                                        53,
                                                                        107)),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "$amountReceived",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Oswald',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        10,
                                                                        53,
                                                                        107)),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            "Total due:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Oswald',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "$balanceOutstanding",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Oswald',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              paymentSelected == false
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        IconButton(
                                                            onPressed: () {
                                                              paymentSelected =
                                                                  true;
                                                              paymentType =
                                                                  "cash";
                                                              context
                                                                  .read<
                                                                      clearPendingPayments>()
                                                                  .hitRefresh();
                                                            },
                                                            icon: Container(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .monetization_on,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                  Text(
                                                                      "Pay with cash",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              10,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme)),
                                                                ],
                                                              ),
                                                            )),
                                                        SizedBox(width: 30),
                                                        IconButton(
                                                            onPressed: () {
                                                              paymentSelected =
                                                                  true;
                                                              paymentType =
                                                                  "mpesa";
                                                              context
                                                                  .read<
                                                                      clearPendingPayments>()
                                                                  .hitRefresh();
                                                            },
                                                            icon: Container(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .phone_android,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                  Text(
                                                                      "Pay via mpesa",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              10,
                                                                          color: myColor
                                                                              .AppColor
                                                                              .darkTheme)),
                                                                ],
                                                              ),
                                                            ))
                                                      ],
                                                    )
                                                  : Container(),
                                              paymentSelected == true
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        Text("Amount:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: myColor
                                                                    .AppColor
                                                                    .darkTheme)),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                            width: 90,
                                                            child:
                                                                TextFormField(
                                                              onChanged:
                                                                  (value) {
                                                                RegExp regex =
                                                                    RegExp(
                                                                        r'^[+-]?(\d+|\d{1,3}(,\d{3})*)(\.\d+)?$');
                                                                if (regex.hasMatch(
                                                                        value) ==
                                                                    true) {
                                                                  //print("valid");
                                                                  if (double.parse(
                                                                          value) >=
                                                                      double.parse(
                                                                          transInstance[
                                                                              "creditDue"])) {
                                                                    balanceToReturn =
                                                                        true;
                                                                    outstandingBalance =
                                                                        false;
                                                                    returnBalance = double.parse(
                                                                            value) -
                                                                        double.parse(
                                                                            transInstance["creditDue"]);
                                                                    amountReceived = double.parse(transInstance[
                                                                            "cashReceived"]) +
                                                                        double.parse(
                                                                            value) -
                                                                        returnBalance;
                                                                    balanceOutstanding =
                                                                        0.00;
                                                                    buttonVisible =
                                                                        true;
                                                                    cashReceived =
                                                                        double.parse(
                                                                            value);
                                                                    context
                                                                        .read<
                                                                            clearPendingPayments>()
                                                                        .hitRefresh();
                                                                  } else {
                                                                    balanceToReturn =
                                                                        false;
                                                                    outstandingBalance =
                                                                        true;
                                                                    returnBalance =
                                                                        0.00;
                                                                    amountReceived = double.parse(transInstance[
                                                                            "cashReceived"]) +
                                                                        double.parse(
                                                                            value) -
                                                                        returnBalance;
                                                                    balanceOutstanding = double.parse(transInstance[
                                                                            "creditDue"]) -
                                                                        double.parse(
                                                                            value);
                                                                    buttonVisible =
                                                                        false;
                                                                    cashReceived =
                                                                        double.parse(
                                                                            value);
                                                                    context
                                                                        .read<
                                                                            clearPendingPayments>()
                                                                        .hitRefresh();
                                                                  }
                                                                }
                                                                if (value
                                                                        .length ==
                                                                    0) {
                                                                  balanceToReturn =
                                                                      false;
                                                                  outstandingBalance =
                                                                      false;
                                                                  returnBalance =
                                                                      0.00;
                                                                  amountReceived =
                                                                      0.00;
                                                                  balanceOutstanding =
                                                                      double.parse(
                                                                              transInstance["creditDue"]) -
                                                                          0.00;
                                                                  buttonVisible =
                                                                      false;
                                                                  context
                                                                      .read<
                                                                          clearPendingPayments>()
                                                                      .hitRefresh();
                                                                }
                                                              },
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          3,
                                                                          139,
                                                                          55)),
                                                              decoration:
                                                                  InputDecoration(
                                                                errorStyle: TextStyle(
                                                                    color: Colors
                                                                        .redAccent),
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            10),
                                                                //border: InputBorder.none,
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            96,
                                                                            0,
                                                                            0,
                                                                            0))),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            179,
                                                                            22,
                                                                            27,
                                                                            137))),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          width: 20,
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              outstandingBalance == true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Text(
                                                              "Outstanding\nbalance:",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .redAccent)),
                                                          SizedBox(
                                                            width: 90,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                  "$balanceOutstanding",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Proxima',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          83,
                                                                          14,
                                                                          14))),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              balanceToReturn == true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Text("Return:",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          10,
                                                                          53,
                                                                          107))),
                                                          SizedBox(
                                                            width: 90,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                  "$returnBalance",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Proxima',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          83,
                                                                          14,
                                                                          14))),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              buttonVisible == true
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          221,
                                                                          255,
                                                                          255,
                                                                          255),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          32,
                                                                          147,
                                                                          42),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              2))),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              for (int i = 0;
                                                                  i <
                                                                      new_sale_database
                                                                          .length;
                                                                  i++) {
                                                                if (transInstance[
                                                                        "saleId"] ==
                                                                    new_sale_database[
                                                                            i][
                                                                        "saleId"]) {
                                                                  new_sale_database[
                                                                              i]
                                                                          [
                                                                          "cashReceived"] =
                                                                      cashReceived
                                                                          .toString();
                                                                  new_sale_database[
                                                                              i]
                                                                          [
                                                                          "cashReturned"] =
                                                                      returnBalance
                                                                          .toString();
                                                                  new_sale_database[
                                                                              i]
                                                                          [
                                                                          "creditDue"] =
                                                                      balanceOutstanding
                                                                          .toString();
                                                                  DateTime
                                                                      currentDateTime =
                                                                      DateTime
                                                                          .now();
                                                                  String
                                                                      formattedDateTime =
                                                                      DateFormat(
                                                                              'dd/MM/yyyy HH:mm:ss')
                                                                          .format(
                                                                              currentDateTime);
                                                                  new_sale_database[
                                                                              i]
                                                                          [
                                                                          "lastUpdatedOn"] =
                                                                      formattedDateTime;
                                                                  if (balanceOutstanding ==
                                                                      0.0) {
                                                                    new_sale_database[i]
                                                                            [
                                                                            "settlementStatus"] =
                                                                        "settled";
                                                                    new_sale_database[i]
                                                                            [
                                                                            "checkoutMethod"] =
                                                                        paymentType;
                                                                  }
                                                                }
                                                              }
                                                              await saleDetailsPreference
                                                                  .setSaleData(
                                                                      new_sale_database);
                                                              Navigator.of(context).push(
                                                                  CartHeroDialogRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return viewAccountSales(
                                                                          activeUserId:
                                                                              activeUserId,
                                                                          cartData:
                                                                              cartData,
                                                                        );
                                                                      },
                                                                      settings: RouteSettings(
                                                                          arguments:
                                                                              "viewAccountSales")));
                                                            },
                                                            child: Text("Done",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Oswald',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)))),
                                                        Expanded(
                                                            child: Container()),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          );
                                        });
                                  }),
                                ),
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

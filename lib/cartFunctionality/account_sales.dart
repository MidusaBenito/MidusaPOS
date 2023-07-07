import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_hero_routes.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/cartFunctionality/cart_hero_routes.dart';
import 'package:midusa_pos/cartFunctionality/settle_pending_payment.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/customer_utils.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/sale_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:provider/provider.dart';

import '../admin_dashboard_pages/ViewSingleItem/view_transaction.dart';

class viewAccountSales extends StatelessWidget {
  viewAccountSales({
    super.key,
    required this.activeUserId,
    required this.cartData,
  });
  String activeUserId;
  Map<String, dynamic> cartData;
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_sale_database =
      saleDetailsPreference.getSaleData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  String filterByProd = "all";
  String filterByPaymentType = "credit";
  String filterBySettlementStatus = "all";
  String filterByDate = "all";
  @override
  Widget build(BuildContext context) {
    var transactionItems = processTransactionList(
        new_product_database,
        new_sale_database,
        new_user_database,
        filterByProd,
        filterByPaymentType,
        filterBySettlementStatus,
        filterByDate);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'viewTodaySales',
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
                      return filterSaleItems();
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
                                        "Account Sales (Sales Made on Credit)",
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
                                  child: Consumer<filterSaleItems>(
                                      builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        //content goes here
                                        Row(
                                          children: [
                                            Text(
                                              "Filter by",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(children: [
                                          SizedBox(
                                              width: 150,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Payment status",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    ),
                                                    SizedBox(height: 5),
                                                    DropdownButtonFormField(
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.0,
                                                            color: Colors.black,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        5),
                                                      ),
                                                      value:
                                                          filterBySettlementStatus,
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: "all",
                                                          child: Text(
                                                            "All",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "settled",
                                                          child: Text(
                                                            "Settled",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "not settled",
                                                          child: Text(
                                                            "Not Settled",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        filterBySettlementStatus =
                                                            value.toString();
                                                        transactionItems = processTransactionList(
                                                            new_product_database,
                                                            new_sale_database,
                                                            new_user_database,
                                                            filterByProd,
                                                            filterByPaymentType,
                                                            filterBySettlementStatus,
                                                            filterByDate);
                                                        context
                                                            .read<
                                                                filterSaleItems>()
                                                            .hitRefresh();
                                                      },
                                                    )
                                                  ])),
                                          SizedBox(width: 30),
                                          SizedBox(
                                              width: 150,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Date",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    ),
                                                    SizedBox(height: 5),
                                                    DropdownButtonFormField(
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.0,
                                                            color: Colors.black,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        5),
                                                      ),
                                                      value: filterByDate,
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: "all",
                                                          child: Text(
                                                            "All",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "today",
                                                          child: Text(
                                                            "Today",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "this week",
                                                          child: Text(
                                                            "This Week",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "last week",
                                                          child: Text(
                                                            "Last Week",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "this month",
                                                          child: Text(
                                                            "This Month",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "last month",
                                                          child: Text(
                                                            "Last Month",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                      onChanged: (value) {
                                                        filterByDate =
                                                            value.toString();
                                                        transactionItems = processTransactionList(
                                                            new_product_database,
                                                            new_sale_database,
                                                            new_user_database,
                                                            filterByProd,
                                                            filterByPaymentType,
                                                            filterBySettlementStatus,
                                                            filterByDate);
                                                        context
                                                            .read<
                                                                filterSaleItems>()
                                                            .hitRefresh();
                                                      },
                                                    )
                                                  ])),
                                        ]),
                                        //display
                                        SizedBox(height: 10),
                                        Row(children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Transacted amount",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Payment type",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Status",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Served by",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Action",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 109, 18, 18)),
                                              )),
                                          SizedBox(width: 5),
                                        ]),
                                        Expanded(
                                          child: transactionItems.length > 0
                                              ? Container(
                                                  child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          transactionItems
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var transInstance =
                                                            transactionItems[
                                                                index];
                                                        return Column(
                                                          children: [
                                                            Row(children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${transInstance["amountTotal"]}",
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontFamily:
                                                                            'Proxima',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${transInstance["checkoutMethod"]}",
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontFamily:
                                                                            'Proxima',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${transInstance["settlementStatus"]}",
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontFamily:
                                                                            'Proxima',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${transInstance["servedBy"]}",
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontFamily:
                                                                            'Proxima',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${transInstance["lastUpdatedOn"]}",
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontFamily:
                                                                            'Proxima',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        tooltip:
                                                                            "view more details",
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context).push(ViewHeroDialogRoute(
                                                                              builder: (context) {
                                                                                return viewSingleTransaction(
                                                                                  transactionInstance: transInstance,
                                                                                  productList: new_product_database,
                                                                                  userList: new_user_database,
                                                                                );
                                                                              },
                                                                              settings: RouteSettings(arguments: "viewTransaction")));
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .visibility,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                      ),
                                                                      transInstance["settlementStatus"] ==
                                                                              "not settled"
                                                                          ? IconButton(
                                                                              tooltip: "settle pending payment",
                                                                              onPressed: () {
                                                                                Navigator.of(context).push(CartHeroDialogRoute(
                                                                                    builder: (context) {
                                                                                      return settlePendingPayment(
                                                                                        activeUserId: activeUserId,
                                                                                        cartData: cartData,
                                                                                        transInstance: transInstance,
                                                                                      );
                                                                                    },
                                                                                    settings: RouteSettings(arguments: "viewAccountSales")));
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.monetization_on,
                                                                                size: 20,
                                                                                color: Colors.redAccent,
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  )),
                                                              SizedBox(
                                                                  width: 5),
                                                            ]),
                                                            SizedBox(height: 5),
                                                          ],
                                                        );
                                                      }),
                                                )
                                              : Container(
                                                  child: Row(children: [
                                                  Expanded(child: Container()),
                                                  Text(
                                                    "No sales available for this period!",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                  Expanded(child: Container()),
                                                ])),
                                        ),
                                      ],
                                    );
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

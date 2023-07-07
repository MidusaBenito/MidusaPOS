import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:provider/provider.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class viewSingleTransaction extends StatelessWidget {
  viewSingleTransaction({
    super.key,
    required this.transactionInstance,
    required this.productList,
    required this.userList,
  });
  Map<String, dynamic> transactionInstance;
  List<Map<String, dynamic>> productList;
  List<Map<String, dynamic>> userList;
  @override
  Widget build(BuildContext context) {
    //print(transactionInstance);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'viewTransactionData',
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Transaction Details",
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
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ), //
                            Expanded(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    double hFactor =
                                        transactionInstance["cartDetails"]
                                            .length
                                            .toDouble();
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Table(
                                            border: TableBorder.all(),
                                            columnWidths: {
                                              0: FlexColumnWidth(2),
                                              1: FlexColumnWidth(5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Transaction ID',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "saleId"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Payment type',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "checkoutMethod"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Served by',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "servedBy"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'Transaction date',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "transactionDate"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Last updated on',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "lastUpdatedOn"]),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Payment status',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "settlementStatus"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Total billed',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "amountTotal"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Cash received',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "cashReceived"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Cash returned',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "cashReturned"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Credit due',
                                                      style: TextStyle(
                                                          fontFamily: 'Oswald',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                )),
                                                TableCell(
                                                    child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      transactionInstance[
                                                          "creditDue"],
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                ))
                                              ]),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text("Cart items",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 109, 18, 18))),
                                              SizedBox(
                                                width: 80,
                                              ),
                                              //here
                                              customerNames(transactionInstance[
                                                  "customerId"]),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 400,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
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
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
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
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
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
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
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
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  width: 400,
                                                  height: 17.0 * hFactor,
                                                  child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          transactionInstance[
                                                                  "cartDetails"]
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var itemInstance =
                                                            transactionInstance[
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                          //add cart total
                                          //SizedBox(height: 10),
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
            )),
      ),
    );
  }
}

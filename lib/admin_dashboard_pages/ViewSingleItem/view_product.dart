import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/workers/workers.dart';

class viewSingleProduct extends StatelessWidget {
  viewSingleProduct({
    super.key,
    required this.productInstance,
    required this.categoryName,
    required this.supplierName,
    required this.userRole,
  });
  Map<String, dynamic> productInstance;
  String categoryName;
  String supplierName;
  String userRole;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'viewUserData',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Details",
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
                                        "Full details of:",
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        productInstance["productName"],
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
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
                      ),
                      Container(
                        child: Column(
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
                                    child: Text('Product ID',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["productId"],
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Name',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["productName"],
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Category',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(categoryName,
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Supplier',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(supplierName,
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ))
                                ]),
                                //Comment from here
                                //TableRow(children: [
                                // TableCell(
                                // child: Container(
                                //padding: EdgeInsets.all(8.0),
                                // child: Text('Supplier payment status',
                                // style: TextStyle(
                                //fontFamily: 'Oswald',
                                //fontWeight: FontWeight.w400,
                                //fontSize: 13,
                                //color: Colors.black)),
                                // )),
                                //TableCell(
                                //child: Container(
                                //padding: EdgeInsets.all(8.0),
                                // child: Text(productInstance[
                                // "supplierPaymentStatus"]),
                                //  ))
                                // ]),
                                //to here
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Unit of measurement',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        productInstance["unitOfMeasurement"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Available quantity',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["quantity"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Stock purchase price',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["stockPrice"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Retail price per unit',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["retailPrice"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Discount type',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Text(productInstance["discountType"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Recommended discount',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        productInstance["recommendedDiscount"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Expiry date',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["expiryDate"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Created by',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(userRole),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Date created',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(productInstance["createdOn"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Last updated on',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        productInstance["lastUpdatedOn"],
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ))
                                ]),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

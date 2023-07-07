import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/workers/workers.dart';

class viewSingleSupplier extends StatelessWidget {
  viewSingleSupplier({
    super.key,
    required this.supplierInstance,
    //required this.categoryName,
    //required this.supplierName,
    required this.userRole,
  });
  Map<String, dynamic> supplierInstance;
  //String categoryName;
  //String supplierName;
  String userRole;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'viewCategoryData',
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
                                    "Supplier Details",
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
                                        supplierInstance["supplierName"],
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
                                    child: Text('Category ID',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(supplierInstance["supplierId"],
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
                                    child: Text(
                                        supplierInstance["supplierName"],
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
                                    child: Text('Supplier description',
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
                                        Text(supplierInstance["description"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Phone number',
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
                                        Text(supplierInstance["phoneNumber"]),
                                  ))
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Email',
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
                                        Text(supplierInstance["emailAddress"]),
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
                                    child: Text(supplierInstance["createdOn"]),
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
                                        supplierInstance["lastUpdatedOn"],
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

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_category_list.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/supplier_utils.dart';

class deleteSuppliers extends StatelessWidget {
  deleteSuppliers({
    super.key,
    required this.listOfSupplierIds,
    required this.userId,
  });
  String userId;
  List<String> listOfSupplierIds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'deleteSupplierData',
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
                                    "Delete Supplier(s)",
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
                                listOfSupplierIds.clear();
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return adminViewSupplierList(
                                        userId: userId,
                                        activePage: "supplierList",
                                      );
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
                            Text(
                                "Are you Sure you Want to Delete ${listOfSupplierIds.length} Supplier(s)?"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    listOfSupplierIds.clear();
                                    //Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return adminViewSupplierList(
                                            userId: userId,
                                            activePage: "supplierList",
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    onPressed: () async {
                                      List<Map<String, dynamic>>
                                          new_supplier_database =
                                          supplierDetailsPreference
                                                  .getSupplierData() ??
                                              [];
                                      listOfSupplierIds.forEach((element) {
                                        for (int i = 0;
                                            i < new_supplier_database.length;
                                            i++) {
                                          if (new_supplier_database[i]
                                                  ["supplierId"] ==
                                              element) {
                                            new_supplier_database.removeAt(i);
                                            //}
                                          }
                                        } //end for
                                      });
                                      await supplierDetailsPreference
                                          .setSupplierData(
                                              new_supplier_database);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return adminViewSupplierList(
                                              userId: userId,
                                              activePage: "supplierList",
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ],
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

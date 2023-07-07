import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/stock_inventory_utils.dart';

class deleteProducts extends StatelessWidget {
  deleteProducts({
    super.key,
    required this.listOfProductIds,
    required this.userId,
  });
  String userId;
  List<String> listOfProductIds;
  List<Map<String, dynamic>> new_stock_inventory_database =
      stockPurchaseInventoryPreference.getStockPurchaseInventory() ?? [];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'deleteProductData',
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
                                    "Delete Product(s)",
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
                                listOfProductIds.clear();
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return adminViewProductList(
                                        userId: userId,
                                        activePage: "productList",
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
                                "Are you Sure you Want to Delete ${listOfProductIds.length} Product(s)?"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    listOfProductIds.clear();
                                    //Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return adminViewProductList(
                                            userId: userId,
                                            activePage: "productList",
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
                                          new_product_database =
                                          productDetailsPreference
                                                  .getProductData() ??
                                              [];
                                      listOfProductIds.forEach((element) {
                                        for (int i = 0;
                                            i < new_product_database.length;
                                            i++) {
                                          if (new_product_database[i]
                                                  ["productId"] ==
                                              element) {
                                            new_product_database.removeAt(i);
                                            //}
                                          }
                                        } //end for
                                        for (int j = 0;
                                            j <
                                                new_stock_inventory_database
                                                    .length;
                                            j++) {
                                          if (new_stock_inventory_database[j]
                                                  ["productId"] ==
                                              element) {
                                            new_stock_inventory_database
                                                .removeAt(j);
                                            //}
                                          }
                                        }
                                      });
                                      await productDetailsPreference
                                          .setProductData(new_product_database);
                                      await stockPurchaseInventoryPreference
                                          .setStockPurchaseInventory(
                                              new_stock_inventory_database);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return adminViewProductList(
                                              userId: userId,
                                              activePage: "productList",
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

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
//import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/supplier_utils.dart';
import 'package:midusa_pos/local_database/category_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/stock_inventory_utils.dart';
import 'package:provider/provider.dart';

class addStock extends StatelessWidget {
  addStock({
    super.key,
    required this.productInstance,
    //required this.categoryInstance,
    //required this.supplierInstance,
    required this.userId,
  });
  Map<String, dynamic> productInstance;
  //Map<String, dynamic> categoryInstance;
  //Map<String, dynamic> supplierInstance;
  String userId;
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> catDropItems = createDropItems(
        "category", "not selected", "Select Category", new_category_database);
    List<Map<String, dynamic>> suppDropItems = createDropItems(
        "supplier", "not selected", "Select Supplier", new_supplier_database);
    final _formKey = GlobalKey<FormState>();
    String prodCat = productInstance["categoryId"];
    String prodSupp = productInstance["supplierId"];
    String uomController = productInstance["unitOfMeasurement"];
    if (uomController == "pc") {
      uomController = "pieces";
    }
    //String supplierPaymentStatus = productInstance["supplierPaymentStatus"];
    String productExpires = productInstance["expiryStatus"];
    String discountType = productInstance["discountType"];
    TextEditingController stockPriceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    //if (discountType == "no discount") {}
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 32.0),
        child: Hero(
            tag: 'addStock',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (BuildContext context) {
                    return updateExpiryDate();
                  }),
                ],
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
                                      "Add Stock",
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
                                          "Add stock of:",
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
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Available in stock:",
                                          style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${productInstance["quantity"]} $uomController",
                                          style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.green),
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
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: .15, color: Colors.black),
                                color: Color.fromRGBO(242, 242, 242, .5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(children: [
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Quantity ($uomController):",
                                                  style: TextStyle(
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 175,
                                                  child: TextFormField(
                                                    controller:
                                                        quantityController,
                                                    validator: (value) {
                                                      String patttern =
                                                          r'^\d*\.?\d+$';
                                                      RegExp regExp =
                                                          new RegExp(patttern);
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Product quantity required!";
                                                      } else {
                                                        if (!regExp.hasMatch(
                                                                value) ||
                                                            double.parse(
                                                                    value) <
                                                                0) {
                                                          return "Invalid product quantity!";
                                                        }
                                                      }
                                                    },
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 12,
                                                    ),
                                                    decoration: InputDecoration(
                                                      errorStyle: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                      //border: InputBorder.none,
                                                      hintText:
                                                          'Quantity e.g 100',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 11),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
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
                                                                      .circular(
                                                                          10),
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
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Stock Price (cost of stock):",
                                                  style: TextStyle(
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 175,
                                                  child: TextFormField(
                                                    controller:
                                                        stockPriceController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Stock price required!";
                                                      }
                                                    },
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 12,
                                                    ),
                                                    decoration: InputDecoration(
                                                      errorStyle: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                      //border: InputBorder.none,
                                                      hintText: 'Cost of Stock',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 11),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
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
                                                                      .circular(
                                                                          10),
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
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                          221, 255, 255, 255),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 32, 147, 42),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2))),
                                                ),
                                                onPressed: () async {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    //
                                                    DateTime currentDateTime =
                                                        DateTime.now();
                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'dd/MM/yyyy HH:mm:ss')
                                                            .format(
                                                                currentDateTime);
                                                    List<Map<String, dynamic>>
                                                        new_product_database =
                                                        productDetailsPreference
                                                                .getProductData() ??
                                                            [];
                                                    List<Map<String, dynamic>>
                                                        new_stock_inventory_database =
                                                        stockPurchaseInventoryPreference
                                                                .getStockPurchaseInventory() ??
                                                            [];
                                                    int activeIndex = 0;
                                                    for (var newProduct
                                                        in new_product_database) {
                                                      if (newProduct[
                                                              "productId"] ==
                                                          productInstance[
                                                              "productId"]) {
                                                        break;
                                                      }
                                                      activeIndex += 1;
                                                    }
                                                    String currentQuant =
                                                        new_product_database[
                                                                activeIndex]
                                                            ["quantity"];
                                                    new_product_database[
                                                            activeIndex]
                                                        ["quantity"] = (double
                                                                .parse(
                                                                    currentQuant) +
                                                            double.parse(
                                                                quantityController
                                                                    .text
                                                                    .trim()))
                                                        .toString();
                                                    new_product_database[
                                                                activeIndex]
                                                            ["stockPrice"] =
                                                        stockPriceController
                                                            .text
                                                            .trim();
                                                    await productDetailsPreference
                                                        .setProductData(
                                                            new_product_database);
                                                    activeIndex = 0;
                                                    for (var newInventory
                                                        in new_stock_inventory_database) {
                                                      if (newInventory[
                                                              "productId"] ==
                                                          productInstance[
                                                              "productId"]) {
                                                        break;
                                                      }
                                                      activeIndex += 1;
                                                    }
                                                    String purchasedQuantity =
                                                        new_stock_inventory_database[
                                                                activeIndex][
                                                            "totalPurchasedQuantity"];
                                                    new_stock_inventory_database[
                                                            activeIndex][
                                                        "totalPurchasedQuantity"] = (double
                                                                .parse(
                                                                    purchasedQuantity) +
                                                            double.parse(
                                                                quantityController
                                                                    .text
                                                                    .trim()))
                                                        .toString();
                                                    //
                                                    String purchasedAmount =
                                                        new_stock_inventory_database[
                                                                activeIndex][
                                                            "totalPurchasedAmount"];
                                                    new_stock_inventory_database[
                                                            activeIndex][
                                                        "totalPurchasedAmount"] = (double
                                                                .parse(
                                                                    purchasedAmount) +
                                                            double.parse(
                                                                stockPriceController
                                                                    .text
                                                                    .trim()))
                                                        .toString();
                                                    new_stock_inventory_database[
                                                                activeIndex]
                                                            ["lastUpdatedOn"] =
                                                        formattedDateTime;
                                                    await stockPurchaseInventoryPreference
                                                        .setStockPurchaseInventory(
                                                            new_stock_inventory_database);
                                                    //
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return adminViewProductList(
                                                            userId: userId,
                                                            activePage:
                                                                "productList",
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Submit",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Oswald',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255))),
                                                  ],
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                          221, 255, 255, 255),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 39, 41, 41),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2))),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Cancel",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Oswald',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255))),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ],
                                    ))
                              ]),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

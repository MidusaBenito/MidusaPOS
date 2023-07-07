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

class editSingleProduct extends StatelessWidget {
  editSingleProduct({
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
  List<Map<String, dynamic>> new_stock_inventory_database =
      stockPurchaseInventoryPreference.getStockPurchaseInventory() ?? [];
  double deltaQuantity = 0.00;
  double deltaStockPrice = 0.00;

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
    //String supplierPaymentStatus = productInstance["supplierPaymentStatus"];
    String productExpires = productInstance["expiryStatus"];
    String discountType = productInstance["discountType"];
    TextEditingController productNameController =
        TextEditingController(text: productInstance["productName"]);
    TextEditingController stockPriceController =
        TextEditingController(text: productInstance["stockPrice"]);
    TextEditingController quantityController =
        TextEditingController(text: productInstance["quantity"]);
    TextEditingController minimumController =
        TextEditingController(text: productInstance["minimumQuantity"]);
    TextEditingController retailPriceController =
        TextEditingController(text: productInstance["retailPrice"]);
    TextEditingController discountAmountController =
        TextEditingController(text: productInstance["recommendedDiscount"]);
    DateTime selectedDate;
    TextEditingController expiryDateController;
    if (productExpires == "yes") {
      selectedDate =
          DateFormat('dd/MM/yyyy').parse(productInstance["expiryDate"]);
      expiryDateController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(selectedDate));
    } else {
      selectedDate = DateTime.now();
      expiryDateController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(selectedDate));
    }
    if (prodCat == "_") {
      prodCat = "not selected";
    }
    if (prodSupp == "_") {
      prodSupp = "not selected";
    }
    //if (discountType == "no discount") {}
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 32.0),
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
                                      "Edit Details",
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
                                          "Change the details of:",
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Product Name:",
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
                                                        productNameController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Product name required!";
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
                                                      hintText: 'Product Name',
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Product Category:",
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
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                    ),
                                                    value: prodCat,
                                                    items:
                                                        catDropItems.map((e) {
                                                      return DropdownMenuItem(
                                                        value: e["categoryId"],
                                                        child: Text(
                                                          e["categoryName"],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      prodCat =
                                                          value!.toString();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Supplier:",
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
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                    ),
                                                    value: prodSupp,
                                                    items:
                                                        suppDropItems.map((e) {
                                                      return DropdownMenuItem(
                                                        value: e["supplierId"],
                                                        child: Text(
                                                          e["supplierName"],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      prodSupp =
                                                          value!.toString();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Current Stock Price:",
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
                                                      hintText:
                                                          'Cost of current Stock',
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Unit of Measurement:",
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
                                                  child:
                                                      DropdownButtonFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value ==
                                                              "not selected") {
                                                        return "Select U.o.M!";
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      errorStyle: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                    ),
                                                    value: uomController,
                                                    items: [
                                                      DropdownMenuItem(
                                                        value: 'not selected',
                                                        child: Text(
                                                          'Select U.O.M',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'pc',
                                                        child: Text(
                                                          'Pieces(pc)',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'kg',
                                                        child: Text(
                                                          'Kilograms(kg)',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'litres',
                                                        child: Text(
                                                          'Litres(litres)',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      uomController =
                                                          value!.toString();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Available Quantity:",
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
                                                      hintText: 'Quantity',
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Minimum Quantity:",
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
                                                        minimumController,
                                                    validator: (value) {
                                                      String patttern =
                                                          r'^\d*\.?\d+$';
                                                      RegExp regExp =
                                                          new RegExp(patttern);
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Minimum quantity required!";
                                                      } else {
                                                        if (!regExp.hasMatch(
                                                                value) ||
                                                            double.parse(
                                                                    value) <
                                                                0) {
                                                          return "Invalid quantity!";
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
                                                          'Minimum quantity',
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Recommended Retail Price:",
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
                                                        retailPriceController,
                                                    validator: (value) {
                                                      String patttern =
                                                          r'^\d*\.?\d+$';
                                                      RegExp regExp =
                                                          new RegExp(patttern);
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Retail price required!";
                                                      } else {
                                                        if (!regExp.hasMatch(
                                                                value) ||
                                                            double.parse(
                                                                    value) <
                                                                0) {
                                                          return "Invalid Retail price!";
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
                                                      hintText: 'Rrp per unit',
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
                                            )
                                            //end
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Consumer<updateExpiryDate>(
                                            builder: (myContext, value, child) {
                                          return Row(children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Product Expires?:",
                                                    style: TextStyle(
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 175,
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                      ),
                                                      value: productExpires,
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: 'no',
                                                          child: Text(
                                                            'No',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'yes',
                                                          child: Text(
                                                            'Yes',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        productExpires = value!;
                                                        //expiryController =
                                                        //value!.toString();
                                                        myContext
                                                            .read<
                                                                updateExpiryDate>()
                                                            .updateVisibility(
                                                                value,
                                                                productExpires);
                                                      },
                                                    ),
                                                  )
                                                ]),
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Expiry Date:",
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
                                                    enabled:
                                                        productExpires == "yes"
                                                            ? true
                                                            : false,
                                                    controller:
                                                        expiryDateController,
                                                    onTap: () async {
                                                      final kToday =
                                                          DateTime.now();
                                                      final DateTime? dateTime =
                                                          await showDatePicker(
                                                        context: myContext,
                                                        initialDate:
                                                            selectedDate,
                                                        firstDate: DateTime(
                                                            kToday.year,
                                                            kToday.month - 3,
                                                            kToday.day),
                                                        lastDate: DateTime(
                                                            kToday.year + 2,
                                                            kToday.month + 3,
                                                            kToday.day),
                                                      );
                                                      if (dateTime != null) {
                                                        myContext
                                                            .read<
                                                                updateExpiryDate>()
                                                            .changeDate(
                                                                dateTime,
                                                                selectedDate,
                                                                expiryDateController);
                                                      }
                                                    },
                                                    validator: (value) {},
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 12,
                                                    ),
                                                    decoration: InputDecoration(
                                                      //enabled: false,
                                                      prefixIconConstraints:
                                                          BoxConstraints(
                                                              minWidth: 30),
                                                      prefixIcon: IconButton(
                                                        color: Colors.redAccent,
                                                        icon: Icon(Icons
                                                            .calendar_today),
                                                        onPressed: () async {
                                                          final kToday =
                                                              DateTime.now();
                                                          final DateTime?
                                                              dateTime =
                                                              await showDatePicker(
                                                            context: myContext,
                                                            initialDate:
                                                                selectedDate,
                                                            firstDate: DateTime(
                                                                kToday.year,
                                                                kToday.month -
                                                                    3,
                                                                kToday.day),
                                                            lastDate: DateTime(
                                                                kToday.year + 2,
                                                                kToday.month +
                                                                    3,
                                                                kToday.day),
                                                          );
                                                          if (dateTime !=
                                                              null) {
                                                            myContext
                                                                .read<
                                                                    updateExpiryDate>()
                                                                .changeDate(
                                                                    dateTime,
                                                                    selectedDate,
                                                                    expiryDateController);
                                                          }
                                                        },
                                                      ),
                                                      errorStyle: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                      //border: InputBorder.none,

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
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Discount Type:",
                                                    style: TextStyle(
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 175,
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                      ),
                                                      value: discountType,
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: 'no discount',
                                                          child: Text(
                                                            'No Discount',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'percentage',
                                                          child: Text(
                                                            '% Percentage Discount',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'fixed',
                                                          child: Text(
                                                            'Fixed Amount Discount',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        discountType = value!;
                                                        //expiryController =
                                                        //value!.toString();
                                                        myContext
                                                            .read<
                                                                updateExpiryDate>()
                                                            .updateDiscount(
                                                                value,
                                                                discountType);
                                                      },
                                                    ),
                                                  )
                                                ]),
                                            Expanded(child: Container()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Recommended Discount:",
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
                                                        discountAmountController,
                                                    enabled: discountType !=
                                                            "no discount"
                                                        ? true
                                                        : false,
                                                    validator: (value) {
                                                      if (discountType !=
                                                              "no discount" &&
                                                          (value == null ||
                                                              value.isEmpty)) {
                                                        return "Discount value required!";
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
                                          ]);
                                        }),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        //comment from here
                                        //Row(children: [
                                        // Column(
                                        //crossAxisAlignment:
                                        //CrossAxisAlignment.start,
                                        // children: [
                                        // Text(
                                        //"Supplier Payment Status:",
                                        // style: TextStyle(
                                        //  fontFamily: 'Proxima',
                                        //  fontWeight: FontWeight.w400,
                                        //fontSize: 13,
                                        // ),
                                        //),
                                        //SizedBox(
                                        // height: 10,
                                        // ),
                                        //SizedBox(
                                        // width: 175,
                                        //child:
                                        //DropdownButtonFormField(
                                        //decoration: InputDecoration(
                                        //isDense: true,
                                        // contentPadding:
                                        //  EdgeInsets.symmetric(
                                        //    horizontal: 5,
                                        //   vertical: 10),
                                        // ),
                                        // value:
                                        //  supplierPaymentStatus,
                                        // items: [
                                        //DropdownMenuItem(
                                        // value: 'not paid',
                                        // child: Text(
                                        //  'Not Paid',
                                        //  maxLines: 1,
                                        // overflow: TextOverflow
                                        //    .ellipsis,
                                        //style: TextStyle(
                                        //  fontSize: 12),
                                        // ),
                                        //),
                                        //DropdownMenuItem(
                                        //value: 'paid',
                                        //child: Text(
                                        // 'Paid',
                                        // maxLines: 1,
                                        // overflow: TextOverflow
                                        // .ellipsis,
                                        //style: TextStyle(
                                        // fontSize: 12),
                                        //),
                                        // ),
                                        // ],
                                        // onChanged: (value) {
                                        //supplierPaymentStatus =
                                        //   value!.toString();
                                        //},
                                        //),
                                        //)
                                        //]),
                                        //Expanded(child: Container()),
                                        //]),

                                        //SizedBox(
                                        // height: 20,
                                        // ),
                                        //to here
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
                                                    //String productId =
                                                    //generateId();
                                                    DateTime currentDateTime =
                                                        DateTime.now();
                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'dd/MM/yyyy HH:mm:ss')
                                                            .format(
                                                                currentDateTime);
                                                    if (prodCat ==
                                                        "not selected") {
                                                      prodCat = "_";
                                                    }
                                                    if (prodSupp ==
                                                        "not selected") {
                                                      prodSupp = "_";
                                                    }
                                                    String dateToExpire =
                                                        productExpires == "no"
                                                            ? "_"
                                                            : expiryDateController
                                                                .text;
                                                    String discountValue =
                                                        discountType ==
                                                                "no discount"
                                                            ? "_"
                                                            : discountAmountController
                                                                .text
                                                                .trim();
                                                    //print(dateToExpire);
                                                    List<Map<String, dynamic>>
                                                        new_product_database =
                                                        productDetailsPreference
                                                                .getProductData() ??
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
                                                    new_product_database[
                                                            activeIndex] =
                                                        saveProductDetails(
                                                            productInstance[
                                                                "productId"],
                                                            productNameController
                                                                .text
                                                                .trim(),
                                                            prodCat,
                                                            prodSupp,
                                                            stockPriceController
                                                                .text
                                                                .trim(),
                                                            uomController,
                                                            quantityController.text
                                                                .trim(),
                                                            minimumController
                                                                .text
                                                                .trim(),
                                                            retailPriceController
                                                                .text
                                                                .trim(),
                                                            productExpires,
                                                            dateToExpire,
                                                            discountType,
                                                            discountValue,
                                                            //supplierPaymentStatus,
                                                            userId,
                                                            productInstance[
                                                                "createdOn"],
                                                            formattedDateTime);
                                                    await productDetailsPreference
                                                        .setProductData(
                                                            new_product_database);
                                                    bool inventoryChange =
                                                        false;
                                                    if (productInstance[
                                                            "stockPrice"] !=
                                                        stockPriceController
                                                            .text
                                                            .trim()) {
                                                      deltaStockPrice = double
                                                              .parse(
                                                                  stockPriceController
                                                                      .text
                                                                      .trim()) -
                                                          double.parse(
                                                              productInstance[
                                                                  "stockPrice"]);
                                                      inventoryChange = true;
                                                    } //
                                                    if (productInstance[
                                                            "quantity"] !=
                                                        quantityController.text
                                                            .trim()) {
                                                      deltaQuantity = double.parse(
                                                              quantityController
                                                                  .text
                                                                  .trim()) -
                                                          double.parse(
                                                              productInstance[
                                                                  "quantity"]);
                                                      inventoryChange = true;
                                                    }
                                                    if (inventoryChange ==
                                                        true) {
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
                                                      } //end for
                                                      String purchasedQuantity =
                                                          new_stock_inventory_database[
                                                                  activeIndex][
                                                              "totalPurchasedQuantity"];
                                                      new_stock_inventory_database[
                                                                  activeIndex][
                                                              "totalPurchasedQuantity"] =
                                                          (double.parse(
                                                                      purchasedQuantity) +
                                                                  deltaQuantity)
                                                              .toString();
                                                      String purchasedAmount =
                                                          new_stock_inventory_database[
                                                                  activeIndex][
                                                              "totalPurchasedAmount"];
                                                      new_stock_inventory_database[
                                                                  activeIndex][
                                                              "totalPurchasedAmount"] =
                                                          (double.parse(
                                                                      purchasedAmount) +
                                                                  deltaStockPrice)
                                                              .toString();
                                                      await stockPurchaseInventoryPreference
                                                          .setStockPurchaseInventory(
                                                              new_stock_inventory_database);
                                                    }
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return adminDashboard(
                                                          userId: userId,
                                                          activePage:
                                                              "overallDashboard",
                                                        );
                                                      },
                                                    ),
                                                  );
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

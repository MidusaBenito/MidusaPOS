import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_category_list.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
//import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/supplier_utils.dart';
import 'package:midusa_pos/local_database/category_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:provider/provider.dart';

class editSingleSupplier extends StatelessWidget {
  editSingleSupplier({
    super.key,
    required this.supplierInstance,
    //required this.categoryInstance,
    //required this.supplierInstance,
    required this.userId,
  });
  Map<String, dynamic> supplierInstance;
  //Map<String, dynamic> categoryInstance;
  //Map<String, dynamic> supplierInstance;
  String userId;
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];

  @override
  Widget build(BuildContext context) {
    final TextEditingController supplierNameController =
        TextEditingController(text: supplierInstance["supplierName"]);
    final TextEditingController phoneNumberController =
        TextEditingController(text: supplierInstance["phoneNumber"]);
    final TextEditingController emailAddressController =
        TextEditingController(text: supplierInstance["emailAddress"]);
    final TextEditingController descriptionController =
        TextEditingController(text: supplierInstance["description"]);
    final _formKey = GlobalKey<FormState>();

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
                                                  "Supplier Name:",
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
                                                        supplierNameController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Supplier name cannot be Empty!";
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
                                                      hintText: 'Supplier Name',
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
                                                  "Phone Number:",
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
                                                        phoneNumberController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Supplier contact required!";
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
                                                          'Supplier Phone Number',
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
                                                  "Email Address (Optional):",
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
                                                        emailAddressController,
                                                    validator: (value) {
                                                      String patttern =
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                                      RegExp regExp =
                                                          new RegExp(patttern);
                                                      if (value!.isNotEmpty &&
                                                          !regExp.hasMatch(
                                                              value)) {
                                                        return 'Invalid email address!';
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
                                                      hintText: 'Email address',
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
                                                  "Description (Optional):",
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
                                                        descriptionController,
                                                    validator: (value) {},
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
                                                          'Add any extra information...',
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
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    DateTime currentDateTime =
                                                        DateTime.now();
                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'dd/MM/yyyy HH:mm:ss')
                                                            .format(
                                                                currentDateTime);
                                                    //String supplierId =
                                                    //generateId();
                                                    String sEmail =
                                                        emailAddressController
                                                                .text.isEmpty
                                                            ? "_"
                                                            : emailAddressController
                                                                .text
                                                                .trim();
                                                    String sDesc =
                                                        descriptionController
                                                                .text.isEmpty
                                                            ? "_"
                                                            : descriptionController
                                                                .text
                                                                .trim();
                                                    List<Map<String, dynamic>>
                                                        new_supplier_database =
                                                        supplierDetailsPreference
                                                                .getSupplierData() ??
                                                            [];
                                                    int activeIndex = 0;
                                                    for (var newSupplier
                                                        in new_supplier_database) {
                                                      if (newSupplier[
                                                              "supplierId"] ==
                                                          supplierInstance[
                                                              "supplierId"]) {
                                                        break;
                                                      }
                                                      activeIndex += 1;
                                                    }
                                                    new_supplier_database[
                                                            activeIndex] =
                                                        saveSupplierDetails(
                                                            supplierInstance[
                                                                "supplierId"],
                                                            supplierNameController
                                                                .text
                                                                .trim(),
                                                            phoneNumberController
                                                                .text
                                                                .trim(),
                                                            sEmail,
                                                            sDesc,
                                                            userId,
                                                            supplierInstance[
                                                                "createdOn"],
                                                            formattedDateTime);
                                                    await supplierDetailsPreference
                                                        .setSupplierData(
                                                            new_supplier_database);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return adminViewSupplierList(
                                                            userId: userId,
                                                            activePage:
                                                                "supplierList",
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
                                    )),
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

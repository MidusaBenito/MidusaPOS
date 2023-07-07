import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_category_list.dart';
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
import 'package:provider/provider.dart';

class editSingleCategory extends StatelessWidget {
  editSingleCategory({
    super.key,
    required this.categoryInstance,
    //required this.categoryInstance,
    //required this.supplierInstance,
    required this.userId,
  });
  Map<String, dynamic> categoryInstance;
  //Map<String, dynamic> categoryInstance;
  //Map<String, dynamic> supplierInstance;
  String userId;
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryNameController =
        TextEditingController(text: categoryInstance["categoryName"]);
    final TextEditingController categoryDescriptionController =
        TextEditingController(text: categoryInstance["categoryDescription"]);
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
                                          categoryInstance["categoryName"],
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
                                                  "Category Name:",
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
                                                  width: 250,
                                                  child: TextFormField(
                                                    controller:
                                                        categoryNameController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Enter Category Name";
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
                                                      hintText: 'Category Name',
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
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Category Description (optional):",
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
                                                  width: 500,
                                                  //height: 250,
                                                  child: TextFormField(
                                                    controller:
                                                        categoryDescriptionController,
                                                    maxLines: 4,
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
                                                          'Describe this category in a few words',
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
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    DateTime currentDateTime =
                                                        DateTime.now();
                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'dd/MM/yyyy HH:mm:ss')
                                                            .format(
                                                                currentDateTime);
                                                    //String categoryId =
                                                    //generateId();
                                                    String catDesc =
                                                        categoryDescriptionController
                                                                .text.isEmpty
                                                            ? "_"
                                                            : categoryDescriptionController
                                                                .text
                                                                .trim();
                                                    List<Map<String, dynamic>>
                                                        new_category_database =
                                                        categoryDetailsPreference
                                                                .getCategoryData() ??
                                                            [];
                                                    //print("hello there");
                                                    //print(new_category_database);
                                                    int activeIndex = 0;
                                                    for (var newCategory
                                                        in new_category_database) {
                                                      if (newCategory[
                                                              "categoryId"] ==
                                                          categoryInstance[
                                                              "categoryId"]) {
                                                        break;
                                                      }
                                                      activeIndex += 1;
                                                    }
                                                    new_category_database[
                                                            activeIndex] =
                                                        saveCategoryDetails(
                                                            categoryInstance[
                                                                "categoryId"],
                                                            categoryNameController
                                                                .text
                                                                .trim(),
                                                            catDesc,
                                                            userId,
                                                            categoryInstance[
                                                                "createdOn"],
                                                            formattedDateTime);
                                                    await categoryDetailsPreference
                                                        .setCategoryData(
                                                            new_category_database);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return adminViewCategoryList(
                                                            userId: userId,
                                                            activePage:
                                                                "categoryList",
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

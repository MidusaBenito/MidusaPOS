import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_category_list.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/category_utils.dart';

class deleteCategories extends StatelessWidget {
  deleteCategories({
    super.key,
    required this.listOfCategoryIds,
    required this.userId,
  });
  String userId;
  List<String> listOfCategoryIds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'deleteCategoryData',
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
                                    "Delete Category(s)",
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
                                listOfCategoryIds.clear();
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return adminViewCategoryList(
                                        userId: userId,
                                        activePage: "categoryList",
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
                                "Are you Sure you Want to Delete ${listOfCategoryIds.length} Category(s)?"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    listOfCategoryIds.clear();
                                    //Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return adminViewCategoryList(
                                            userId: userId,
                                            activePage: "categoryList",
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
                                          new_category_database =
                                          categoryDetailsPreference
                                                  .getCategoryData() ??
                                              [];
                                      listOfCategoryIds.forEach((element) {
                                        for (int i = 0;
                                            i < new_category_database.length;
                                            i++) {
                                          if (new_category_database[i]
                                                  ["categoryId"] ==
                                              element) {
                                            new_category_database.removeAt(i);
                                            //}
                                          }
                                        } //end for
                                      });
                                      await categoryDetailsPreference
                                          .setCategoryData(
                                              new_category_database);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return adminViewCategoryList(
                                              userId: userId,
                                              activePage: "categoryList",
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

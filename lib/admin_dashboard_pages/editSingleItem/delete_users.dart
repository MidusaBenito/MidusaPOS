import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/user_utils.dart';

class deleteUsers extends StatelessWidget {
  deleteUsers({
    super.key,
    required this.listOfUserIds,
    required this.userId,
  });
  String userId;
  List<String> listOfUserIds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'deleteUserData',
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
                                    "Delete User(s)",
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
                                listOfUserIds.clear();
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return adminViewUsers(
                                        userId: userId,
                                        activePage: "viewUsers",
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
                                "Are you Sure you Want to Delete ${listOfUserIds.length} User(s)?"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    listOfUserIds.clear();
                                    //Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return adminViewUsers(
                                            userId: userId,
                                            activePage: "viewUsers",
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
                                          new_user_database =
                                          userDetailsPreference.getUserData() ??
                                              [];
                                      listOfUserIds.forEach((element) {
                                        for (int i = 0;
                                            i < new_user_database.length;
                                            i++) {
                                          if (new_user_database[i]["userId"] ==
                                              element) {
                                            if (new_user_database[i]
                                                    ["userDetails"]["role"] !=
                                                "administrator") {
                                              //print("hit here!");
                                              new_user_database.removeAt(i);
                                            }
                                          }
                                        } //end for
                                      });
                                      await userDetailsPreference
                                          .setUserData(new_user_database);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return adminViewUsers(
                                              userId: userId,
                                              activePage: "viewUsers",
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

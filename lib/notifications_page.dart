import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/notifications_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class readNotifications extends StatelessWidget {
  readNotifications({
    super.key,
    //required this.activeUserId,
    //required this.cartData,
  });
  //String activeUserId;
  //Map<String, dynamic> cartData;
  List<Map<String, dynamic>> new_notification_database =
      notificationDetailsPreference.getNotificationData() ?? [];

  @override
  Widget build(BuildContext context) {
    updateNotificationDetails();
    new_notification_database
        .sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 300.0, vertical: 100.0),
        child: Hero(
            tag: 'viewNotificationData',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Color.fromRGBO(255, 255, 255, 1),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Container(
                //decoration: BoxDecoration(
                //border: Border.all(width: .15, color: Colors.black),
                //color: Color.fromRGBO(242, 242, 242, .5),
                //borderRadius: BorderRadius.circular(10),
                //),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                                  "Notifications",
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
                      height: 5,
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: new_notification_database.length,
                          itemBuilder: (context, index) {
                            var notificationInstance =
                                new_notification_database[index];
                            return Card(
                              color: Colors.white,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(
                                          notificationInstance["body"],
                                          style: TextStyle(
                                              //overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: notificationInstance[
                                                          "read"] ==
                                                      "no"
                                                  ? myColor.AppColor.darkTheme
                                                  : Colors.black),
                                        )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Container()),
                                        Text(notificationInstance["createdOn"],
                                            style: TextStyle(
                                                //overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: notificationInstance[
                                                            "read"] ==
                                                        "no"
                                                    ? Colors.blueAccent
                                                    : Colors.black54)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/workers/workers.dart';

class viewSingleUser extends StatelessWidget {
  viewSingleUser(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.userId,
      required this.userRole,
      required this.phoneNumber,
      required this.dateCreated,
      required this.dateUpdated});
  String firstName,
      lastName,
      userId,
      userRole,
      phoneNumber,
      dateCreated,
      dateUpdated;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
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
                                    "User Details",
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
                                        "${firstName} (${roleFormatter(userRole)})",
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
                                    child: Text('User ID',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(userId,
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
                                    child: Text('${firstName} ${lastName}',
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
                                    child: Text('Role',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(roleFormatter(userRole),
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
                                    child: Text('Phone',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  )),
                                  TableCell(
                                      child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(phoneNumber,
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
                                    child: Text(dateCreated),
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
                                    child: Text(dateUpdated,
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

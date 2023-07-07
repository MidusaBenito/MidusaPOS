import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/user_utils.dart';

class editSingleUser extends StatelessWidget {
  editSingleUser(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.userId,
      required this.currentUserId,
      required this.userRole,
      required this.phoneNumber,
      required this.encryptedPass,
      required this.dateUpdated});
  String firstName,
      lastName,
      userId,
      currentUserId,
      userRole,
      phoneNumber,
      encryptedPass,
      dateUpdated;

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController =
        TextEditingController(text: firstName);
    final TextEditingController lastNameController =
        TextEditingController(text: lastName);
    final TextEditingController phoneController =
        TextEditingController(text: phoneNumber);
    String encryptionKey =
        generateEncryptionKey(userId, firstName, phoneNumber);
    String decryptedPass = decryptMyEncryption(encryptionKey, encryptedPass);
    final TextEditingController passwordOneController =
        TextEditingController(text: decryptedPass);
    final _formKey = GlobalKey<FormState>();
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "First Name:",
                                      style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: firstNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provide first name!';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        //border: InputBorder.none,
                                        hintText: 'User First Name',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    96, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    179, 22, 27, 137))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Last Name:",
                                      style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provide last name!';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        //border: InputBorder.none,
                                        hintText: 'User Last Name',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    96, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    179, 22, 27, 137))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Phone Number:",
                                      style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: phoneController,
                                      validator: (value) {
                                        String patttern =
                                            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                                        RegExp regExp = new RegExp(patttern);
                                        if (value == null || value.isEmpty) {
                                          return 'Provide phone number!';
                                        } else {
                                          if (value.length < 10) {
                                            return 'Provide a valid phone number!';
                                          }
                                          if (value.length > 10 &&
                                              !regExp.hasMatch(value)) {
                                            return 'Provide a valid phone number!';
                                          }
                                        }
                                      },
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        //border: InputBorder.none,
                                        hintText: 'User Phone Number',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    96, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    179, 22, 27, 137))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "User Password:",
                                      style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: passwordOneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provide a password!';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        //border: InputBorder.none,
                                        hintText: 'User Password',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    96, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    179, 22, 27, 137))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "User Role:",
                                      style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == "not selected") {
                                          return "User role required!";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                      ),
                                      value: userRole,
                                      items: [
                                        DropdownMenuItem(
                                          enabled: userRole == 'administrator'
                                              ? false
                                              : true,
                                          value: 'pseudo-administrator',
                                          child: Text(
                                            'Admin',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          enabled: userRole == 'administrator'
                                              ? false
                                              : true,
                                          value: 'cashier',
                                          child: Text(
                                            'Cashier',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          enabled: userRole == 'administrator'
                                              ? true
                                              : false,
                                          value: 'administrator',
                                          child: Text(
                                            'Super Admin',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        userRole = value!;
                                      },
                                    ),
                                  ),
                                  //end
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            Color.fromARGB(221, 255, 255, 255),
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2))),
                                      ),
                                      onPressed: () async {
                                        List<Map<String, dynamic>>
                                            new_user_database =
                                            userDetailsPreference
                                                    .getUserData() ??
                                                [];
                                        for (int i = 0;
                                            i < new_user_database.length;
                                            i++) {
                                          if (new_user_database[i]["userId"] ==
                                              userId) {
                                            //print(userId);
                                            if (_formKey.currentState!
                                                .validate()) {
                                              encryptionKey =
                                                  generateEncryptionKey(
                                                      userId,
                                                      firstNameController.text
                                                          .trim(),
                                                      phoneController.text
                                                          .trim());
                                              Encrypted myPassBase64 =
                                                  createMyEncryption(
                                                      encryptionKey,
                                                      passwordOneController
                                                          .text);

                                              //dates
                                              DateTime currentDateTime =
                                                  DateTime.now();
                                              String formattedDateTime =
                                                  DateFormat(
                                                          'dd/MM/yyyy HH:mm:ss')
                                                      .format(currentDateTime);
                                              new_user_database[i]
                                                          ["userDetails"]
                                                      ["firstName"] =
                                                  firstNameController.text
                                                      .trim();
                                              new_user_database[i]
                                                          ["userDetails"]
                                                      ["lastName"] =
                                                  lastNameController.text
                                                      .trim();
                                              new_user_database[i]
                                                          ["userDetails"]
                                                      ["phoneNumber"] =
                                                  phoneController.text.trim();
                                              new_user_database[i]
                                                      ["userDetails"]["role"] =
                                                  userRole;
                                              new_user_database[i]
                                                          ["userDetails"]
                                                      ["password"] =
                                                  myPassBase64.base64;
                                              new_user_database[i]
                                                          ["userDetails"]
                                                      ["last_updated_on"] =
                                                  formattedDateTime;
                                              await userDetailsPreference
                                                  .setUserData(
                                                      new_user_database);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return adminViewUsers(
                                                      userId: currentUserId,
                                                      activePage: "viewUsers",
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                            //break;
                                          }
                                        }
                                      },
                                      child: Text("Update")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            Color.fromARGB(221, 255, 255, 255),
                                        backgroundColor:
                                            Color.fromARGB(255, 39, 41, 41),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                ],
                              )
                            ],
                          ),
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

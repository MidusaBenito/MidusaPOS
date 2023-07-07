import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/hero_dialog_route.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/keyboard_popup.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/models/users.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  //bool light = false;
  final TextEditingController passwordOneController = TextEditingController();
  String activation_error = "";
  //List<Map<String, dynamic>> user_data_base =
  //userDetailsPreference.getUserData() ?? [];
  //String activeValue = "";
  List<Map<String, dynamic>> user_data_base = [];
  String activeUserId = "not selected";
  String hashedPass = "";
  String encryptionKey = "";
  String userRole = "";

  @override
  Widget build(BuildContext context) {
    user_data_base = userDetailsPreference.getUserData() ?? [];
    return Scaffold(
      body: Container(
        color: myColor.AppColor.serialActivationPageBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                              ),
                              value: activeUserId,
                              items:
                                  createUserLoginDrop(user_data_base).map((e) {
                                //print(' here: ${e["userId"].runtimeType}');
                                return DropdownMenuItem(
                                  value: e["userId"],
                                  child: Text(
                                    e["userName"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Proxima',
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                activeUserId = val.toString();
                                //print(val);
                                //activeUserId = ;
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Color.fromRGBO(94, 167, 203, 1),
                              ),
                            ),
                          ),
                          //password
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password!';
                                  }
                                },
                                controller: passwordOneController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                ),
                                obscureText: isPasswordVisible ? false : true,
                                decoration: InputDecoration(
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    //border: InputBorder.none,
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(96, 0, 0, 0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                179, 22, 27, 137))),
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: 45, maxWidth: 46),
                                    suffixIcon: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color.fromARGB(179, 0, 0, 0),
                                        size: 22,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          incorrectPass(),
                          SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate() &&
                                    activeUserId != "not selected") {
                                  for (int i = 0;
                                      i < user_data_base.length;
                                      i++) {
                                    if (user_data_base[i]["userId"] ==
                                        activeUserId) {
                                      userRole = user_data_base[i]
                                          ["userDetails"]["role"];
                                      hashedPass = user_data_base[i]
                                          ["userDetails"]["password"];
                                      encryptionKey = generateEncryptionKey(
                                          activeUserId,
                                          user_data_base[i]["userDetails"]
                                              ["firstName"],
                                          user_data_base[i]["userDetails"]
                                              ["phoneNumber"]);
                                      break;
                                    }
                                  }
                                  String decryptedPass = decryptMyEncryption(
                                      encryptionKey, hashedPass);
                                  //print(decryptedPass);
                                  //print(activeUserId);
                                  //print(userRole);
                                  if (passwordOneController.text ==
                                      decryptedPass) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return userRole == "administrator"
                                              ? adminDashboard(
                                                  userId: activeUserId,
                                                  activePage:
                                                      "overallDashboard",
                                                )
                                              : homeSalesPage(
                                                  userId: activeUserId,
                                                  myCart: {},
                                                );
                                        },
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      activation_error = "Incorrect password!";
                                    });
                                  }
                                }
                              },
                              child: Text("Login"))
                        ],
                      )),
                ],
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget incorrectPass() {
    if (activation_error != "") {
      return Text(
        activation_error,
        style: TextStyle(fontSize: 13, color: Colors.red),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/hero_dialog_route.dart';
import 'package:midusa_pos/keyboard_popup.dart';
import 'package:midusa_pos/login_page.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/overal_utils.dart';
import 'package:encrypt/encrypt.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:intl/intl.dart';

class adminCreationPage extends StatefulWidget {
  const adminCreationPage({super.key});

  @override
  State<adminCreationPage> createState() => _adminCreationPageState();
}

class _adminCreationPageState extends State<adminCreationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool light = false;
  String activation_error = "";
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColor.AppColor.serialActivationPageBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Center(
                        child: Opacity(
                          opacity: .8,
                          child: Image.asset(
                            "assets/images/admin.png",
                            height: 400,
                            width: 400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: myColor.AppColor.darkTheme,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            light
                                ? "virtual keyboard on"
                                : "virtual keyboard off",
                            style: TextStyle(
                                color: light ? Colors.amber : Colors.white,
                                fontSize: 11),
                          ),
                          Switch(
                            // This bool value toggles the switch.
                            value: light,
                            activeColor: light ? Colors.amber : Colors.white,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 110,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          Text(
                            "Set Administrator Account",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 300,
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (value) {
                                        //print("first name focused");
                                        if (light) {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                                    return keyBoardPopUp(
                                                      textName: "First Name",
                                                      myInputController:
                                                          firstNameController,
                                                      isItPassword: false,
                                                    );
                                                  },
                                                  settings: RouteSettings(
                                                      arguments:
                                                          "aria-wallet")));
                                        } //end if
                                      } else {
                                        //print("first name unfocused");
                                      }
                                    },
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provide your first name!';
                                        }
                                      },
                                      controller: firstNameController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            color: Colors.amberAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        border: InputBorder.none,
                                        hintText: 'Enter First Name',
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white38)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 300,
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (value) {
                                        //print("last name focused");
                                        if (light) {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                                    return keyBoardPopUp(
                                                      textName: "Last Name",
                                                      myInputController:
                                                          lastNameController,
                                                      isItPassword: false,
                                                    );
                                                  },
                                                  settings: RouteSettings(
                                                      arguments:
                                                          "aria-wallet")));
                                        } //end if
                                      } else {
                                        //print("last name unfocused");
                                      }
                                    },
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provide your last name!';
                                        }
                                      },
                                      controller: lastNameController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            color: Colors.amberAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        border: InputBorder.none,
                                        hintText: 'Enter Last Name',
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white38)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 300,
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (value) {
                                        //print("phone number focused");
                                        if (light) {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                                    return keyBoardPopUp(
                                                      textName: "Phone Number",
                                                      myInputController:
                                                          phoneController,
                                                      isItPassword: false,
                                                    );
                                                  },
                                                  settings: RouteSettings(
                                                      arguments:
                                                          "aria-wallet")));
                                        }
                                      } else {
                                        //print("phone number unfocused");
                                      }
                                    },
                                    child: TextFormField(
                                      validator: (value) {
                                        String patttern =
                                            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                                        RegExp regExp = new RegExp(patttern);
                                        if (value == null || value.isEmpty) {
                                          return 'Provide your phone number!';
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
                                      controller: phoneController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            color: Colors.amberAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        border: InputBorder.none,
                                        hintText: 'Enter Phone Number',
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white38)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 300,
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (value) {
                                        //print("password 1 focused");
                                        if (light) {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                                    return keyBoardPopUp(
                                                      textName:
                                                          "your Preferred Password",
                                                      myInputController:
                                                          passwordOneController,
                                                      isItPassword: true,
                                                    );
                                                  },
                                                  settings: RouteSettings(
                                                      arguments:
                                                          "aria-wallet")));
                                        }
                                      } else {}
                                    },
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'You have not entered a password!';
                                        }
                                      },
                                      controller: passwordOneController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      obscureText:
                                          isPasswordVisible ? false : true,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.amberAccent),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          border: InputBorder.none,
                                          hintText:
                                              'Enter your Preferred Password',
                                          hintStyle: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 12),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white38)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white70)),
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
                                              color: Colors.white70,
                                              size: 22,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 300,
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (value) {
                                        //print("password 2 focused");
                                        if (light) {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                                    return keyBoardPopUp(
                                                      textName:
                                                          "to Confirm Password",
                                                      myInputController:
                                                          passwordTwoController,
                                                      isItPassword: true,
                                                    );
                                                  },
                                                  settings: RouteSettings(
                                                      arguments:
                                                          "aria-wallet")));
                                        }
                                      } else {}
                                    },
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'You have not confirmed your password!';
                                        }
                                      },
                                      controller: passwordTwoController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      obscureText: isConfirmPasswordVisible
                                          ? false
                                          : true,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.amberAccent),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password',
                                          hintStyle: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 12),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white38)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.white70)),
                                          suffixIconConstraints: BoxConstraints(
                                              minWidth: 45, maxWidth: 46),
                                          suffixIcon: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isConfirmPasswordVisible =
                                                    !isConfirmPasswordVisible;
                                              });
                                            },
                                            child: Icon(
                                              isConfirmPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white70,
                                              size: 22,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              incorrectPass(),
                              SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      if (passwordOneController.text ==
                                          passwordTwoController.text) {
                                        //save details to database

                                        //set userId
                                        String userId = generateId();

                                        //encrypting password
                                        final myEncryptionKey =
                                            generateEncryptionKey(
                                                userId,
                                                firstNameController.text,
                                                phoneController.text);

                                        Encrypted myPassBase64 =
                                            createMyEncryption(myEncryptionKey,
                                                passwordTwoController.text);

                                        //dates
                                        DateTime currentDateTime =
                                            DateTime.now();
                                        String formattedDateTime =
                                            DateFormat('dd/MM/yyyy HH:mm:ss')
                                                .format(currentDateTime);
                                        //print(formattedDateTime);
                                        List<Map<String, dynamic>>
                                            user_database =
                                            userDetailsPreference
                                                    .getUserData() ??
                                                [];
                                        if (user_database.isEmpty) {
                                          user_database.add(saveUserDetails(
                                              userId,
                                              firstNameController.text.trim(),
                                              lastNameController.text.trim(),
                                              phoneController.text.trim(),
                                              "administrator",
                                              myPassBase64.base64,
                                              formattedDateTime,
                                              formattedDateTime));
                                          await userDetailsPreference
                                              .setUserData(user_database);
                                          //print("is it?");
                                          await overalDataPreference
                                              .setAdminCreatedStatus(true);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return loginPage();
                                              },
                                            ),
                                          );
                                        } else {
                                          //user_database.clear();
                                          user_database.add(saveUserDetails(
                                              userId,
                                              firstNameController.text.trim(),
                                              lastNameController.text.trim(),
                                              phoneController.text.trim(),
                                              "administrator",
                                              myPassBase64.base64,
                                              formattedDateTime,
                                              formattedDateTime));
                                          await userDetailsPreference
                                              .setUserData(user_database);
                                          await overalDataPreference
                                              .setAdminCreatedStatus(true);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return loginPage();
                                              },
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          activation_error =
                                              "Passwords do not match!";
                                        });
                                      }
                                    }
                                  },
                                  child: Text("Create")),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
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
        style: TextStyle(fontSize: 13, color: Colors.amberAccent),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

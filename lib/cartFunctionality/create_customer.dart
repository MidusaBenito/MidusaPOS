import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:midusa_pos/local_database/customer_utils.dart';

class createCustomer extends StatelessWidget {
  createCustomer({
    super.key,
    required this.activeUserId,
    required this.cartData,
  });
  String activeUserId;
  Map<String, dynamic> cartData;
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 32.0),
        child: Hero(
            tag: 'createCustomerData',
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
                                    "Create Customer",
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
                                        hintText: 'Customer First Name',
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
                                        hintText: 'Customer Last Name',
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
                                        hintText: 'Customer Phone Number',
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
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          List<Map<String, dynamic>>
                                              new_customer_database =
                                              customerDetailsPreference
                                                      .getCustomerData() ??
                                                  [];
                                          String customerId = generateId();
                                          DateTime currentDateTime =
                                              DateTime.now();
                                          String formattedDateTime =
                                              DateFormat('dd/MM/yyyy HH:mm:ss')
                                                  .format(currentDateTime);
                                          new_customer_database.add(
                                              createNewCustomer(
                                                  customerId,
                                                  firstNameController.text
                                                      .trim(),
                                                  lastNameController.text
                                                      .trim(),
                                                  phoneController.text.trim(),
                                                  activeUserId,
                                                  formattedDateTime,
                                                  formattedDateTime));
                                          await customerDetailsPreference
                                              .setCustomerData(
                                                  new_customer_database);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return homeSalesPage(
                                                    userId: activeUserId,
                                                    myCart: cartData);
                                              },
                                            ),
                                          );
                                        }
                                      },
                                      child: Text("Create")),
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

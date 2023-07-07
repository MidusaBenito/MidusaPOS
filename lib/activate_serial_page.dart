import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/local_database/overal_utils.dart';
import 'package:midusa_pos/login_page.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midusa_pos/set_admin_account.dart';

class activateSerialPage extends StatefulWidget {
  const activateSerialPage({super.key});

  @override
  State<activateSerialPage> createState() => _activateSerialPageState();
}

class _activateSerialPageState extends State<activateSerialPage> {
  final TextEditingController serialController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  //bool _focused = false;
  String activation_error = "";

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColor.AppColor.serialActivationPageBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/images/Midusa_sub.png",
                      height: 70,
                      width: 70,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activation",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text("Activate the product.",
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        child: Image.asset(
                          "assets/images/keys.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Product Activation Key:",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                focusNode: myFocusNode,
                                controller: serialController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: myColor
                                              .AppColor.activeTextFormColor)),
                                ),
                                maxLength: 20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty product key!';
                                  }
                                  if (value.isNotEmpty && value.length < 20) {
                                    return 'Incomplete product key!';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      incorrectKey(),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  //add virtual keyboard here
                  myQwertyKeyboard(
                    myfocus: myFocusNode,
                    myInputController: serialController,
                    allKeysActive: false,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("< Back"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await dotenv.load();
                      var product_serial_no =
                          dotenv.env['PRODUCT_SERIAL_NUMBER'] ??
                              'SERIAL NUMBER UNAVAILABLE';

                      if (_formKey.currentState!.validate()) {
                        //print(product_serial_no);
                        if (serialController.text == product_serial_no) {
                          //print("matched!!");
                          if (activation_error.isNotEmpty) {
                            setState(() {
                              activation_error = "";
                            });
                          }
                          await overalDataPreference
                              .setSerialNumber(serialController.text);
                          await overalDataPreference.setSerialNumberSet(true);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return adminCreationPage();
                              },
                            ),
                          );
                        } else {
                          setState(() {
                            activation_error =
                                "Invalid product activation key!";
                          });
                        }
                      }
                    },
                    child: Text("Activate"),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    "Need help with your product key? Please file a support request at +254791440121",
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget incorrectKey() {
    if (activation_error != "") {
      return Text(
        activation_error,
        style: TextStyle(fontSize: 13, color: Colors.redAccent),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

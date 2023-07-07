import 'package:flutter/material.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';

class keyBoardPopUp extends StatefulWidget {
  keyBoardPopUp(
      {super.key,
      required this.myInputController,
      required this.textName,
      required this.isItPassword});
  TextEditingController myInputController;
  String textName;
  bool isItPassword;

  @override
  State<keyBoardPopUp> createState() => _keyBoardPopUpState();
}

class _keyBoardPopUpState extends State<keyBoardPopUp> {
  late FocusNode myFocusNode;
  bool isConfirmPasswordVisible = false;

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 70),
        child: Hero(
          tag: "Pop up Keyboard",
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Color.fromRGBO(255, 255, 255, .2),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    SizedBox(
                        width: 300,
                        child: widget.isItPassword
                            ? TextFormField(
                                controller: widget.myInputController,
                                focusNode: myFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                obscureText:
                                    isConfirmPasswordVisible ? false : true,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Enter ${widget.textName}',
                                    hintStyle: TextStyle(
                                        color: Colors.white60, fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white38)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
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
                              )
                            : TextFormField(
                                controller: widget.myInputController,
                                focusNode: myFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  border: InputBorder.none,
                                  hintText: 'Enter ${widget.textName}',
                                  hintStyle: TextStyle(
                                      color: Colors.white60, fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white38)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                ),
                              )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myQwertyKeyboard(
                          myfocus: myFocusNode,
                          myInputController: widget.myInputController,
                          allKeysActive: true,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Dismiss Keyboard",
                            style: TextStyle(
                                fontFamily: 'Proxima', color: Colors.redAccent),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

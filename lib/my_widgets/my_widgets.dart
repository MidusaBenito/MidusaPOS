import 'dart:math';

import 'package:basic_utils/basic_utils.dart' hide Consumer;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_category.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_hero_routes.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_product.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_transaction.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_user.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_create_new_category.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_create_new_product.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_create_new_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_create_new_user.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_category_list.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_sales.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_supplier_report.dart';
import 'package:midusa_pos/admin_dashboard_pages/admin_view_users.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/add_stock.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/delete_category.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/delete_products.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/delete_supplier.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/delete_transactions.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/delete_users.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_my_profile.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_product.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_user.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_category.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_supplier.dart';
import 'package:midusa_pos/cartFunctionality/checkout_hero_routes.dart';
import 'package:midusa_pos/hero_dialog_route.dart';
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/keyboard_popup.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/category_utils.dart';
import 'package:midusa_pos/local_database/supplier_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/sale_utils.dart';
import 'package:midusa_pos/local_database/stock_inventory_utils.dart';
import 'package:midusa_pos/local_database/customer_utils.dart';
import 'package:midusa_pos/logout.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/notifications_page.dart';
import 'package:midusa_pos/password_encryptors.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:provider/provider.dart';
import 'package:midusa_pos/pdf_api/pdf_api.dart';
import 'package:midusa_pos/pdf_api/product_list_pdf_api.dart';
import 'package:midusa_pos/pdf_api/transaction_pdf_api.dart';

class myQwertyKeyboard extends StatefulWidget {
  myQwertyKeyboard(
      {super.key,
      required this.myfocus,
      required this.myInputController,
      required this.allKeysActive});
  FocusNode myfocus;
  TextEditingController myInputController;
  bool allKeysActive;
  @override
  State<myQwertyKeyboard> createState() => _myQwertyKeyboardState();
}

class _myQwertyKeyboardState extends State<myQwertyKeyboard> {
  String textBeforeCursor = "";
  String textAfterCursor = "";
  bool capsLock = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor.AppColor.splashPageBackground2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            "$textBeforeCursor@$textAfterCursor";
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "@";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("@"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "1" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "1";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("1"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "2" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "2";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("2"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "3" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "3";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("3"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "4" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "4";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("4"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "5" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "5";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("5"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "6" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "6";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("6"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "7" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "7";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("7"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "8" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "8";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("8"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "9" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "9";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("9"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "0" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "0";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("0"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "-" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "-";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("-"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "+" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "+";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("+"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    textBeforeCursor = widget.myInputController.text.substring(
                        0, widget.myInputController.selection.baseOffset);
                    if (widget.myInputController.text.length > 0 &&
                        textBeforeCursor.length > 0) {
                      int indexToRemove = textBeforeCursor.length - 1;
                      List<String> textSer =
                          widget.myInputController.text.split('');
                      textSer.removeAt(indexToRemove);
                      widget.myInputController.text = textSer.join('');
                      widget.myInputController.selection =
                          TextSelection.collapsed(offset: indexToRemove);
                      //setState(() {});
                    }
                    //add backspace
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Icon(
                    IconData(0xe0c5,
                        fontFamily: 'MaterialIcons', matchTextDirection: true),
                    size: 18.5,
                  ),
                ),
              ],
            ),
            //second keyboard row
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 19) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "  " + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "  ";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("Tab"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "q" + textAfterCursor
                            : textBeforeCursor + "Q" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "q"
                          : widget.myInputController.text += "Q";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "q" : "Q"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "w" + textAfterCursor
                            : textBeforeCursor + "W" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "w"
                          : widget.myInputController.text += "W";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "w" : "W"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "e" + textAfterCursor
                            : textBeforeCursor + "E" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "e"
                          : widget.myInputController.text += "E";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "e" : "E"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "r" + textAfterCursor
                            : textBeforeCursor + "R" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "r"
                          : widget.myInputController.text += "R";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "r" : "R"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "t" + textAfterCursor
                            : textBeforeCursor + "T" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "t"
                          : widget.myInputController.text += "T";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "t" : "T"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "y" + textAfterCursor
                            : textBeforeCursor + "Y" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "y"
                          : widget.myInputController.text += "Y";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "y" : "Y"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "u" + textAfterCursor
                            : textBeforeCursor + "U" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "u"
                          : widget.myInputController.text += "U";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "u" : "U"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "i" + textAfterCursor
                            : textBeforeCursor + "I" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "i"
                          : widget.myInputController.text += "I";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "i" : "I"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "o" + textAfterCursor
                            : textBeforeCursor + "O" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "o"
                          : widget.myInputController.text += "O";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "o" : "O"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "p" + textAfterCursor
                            : textBeforeCursor + "P" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "p"
                          : widget.myInputController.text += "P";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "p" : "P"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "[" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "[";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("["),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "]" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "]";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("]"),
                ),
              ],
            ),
            //third row
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    setState(() {
                      capsLock == false ? capsLock = true : capsLock = false;
                    });
                    //add caps lock
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(
                    "Caps",
                    style: capsLock == false
                        ? TextStyle(
                            color: Colors.black,
                          )
                        : TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "a" + textAfterCursor
                            : textBeforeCursor + "A" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "a"
                          : widget.myInputController.text += "A";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "a" : "A"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "s" + textAfterCursor
                            : textBeforeCursor + "S" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "s"
                          : widget.myInputController.text += "S";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "s" : "S"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "d" + textAfterCursor
                            : textBeforeCursor + "D" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "d"
                          : widget.myInputController.text += "D";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "d" : "D"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "f" + textAfterCursor
                            : textBeforeCursor + "F" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "f"
                          : widget.myInputController.text += "F";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "f" : "F"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "g" + textAfterCursor
                            : textBeforeCursor + "G" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "g"
                          : widget.myInputController.text += "G";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "g" : "G"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "h" + textAfterCursor
                            : textBeforeCursor + "H" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "h"
                          : widget.myInputController.text += "H";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "h" : "H"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "j" + textAfterCursor
                            : textBeforeCursor + "J" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "j"
                          : widget.myInputController.text += "J";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "j" : "J"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "k" + textAfterCursor
                            : textBeforeCursor + "K" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "k"
                          : widget.myInputController.text += "K";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "k" : "K"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "l" + textAfterCursor
                            : textBeforeCursor + "L" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "l"
                          : widget.myInputController.text += "L";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "l" : "L"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "'" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "'";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("'"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    //widget.myfocus.requestFocus();
                    //print(widget.myfocus.hasFocus);

                    //add enter functionality
                    if (widget.allKeysActive) {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("Enter"),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "z" + textAfterCursor
                            : textBeforeCursor + "Z" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "z"
                          : widget.myInputController.text += "Z";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "z" : "Z"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "x" + textAfterCursor
                            : textBeforeCursor + "X" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "x"
                          : widget.myInputController.text += "X";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "x" : "X"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "c" + textAfterCursor
                            : textBeforeCursor + "C" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "c"
                          : widget.myInputController.text += "C";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "c" : "C"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "v" + textAfterCursor
                            : textBeforeCursor + "V" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "v"
                          : widget.myInputController.text += "V";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "v" : "V"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "b" + textAfterCursor
                            : textBeforeCursor + "B" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "b"
                          : widget.myInputController.text += "B";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "b" : "B"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "n" + textAfterCursor
                            : textBeforeCursor + "N" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "n"
                          : widget.myInputController.text += "N";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "n" : "N"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text = capsLock == false
                            ? textBeforeCursor + "m" + textAfterCursor
                            : textBeforeCursor + "M" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      capsLock == false
                          ? widget.myInputController.text += "m"
                          : widget.myInputController.text += "M";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(capsLock == false ? "m" : "M"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "," + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += ",";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text(","),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "." + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += ".";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("."),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + "?" + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += "?";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("?"),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    //widget.myfocus.requestFocus();
                    //add accept functionality
                    if (widget.allKeysActive) {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("Accept"),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    //widget.myfocus.requestFocus();
                    //widget.myInputController.text += " ";
                    widget.myfocus.requestFocus();
                    if (widget.myInputController.text.length > 0) {
                      if (widget.myInputController.text.length < 20) {
                        textBeforeCursor = widget.myInputController.text
                            .substring(0,
                                widget.myInputController.selection.baseOffset);
                        textAfterCursor = widget.myInputController.text
                            .substring(widget
                                .myInputController.selection.extentOffset);

                        widget.myInputController.text =
                            textBeforeCursor + " " + textAfterCursor;
                        int cursorPosition = textBeforeCursor.length + 1;
                        widget.myInputController.selection =
                            TextSelection.collapsed(offset: cursorPosition);
                      }
                    } else {
                      widget.myInputController.text += " ";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 15)),
                  child: Text(""),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    //widget.myfocus.requestFocus();
                    //add cancel functionality
                    if (widget.allKeysActive) {
                      widget.myInputController.clear();
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, padding: EdgeInsets.all(15)),
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget createNewUser(myContext, String userId) {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  String userRoleValue = "not selected";
  final _formKey = GlobalKey<FormState>();
  //final TextEditingController userRoleController = TextEditingController();
  return Expanded(
      child: Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Management",
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Add or Update User",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black),
                  )
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: .15, color: Colors.black),
                      color: Color.fromRGBO(242, 242, 242, .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "First Name:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: firstNameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Provide first name!';
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
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
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Last Name:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: lastNameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Provide last name!';
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
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
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone Number:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: phoneController,
                                            validator: (value) {
                                              String patttern =
                                                  r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                                              RegExp regExp =
                                                  new RegExp(patttern);
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
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
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Password:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: passwordOneController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Provide a password!';
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
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
                                  ],
                                ),
                                //second
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Role:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: DropdownButtonFormField(
                                            validator: (value) {
                                              if (value == "not selected") {
                                                return "User role required!";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                            ),
                                            value: userRoleValue,
                                            items: [
                                              DropdownMenuItem(
                                                value: 'not selected',
                                                child: Text(
                                                  'Select User Role',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'pseudo-administrator',
                                                child: Text(
                                                  'Admin',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'cashier',
                                                child: Text(
                                                  'Cashier',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              userRoleValue = value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    //end
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 32, 147, 42),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            //print("okay");
                                            String new_userId = generateId();

                                            //encrypting password
                                            final myEncryptionKey =
                                                generateEncryptionKey(
                                                    new_userId,
                                                    firstNameController.text,
                                                    phoneController.text);

                                            Encrypted myPassBase64 =
                                                createMyEncryption(
                                                    myEncryptionKey,
                                                    passwordOneController.text);

                                            //dates
                                            DateTime currentDateTime =
                                                DateTime.now();
                                            String formattedDateTime =
                                                DateFormat(
                                                        'dd/MM/yyyy HH:mm:ss')
                                                    .format(currentDateTime);
                                            List<Map<String, dynamic>>
                                                new_user_database =
                                                userDetailsPreference
                                                        .getUserData() ??
                                                    [];
                                            new_user_database.add(
                                                saveUserDetails(
                                                    new_userId,
                                                    firstNameController.text
                                                        .trim(),
                                                    lastNameController.text
                                                        .trim(),
                                                    phoneController.text.trim(),
                                                    userRoleValue,
                                                    myPassBase64.base64,
                                                    formattedDateTime,
                                                    formattedDateTime));
                                            await userDetailsPreference
                                                .setUserData(new_user_database);
                                            Navigator.push(
                                              myContext,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return adminViewUsers(
                                                    userId: userId,
                                                    activePage: "viewUsers",
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Submit",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 39, 41, 41),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            myContext,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return adminDashboard(
                                                  userId: userId,
                                                  activePage:
                                                      "overallDashboard",
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Cancel",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    ),
  ));
}

Widget categoryList(myContext, String userId) {
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<String> deletedElements = [];
  List<Map<String, dynamic>> searched_category_response = [];
  String itemsToShow = "all";
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return cat_updateCheckBox();
      }),
      ChangeNotifierProvider(create: (BuildContext context) {
        return displayCustomers();
      }),
    ],
    child: Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Category List",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "View/Search Product Category",
                        style: TextStyle(
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(221, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 32, 147, 42),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          myContext,
                          MaterialPageRoute(
                            builder: (context) {
                              return adminCreateNewCategory(
                                userId: userId,
                                activePage: "categoryList",
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text("Add Category",
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 20),
              //next
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .15, color: Colors.black),
                          color: Color.fromRGBO(242, 242, 242, .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Consumer<displayCustomers>(
                            builder: (myContext, value, child) {
                          itemsToShow = value.typeOfDisplay;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Form(
                                      child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (value) {},
                                      onChanged: (value) {
                                        searched_category_response =
                                            searchedCategory(
                                                new_category_database, value);
                                        myContext
                                            .read<displayCustomers>()
                                            .changeTypeOfDisplay("search");
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
                                        hintText: 'Search by name...',
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
                                  )),
                                  SizedBox(width: 10),
                                  Consumer<cat_updateCheckBox>(
                                      builder: (myContext, value, child) {
                                    if (deletedElements.isNotEmpty) {
                                      return TextButton(
                                          onPressed: () {
                                            Navigator.of(myContext).push(
                                                ViewHeroDialogRoute(
                                                    builder: (context) {
                                                      return deleteCategories(
                                                          listOfCategoryIds:
                                                              deletedElements,
                                                          userId: userId);
                                                    },
                                                    settings: RouteSettings(
                                                        arguments:
                                                            "deleteProductData")));
                                          },
                                          child: Text("Delete Selected Items",
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.red)));
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  IconButton(
                                    tooltip: "pdf",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.picture_as_pdf,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "excel",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.insert_drive_file,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "print",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.print,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //table
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Consumer<cat_updateCheckBox>(
                                                builder:
                                                    (myContext, value, child) {
                                              return Checkbox(
                                                  value: myContext
                                                      .watch<
                                                          cat_updateCheckBox>()
                                                      .checkBoxVal,
                                                  onChanged: (value) {
                                                    var containerForElements =
                                                        itemsToShow == "all"
                                                            ? new_category_database
                                                            : searched_category_response;
                                                    myContext
                                                        .read<
                                                            cat_updateCheckBox>()
                                                        .changeVal(
                                                            value!,
                                                            "all",
                                                            "",
                                                            deletedElements,
                                                            containerForElements);
                                                  });
                                            }),
                                            //Expanded(child: Container())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Category name",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              //Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Category description",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              //Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Products",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              //Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Created by",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              //Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //values to populate the table
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  height: 310,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: itemsToShow == "all"
                                          ? new_category_database.length
                                          : searched_category_response.length,
                                      itemBuilder: (context, index) {
                                        var categoryInfo = itemsToShow == "all"
                                            ? new_category_database[index]
                                            : searched_category_response[index];
                                        String createdById =
                                            categoryInfo["createdBy"];
                                        String createdByRole = "_";
                                        new_user_database.forEach((element) {
                                          if (createdById ==
                                              element["userId"]) {
                                            createdByRole =
                                                element["userDetails"]["role"];
                                            if (createdByRole ==
                                                "administrator") {
                                              createdByRole =
                                                  "Super Administrator";
                                            }
                                            if (createdByRole ==
                                                "pseudo-administrator") {
                                              createdByRole = "Administrator";
                                            }
                                            if (createdByRole == "cashier") {
                                              createdByRole =
                                                  StringUtils.capitalize(
                                                      createdByRole);
                                            }
                                          }
                                        });
                                        return Row(
                                          // mainAxisAlignment:
                                          // MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Consumer<
                                                              cat_updateCheckBox>(
                                                          builder: (myContext,
                                                              value, child) {
                                                        return Checkbox(
                                                            value: deletedElements
                                                                .contains(
                                                                    categoryInfo[
                                                                        "categoryId"]),
                                                            onChanged: (value) {
                                                              myContext
                                                                  .read<
                                                                      cat_updateCheckBox>()
                                                                  .changeVal(
                                                                      value!,
                                                                      "one",
                                                                      categoryInfo[
                                                                          "categoryId"],
                                                                      deletedElements,
                                                                      new_category_database);
                                                            });
                                                      }),
                                                      //Expanded(child: Container())
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0.0),
                                                            child: Text(
                                                                categoryInfo[
                                                                    "categoryName"],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Flexible(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0.0),
                                                            child: Text(
                                                                categoryInfo[
                                                                    "categoryDescription"],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "${getProductsUnderCategory(new_product_database, categoryInfo["categoryId"])}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black)),
                                                        //Expanded(child: Container())
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Flexible(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0.0),
                                                            child: Text(
                                                                createdByRole,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Flexible(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          tooltip:
                                                              "view category",
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                ViewHeroDialogRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return viewSingleCategory(
                                                                        categoryInstance:
                                                                            categoryInfo,
                                                                        userRole:
                                                                            createdByRole,
                                                                      );
                                                                    },
                                                                    settings: RouteSettings(
                                                                        arguments:
                                                                            "viewCategory")));
                                                          },
                                                          icon: Icon(
                                                            Icons.visibility,
                                                            size: 20,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          tooltip: "edit",
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                ViewHeroDialogRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return editSingleCategory(
                                                                        categoryInstance:
                                                                            categoryInfo,
                                                                        userId:
                                                                            userId,
                                                                      );
                                                                    },
                                                                    settings: RouteSettings(
                                                                        arguments:
                                                                            "viewProduct")));
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          tooltip: "delete",
                                                          onPressed: () {
                                                            if (!deletedElements
                                                                .contains(
                                                                    categoryInfo[
                                                                        "categoryId"])) {
                                                              deletedElements.add(
                                                                  categoryInfo[
                                                                      "categoryId"]);
                                                            }
                                                            Navigator.of(myContext).push(
                                                                ViewHeroDialogRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return deleteCategories(
                                                                          listOfCategoryIds:
                                                                              deletedElements,
                                                                          userId:
                                                                              userId);
                                                                    },
                                                                    settings: RouteSettings(
                                                                        arguments:
                                                                            "deleteCategoryData")));
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            size: 20,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        //Expanded(child: Container())
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          );
                        }),
                      ))
                ],
              ),
              //end next
            ],
          ),
        ),
      ),
    ),
  );
}

Widget productList(myContext, String userId) {
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  new_product_database
      .sort((a, b) => b["lastUpdatedOn"].compareTo(a["lastUpdatedOn"]));
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<String> deletedElements = [];
  List<Map<String, dynamic>> searched_product_response = [];
  String itemsToShow = "all";
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return prod_updateCheckBox();
      }),
      ChangeNotifierProvider(create: (BuildContext context) {
        return displayCustomers();
      }),
    ],
    child: Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product List",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Manage Your Products",
                        style: TextStyle(
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(221, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 32, 147, 42),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          myContext,
                          MaterialPageRoute(
                            builder: (context) {
                              return adminCreateNewProduct(
                                userId: userId,
                                activePage: "createNewProduct",
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text("Add New Product",
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .15, color: Colors.black),
                          color: Color.fromRGBO(242, 242, 242, .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Consumer<displayCustomers>(
                            builder: (myContext, value, child) {
                          itemsToShow = value.typeOfDisplay;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Form(
                                      child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (value) {},
                                      onChanged: (value) {
                                        searched_product_response =
                                            searchedProduct(
                                                new_product_database, value);
                                        myContext
                                            .read<displayCustomers>()
                                            .changeTypeOfDisplay("search");
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
                                        hintText: 'Search by name...',
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
                                  )),
                                  SizedBox(width: 10),
                                  Consumer<prod_updateCheckBox>(
                                      builder: (myContext, value, child) {
                                    if (deletedElements.isNotEmpty) {
                                      return TextButton(
                                          onPressed: () {
                                            Navigator.of(myContext).push(
                                                ViewHeroDialogRoute(
                                                    builder: (context) {
                                                      return deleteProducts(
                                                          listOfProductIds:
                                                              deletedElements,
                                                          userId: userId);
                                                    },
                                                    settings: RouteSettings(
                                                        arguments:
                                                            "deleteProductData")));
                                          },
                                          child: Text("Delete Selected Items",
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.red)));
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  IconButton(
                                    tooltip: "pdf",
                                    onPressed: () async {
                                      List<Map<String, dynamic>> itemsToPrint =
                                          itemsToShow == "all"
                                              ? productsToPrint(
                                                  new_product_database)
                                              : productsToPrint(
                                                  searched_product_response);
                                      if (itemsToPrint.length > 0) {
                                        final pdfFile = await productPdfApi
                                            .generate(itemsToPrint);
                                        productPdfApi.openFile(pdfFile);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.picture_as_pdf,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "excel",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.insert_drive_file,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "print",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.print,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //table
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Consumer<
                                                              prod_updateCheckBox>(
                                                          builder: (myContext,
                                                              value, child) {
                                                        return Checkbox(
                                                            value: myContext
                                                                .watch<
                                                                    prod_updateCheckBox>()
                                                                .checkBoxVal,
                                                            onChanged: (value) {
                                                              var containerForElements =
                                                                  itemsToShow ==
                                                                          "all"
                                                                      ? new_product_database
                                                                      : searched_product_response;
                                                              myContext
                                                                  .read<
                                                                      prod_updateCheckBox>()
                                                                  .changeVal(
                                                                      value!,
                                                                      "all",
                                                                      "",
                                                                      deletedElements,
                                                                      containerForElements);
                                                            });
                                                      }),
                                                      //Expanded(child: Container())
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Product name",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Category",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Supplier",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Stock price",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Unit",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Qty",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Rrp per unit",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Created by",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //values to populate the table
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: itemsToShow == "all"
                                      ? new_product_database.length
                                      : searched_product_response.length,
                                  itemBuilder: (context, index) {
                                    var productInfo = itemsToShow == "all"
                                        ? new_product_database[index]
                                        : searched_product_response[index];
                                    String createdById =
                                        productInfo["createdBy"];
                                    String createdByRole = "_";
                                    new_user_database.forEach((element) {
                                      if (createdById == element["userId"]) {
                                        createdByRole =
                                            element["userDetails"]["role"];
                                        if (createdByRole == "administrator") {
                                          createdByRole = "Super Administrator";
                                        }
                                        if (createdByRole ==
                                            "pseudo-administrator") {
                                          createdByRole = "Administrator";
                                        }
                                        if (createdByRole == "cashier") {
                                          createdByRole =
                                              StringUtils.capitalize(
                                                  createdByRole);
                                        }
                                      }
                                    });
                                    String nameOfCategory = "_";
                                    new_category_database.forEach((element) {
                                      if (productInfo["categoryId"] ==
                                          element["categoryId"]) {
                                        nameOfCategory =
                                            element["categoryName"];
                                      }
                                    });

                                    String nameOfSupplier = "_";
                                    new_supplier_database.forEach((element) {
                                      if (productInfo["supplierId"] ==
                                          element["supplierId"]) {
                                        nameOfSupplier =
                                            element["supplierName"];
                                      }
                                    });
                                    return Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Consumer<prod_updateCheckBox>(builder:
                                                                        (myContext,
                                                                            value,
                                                                            child) {
                                                                      return Checkbox(
                                                                          value: deletedElements.contains(productInfo[
                                                                              "productId"]),
                                                                          onChanged:
                                                                              (value) {
                                                                            myContext.read<prod_updateCheckBox>().changeVal(
                                                                                value!,
                                                                                "one",
                                                                                productInfo["productId"],
                                                                                deletedElements,
                                                                                new_product_database);
                                                                          });
                                                                    }),
                                                                    //Expanded(child: Container())
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              productInfo[
                                                                  "productName"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          nameOfCategory,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          nameOfSupplier,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          productInfo[
                                                              "stockPrice"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          productInfo[
                                                              "unitOfMeasurement"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          productInfo[
                                                              "quantity"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          productInfo[
                                                              "retailPrice"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Text(
                                                          createdByRole,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Flexible(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      tooltip: "view details",
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            ViewHeroDialogRoute(
                                                                builder:
                                                                    (context) {
                                                                  return viewSingleProduct(
                                                                    productInstance:
                                                                        productInfo,
                                                                    categoryName:
                                                                        nameOfCategory,
                                                                    supplierName:
                                                                        nameOfSupplier,
                                                                    userRole:
                                                                        createdByRole,
                                                                  );
                                                                },
                                                                settings: RouteSettings(
                                                                    arguments:
                                                                        "viewProduct")));
                                                      },
                                                      icon: Icon(
                                                        Icons.visibility,
                                                        size: 20,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: "edit",
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            ViewHeroDialogRoute(
                                                                builder:
                                                                    (context) {
                                                                  return editSingleProduct(
                                                                    productInstance:
                                                                        productInfo,
                                                                    userId:
                                                                        userId,
                                                                  );
                                                                },
                                                                settings: RouteSettings(
                                                                    arguments:
                                                                        "viewProduct")));
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: "add stock",
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            ViewHeroDialogRoute(
                                                                builder:
                                                                    (context) {
                                                                  return addStock(
                                                                    productInstance:
                                                                        productInfo,
                                                                    userId:
                                                                        userId,
                                                                  );
                                                                },
                                                                settings: RouteSettings(
                                                                    arguments:
                                                                        "viewProduct")));
                                                      },
                                                      icon: Icon(
                                                        Icons.add_circle,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: "delete",
                                                      onPressed: () {
                                                        if (!deletedElements
                                                            .contains(productInfo[
                                                                "productId"])) {
                                                          deletedElements.add(
                                                              productInfo[
                                                                  "productId"]);
                                                        }
                                                        Navigator.of(myContext).push(
                                                            ViewHeroDialogRoute(
                                                                builder:
                                                                    (context) {
                                                                  return deleteProducts(
                                                                      listOfProductIds:
                                                                          deletedElements,
                                                                      userId:
                                                                          userId);
                                                                },
                                                                settings: RouteSettings(
                                                                    arguments:
                                                                        "deleteProductData")));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  }),
                              //end of those values
                            ],
                          );
                        }),
                      ))
                ],
              ), //
            ],
          ),
        ),
      ),
    ),
  );
}

Widget supplierList(myContext, String userId) {
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<String> deletedElements = [];
  List<Map<String, dynamic>> searched_supplier_response = [];
  String itemsToShow = "all";
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return supp_updateCheckBox();
      }),
      ChangeNotifierProvider(create: (BuildContext context) {
        return displayCustomers();
      }),
    ],
    child: Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Supplier List",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Manage Your Suppliers",
                        style: TextStyle(
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(221, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 32, 147, 42),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          myContext,
                          MaterialPageRoute(
                            builder: (context) {
                              return adminCreateNewSupplier(
                                userId: userId,
                                activePage: "createNewSupplier",
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text("Add Supplier",
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 20),
              //next
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .15, color: Colors.black),
                          color: Color.fromRGBO(242, 242, 242, .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Consumer<displayCustomers>(
                            builder: (myContext, value, child) {
                          itemsToShow = value.typeOfDisplay;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Form(
                                      child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (value) {},
                                      onChanged: (value) {
                                        searched_supplier_response =
                                            searchedSupplier(
                                                new_supplier_database, value);
                                        myContext
                                            .read<displayCustomers>()
                                            .changeTypeOfDisplay("search");
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
                                        hintText: 'Search by name...',
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
                                  )),
                                  SizedBox(width: 10),
                                  Consumer<supp_updateCheckBox>(
                                      builder: (myContext, value, child) {
                                    if (deletedElements.isNotEmpty) {
                                      return TextButton(
                                          onPressed: () {
                                            Navigator.of(myContext).push(
                                                ViewHeroDialogRoute(
                                                    builder: (context) {
                                                      return deleteSuppliers(
                                                          listOfSupplierIds:
                                                              deletedElements,
                                                          userId: userId);
                                                    },
                                                    settings: RouteSettings(
                                                        arguments:
                                                            "deleteSupplierData")));
                                          },
                                          child: Text("Delete Selected Items",
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.red)));
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  IconButton(
                                    tooltip: "pdf",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.picture_as_pdf,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "excel",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.insert_drive_file,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "print",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.print,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //table
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Consumer<supp_updateCheckBox>(
                                                builder:
                                                    (myContext, value, child) {
                                              return Checkbox(
                                                  value: myContext
                                                      .watch<
                                                          supp_updateCheckBox>()
                                                      .checkBoxVal,
                                                  onChanged: (value) {
                                                    var containerForElements =
                                                        itemsToShow == "all"
                                                            ? new_supplier_database
                                                            : searched_supplier_response;
                                                    myContext
                                                        .read<
                                                            supp_updateCheckBox>()
                                                        .changeVal(
                                                            value!,
                                                            "all",
                                                            "",
                                                            deletedElements,
                                                            containerForElements);
                                                  });
                                            }),
                                            Expanded(child: Container())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Supplier name",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Phone",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Created by",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //values to populate the table
                              ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: itemsToShow == "all"
                                    ? new_supplier_database.length
                                    : searched_supplier_response.length,
                                itemBuilder: (context, index) {
                                  var supplierInfo = itemsToShow == "all"
                                      ? new_supplier_database[index]
                                      : searched_supplier_response[index];
                                  String createdById =
                                      supplierInfo["createdBy"];
                                  String createdByRole = "_";
                                  new_user_database.forEach((element) {
                                    if (createdById == element["userId"]) {
                                      createdByRole =
                                          element["userDetails"]["role"];
                                      if (createdByRole == "administrator") {
                                        createdByRole = "Super Administrator";
                                      }
                                      if (createdByRole ==
                                          "pseudo-administrator") {
                                        createdByRole = "Administrator";
                                      }
                                      if (createdByRole == "cashier") {
                                        createdByRole = StringUtils.capitalize(
                                            createdByRole);
                                      }
                                    }
                                  });
                                  return Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Consumer<supp_updateCheckBox>(
                                                    builder: (myContext, value,
                                                        child) {
                                                  return Checkbox(
                                                      value: deletedElements
                                                          .contains(supplierInfo[
                                                              "supplierId"]),
                                                      onChanged: (value) {
                                                        myContext
                                                            .read<
                                                                supp_updateCheckBox>()
                                                            .changeVal(
                                                                value!,
                                                                "one",
                                                                supplierInfo[
                                                                    "supplierId"],
                                                                deletedElements,
                                                                new_supplier_database);
                                                      });
                                                }),
                                                //Expanded(child: Container())
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Flexible(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0.0),
                                                      child: Text(
                                                          supplierInfo[
                                                              "supplierName"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      SizedBox(width: 5),
                                      Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0.0),
                                                      child: Text(
                                                          supplierInfo[
                                                              "phoneNumber"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      SizedBox(width: 5),
                                      Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        supplierInfo[
                                                            "emailAddress"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  //Expanded(child: Container())
                                                ],
                                              ),
                                            ],
                                          )),
                                      SizedBox(width: 5),
                                      Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0.0),
                                                      child: Text(createdByRole,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      SizedBox(width: 5),
                                      Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    tooltip: "view supplier",
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          ViewHeroDialogRoute(
                                                              builder:
                                                                  (context) {
                                                                return viewSingleSupplier(
                                                                  supplierInstance:
                                                                      supplierInfo,
                                                                  userRole:
                                                                      createdByRole,
                                                                );
                                                              },
                                                              settings:
                                                                  RouteSettings(
                                                                      arguments:
                                                                          "viewCategory")));
                                                    },
                                                    icon: Icon(
                                                      Icons.visibility,
                                                      size: 20,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    tooltip: "edit",
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          ViewHeroDialogRoute(
                                                              builder:
                                                                  (context) {
                                                                return editSingleSupplier(
                                                                  supplierInstance:
                                                                      supplierInfo,
                                                                  userId:
                                                                      userId,
                                                                );
                                                              },
                                                              settings:
                                                                  RouteSettings(
                                                                      arguments:
                                                                          "viewProduct")));
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    tooltip: "delete",
                                                    onPressed: () {
                                                      if (!deletedElements
                                                          .contains(supplierInfo[
                                                              "supplierId"])) {
                                                        deletedElements.add(
                                                            supplierInfo[
                                                                "supplierId"]);
                                                      }
                                                      Navigator.of(myContext).push(
                                                          ViewHeroDialogRoute(
                                                              builder:
                                                                  (context) {
                                                                return deleteSuppliers(
                                                                    listOfSupplierIds:
                                                                        deletedElements,
                                                                    userId:
                                                                        userId);
                                                              },
                                                              settings:
                                                                  RouteSettings(
                                                                      arguments:
                                                                          "deleteSupplierData")));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  //Expanded(child: Container())
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                      ))
                ],
              ),
              //end next
            ],
          ),
        ),
      ),
    ),
  );
}

Widget viewUsers(myContext, String userId, new_user_database) {
  List<String> deletedElements = [];
  String activeUserId = userId;
  List<Map<String, dynamic>> searched_user_response = [];
  String itemsToShow = "all";
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return updateCheckBox();
      }),
      ChangeNotifierProvider(create: (BuildContext context) {
        return displayCustomers();
      }),
    ],
    child: Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User List",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Manage your User",
                        style: TextStyle(
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(221, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 32, 147, 42),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          myContext,
                          MaterialPageRoute(
                            builder: (context) {
                              return adminCreateNewUser(
                                userId: userId,
                                activePage: "createNewUser",
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text("Add User",
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 20),
              //next
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .15, color: Colors.black),
                          color: Color.fromRGBO(242, 242, 242, .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Consumer<displayCustomers>(
                            builder: (myContext, value, child) {
                          itemsToShow = value.typeOfDisplay;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Form(
                                      child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      //controller:searchController,
                                      validator: (value) {},
                                      onChanged: (value) {
                                        searched_user_response = searchedUser(
                                            new_user_database, value);
                                        myContext
                                            .read<displayCustomers>()
                                            .changeTypeOfDisplay("search");
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
                                        hintText: 'Search by name...',
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
                                  )),
                                  SizedBox(width: 10),
                                  //start
                                  Consumer<updateCheckBox>(
                                      builder: (myContext, value, child) {
                                    if (deletedElements.isNotEmpty) {
                                      return TextButton(
                                          onPressed: () {
                                            Navigator.of(myContext).push(
                                                ViewHeroDialogRoute(
                                                    builder: (context) {
                                                      return deleteUsers(
                                                          listOfUserIds:
                                                              deletedElements,
                                                          userId: activeUserId);
                                                    },
                                                    settings: RouteSettings(
                                                        arguments:
                                                            "deleteUserData")));
                                          },
                                          child: Text("Delete Selected Items",
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.red)));
                                    } else {
                                      return Container();
                                    }
                                  }),

                                  //end
                                  Expanded(
                                    child: Container(),
                                  ),
                                  IconButton(
                                    tooltip: "pdf",
                                    onPressed: () async {
                                      List<Map<String, dynamic>> itemsToPrint =
                                          itemsToShow == "all"
                                              ? new_user_database
                                              : searched_user_response;
                                      if (itemsToPrint.length > 0) {
                                        final pdfFile =
                                            await PdfApi.generate(itemsToPrint);
                                        PdfApi.openFile(pdfFile);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.picture_as_pdf,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "excel",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.insert_drive_file,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    tooltip: "print",
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.print,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //table
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Consumer<updateCheckBox>(builder:
                                                (myContext, value, child) {
                                              return Checkbox(
                                                  value: myContext
                                                      .watch<updateCheckBox>()
                                                      .checkBoxVal,
                                                  onChanged: (value) {
                                                    var containerForElements =
                                                        itemsToShow == "all"
                                                            ? new_user_database
                                                            : searched_user_response;
                                                    myContext
                                                        .read<updateCheckBox>()
                                                        .changeVal(
                                                            value!,
                                                            "all",
                                                            "",
                                                            deletedElements,
                                                            containerForElements);
                                                  });
                                            }),
                                            Expanded(child: Container())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "First name",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Last name",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Phone",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Role",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //values to populate the table
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  height: 310,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: itemsToShow == "all"
                                        ? new_user_database.length
                                        : searched_user_response.length,
                                    itemBuilder: (context, index) {
                                      var userInfo = itemsToShow == "all"
                                          ? new_user_database[index]
                                          : searched_user_response[index];
                                      String uRole =
                                          userInfo["userDetails"]["role"];
                                      if (uRole == "administrator") {
                                        uRole = "Super Administrator";
                                      }
                                      if (uRole == "pseudo-administrator") {
                                        uRole = "Administrator";
                                      }
                                      if (uRole == "cashier") {
                                        uRole = StringUtils.capitalize(uRole);
                                      }

                                      return Row(
                                        //mainAxisAlignment:
                                        // MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Consumer<updateCheckBox>(
                                                        builder: (myContext,
                                                            value, child) {
                                                      return Checkbox(
                                                          value: deletedElements
                                                              .contains(userInfo[
                                                                  "userId"]),
                                                          onChanged: (value) {
                                                            myContext
                                                                .read<
                                                                    updateCheckBox>()
                                                                .changeVal(
                                                                    value!,
                                                                    "one",
                                                                    userInfo[
                                                                        "userId"],
                                                                    deletedElements,
                                                                    new_user_database);
                                                          });
                                                    }),
                                                    //Expanded(child: Container())
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0.0),
                                                          child: Text(
                                                              userInfo[
                                                                      "userDetails"]
                                                                  ["firstName"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Flexible(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: Text(
                                                              userInfo[
                                                                      "userDetails"]
                                                                  ["lastName"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          userInfo[
                                                                  "userDetails"]
                                                              ["phoneNumber"],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black)),
                                                      //Expanded(child: Container())
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: Text(uRole,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        tooltip: "view user",
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              ViewHeroDialogRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return viewSingleUser(
                                                                        firstName: userInfo["userDetails"]
                                                                            [
                                                                            "firstName"],
                                                                        lastName:
                                                                            userInfo["userDetails"][
                                                                                "lastName"],
                                                                        userId: userInfo[
                                                                            "userId"],
                                                                        phoneNumber: userInfo["userDetails"]
                                                                            [
                                                                            "phoneNumber"],
                                                                        dateCreated:
                                                                            userInfo["userDetails"][
                                                                                "created_on"],
                                                                        dateUpdated:
                                                                            userInfo["userDetails"][
                                                                                "last_updated_on"],
                                                                        userRole:
                                                                            userInfo["userDetails"]["role"]);
                                                                  },
                                                                  settings: RouteSettings(
                                                                      arguments:
                                                                          "viewUser")));
                                                        },
                                                        icon: Icon(
                                                          Icons.visibility,
                                                          size: 20,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        tooltip: "edit",
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              ViewHeroDialogRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return editSingleUser(
                                                                        currentUserId:
                                                                            activeUserId,
                                                                        firstName: userInfo["userDetails"]
                                                                            [
                                                                            "firstName"],
                                                                        lastName:
                                                                            userInfo["userDetails"][
                                                                                "lastName"],
                                                                        userId: userInfo[
                                                                            "userId"],
                                                                        phoneNumber: userInfo["userDetails"]
                                                                            [
                                                                            "phoneNumber"],
                                                                        encryptedPass:
                                                                            userInfo["userDetails"][
                                                                                "password"],
                                                                        dateUpdated:
                                                                            userInfo["userDetails"][
                                                                                "last_updated_on"],
                                                                        userRole:
                                                                            userInfo["userDetails"]["role"]);
                                                                  },
                                                                  settings: RouteSettings(
                                                                      arguments:
                                                                          "viewUser")));
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        tooltip: "delete",
                                                        onPressed: () {
                                                          if (!deletedElements
                                                              .contains(userInfo[
                                                                  "userId"])) {
                                                            deletedElements.add(
                                                                userInfo[
                                                                    "userId"]);
                                                          }
                                                          Navigator.of(myContext).push(
                                                              ViewHeroDialogRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return deleteUsers(
                                                                        listOfUserIds:
                                                                            deletedElements,
                                                                        userId:
                                                                            activeUserId);
                                                                  },
                                                                  settings: RouteSettings(
                                                                      arguments:
                                                                          "deleteUserData")));
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      //Expanded(child: Container())
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ))
                ],
              ),
              //end next
            ],
          ),
        ),
      ),
    ),
  );
}

Widget createNewProduct(myContext, String userId) {
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> new_stock_inventory_database =
      stockPurchaseInventoryPreference.getStockPurchaseInventory() ?? [];
  List<Map<String, dynamic>> catDropItems = createDropItems(
      "category", "not selected", "Select Category", new_category_database);
  List<Map<String, dynamic>> suppDropItems = createDropItems(
      "supplier", "not selected", "Select Supplier", new_supplier_database);
  String productExpires = "no";
  String discountType = "no discount";
  DateTime selectedDate = DateTime.now();
  TextEditingController expiryDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(selectedDate));
  final _formKey = GlobalKey<FormState>();
//dropdown controllers
  String prodCat = "not selected";
  String prodSupp = "not selected";
  String uomController = "not selected";
  String supplierPaymentStatus = "not paid";
  //other text editing controlers
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController minimumController = TextEditingController(text: "1");
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return updateExpiryDate();
      }),
    ],
    child: Expanded(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Add",
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Create New Product",
                      style: TextStyle(
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black),
                    )
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: .15, color: Colors.black),
                        color: Color.fromRGBO(242, 242, 242, .5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Name:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller: productNameController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Product name required!";
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,
                                                hintText: 'Product Name',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 11),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Category:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                              ),
                                              value: prodCat,
                                              items: catDropItems.map((e) {
                                                return DropdownMenuItem(
                                                  value: e["categoryId"],
                                                  child: Text(
                                                    e["categoryName"],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                prodCat = value!.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Supplier:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                              ),
                                              value: prodSupp,
                                              items: suppDropItems.map((e) {
                                                return DropdownMenuItem(
                                                  value: e["supplierId"],
                                                  child: Text(
                                                    e["supplierName"],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                prodSupp = value!.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Stock Price:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller: stockPriceController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Stock price required!";
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,
                                                hintText:
                                                    'Cost of Current Stock',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 11),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //second
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Unit of Measurement:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: DropdownButtonFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value == "not selected") {
                                                  return "Select U.o.M!";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                              ),
                                              value: uomController,
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'not selected',
                                                  child: Text(
                                                    'Select U.O.M',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'pc',
                                                  child: Text(
                                                    'Pieces(pc)',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'kg',
                                                  child: Text(
                                                    'Kilograms(kg)',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'litres',
                                                  child: Text(
                                                    'Litres(litres)',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                              onChanged: (value) {
                                                uomController =
                                                    value!.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Quantity:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller: quantityController,
                                              validator: (value) {
                                                String patttern =
                                                    r'^\d*\.?\d+$';
                                                RegExp regExp =
                                                    new RegExp(patttern);
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Product quantity required!";
                                                } else {
                                                  if (!regExp.hasMatch(value) ||
                                                      double.parse(value) < 0) {
                                                    return "Invalid product quantity!";
                                                  }
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,
                                                hintText: 'Quantity',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 11),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Minimum Quantity:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller: minimumController,
                                              validator: (value) {
                                                String patttern =
                                                    r'^\d*\.?\d+$';
                                                RegExp regExp =
                                                    new RegExp(patttern);
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Minimum quantity required!";
                                                } else {
                                                  if (!regExp.hasMatch(value) ||
                                                      double.parse(value) < 0) {
                                                    return "Invalid quantity!";
                                                  }
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,
                                                hintText: 'Minimum quantity',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 11),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Recommended Retail Price:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller: retailPriceController,
                                              validator: (value) {
                                                String patttern =
                                                    r'^\d*\.?\d+$';
                                                RegExp regExp =
                                                    new RegExp(patttern);
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Retail price required!";
                                                } else {
                                                  if (!regExp.hasMatch(value) ||
                                                      double.parse(value) < 0) {
                                                    return "Invalid Retail price!";
                                                  }
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,
                                                hintText: 'Rrp per unit',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 11),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      //end
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Consumer<updateExpiryDate>(
                                      builder: (myContext, value, child) {
                                    return Row(children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Product Expires?:",
                                              style: TextStyle(
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 175,
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                ),
                                                value: productExpires,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: 'no',
                                                    child: Text(
                                                      'No',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'yes',
                                                    child: Text(
                                                      'Yes',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  productExpires = value!;
                                                  //expiryController =
                                                  //value!.toString();
                                                  myContext
                                                      .read<updateExpiryDate>()
                                                      .updateVisibility(value,
                                                          productExpires);
                                                },
                                              ),
                                            )
                                          ]),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              enabled: productExpires == "yes"
                                                  ? true
                                                  : false,
                                              controller: expiryDateController,
                                              onTap: () async {
                                                final kToday = DateTime.now();
                                                final DateTime? dateTime =
                                                    await showDatePicker(
                                                  context: myContext,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(
                                                      kToday.year,
                                                      kToday.month - 3,
                                                      kToday.day),
                                                  lastDate: DateTime(
                                                      kToday.year + 2,
                                                      kToday.month + 3,
                                                      kToday.day),
                                                );
                                                if (dateTime != null) {
                                                  myContext
                                                      .read<updateExpiryDate>()
                                                      .changeDate(
                                                          dateTime,
                                                          selectedDate,
                                                          expiryDateController);
                                                }
                                              },
                                              validator: (value) {},
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                //enabled: false,
                                                prefixIconConstraints:
                                                    BoxConstraints(
                                                        minWidth: 30),
                                                prefixIcon: IconButton(
                                                  color: Colors.redAccent,
                                                  icon: Icon(
                                                      Icons.calendar_today),
                                                  onPressed: () async {
                                                    final kToday =
                                                        DateTime.now();
                                                    final DateTime? dateTime =
                                                        await showDatePicker(
                                                      context: myContext,
                                                      initialDate: selectedDate,
                                                      firstDate: DateTime(
                                                          kToday.year,
                                                          kToday.month - 3,
                                                          kToday.day),
                                                      lastDate: DateTime(
                                                          kToday.year + 2,
                                                          kToday.month + 3,
                                                          kToday.day),
                                                    );
                                                    if (dateTime != null) {
                                                      myContext
                                                          .read<
                                                              updateExpiryDate>()
                                                          .changeDate(
                                                              dateTime,
                                                              selectedDate,
                                                              expiryDateController);
                                                    }
                                                  },
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Discount Type:",
                                              style: TextStyle(
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 175,
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                ),
                                                value: discountType,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: 'no discount',
                                                    child: Text(
                                                      'No Discount',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'percentage',
                                                    child: Text(
                                                      '% Percentage Discount',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'fixed',
                                                    child: Text(
                                                      'Fixed Amount Discount',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  discountType = value!;
                                                  //expiryController =
                                                  //value!.toString();
                                                  myContext
                                                      .read<updateExpiryDate>()
                                                      .updateDiscount(
                                                          value, discountType);
                                                },
                                              ),
                                            )
                                          ]),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Recommended Discount:",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              controller:
                                                  discountAmountController,
                                              enabled:
                                                  discountType != "no discount"
                                                      ? true
                                                      : false,
                                              validator: (value) {
                                                if (discountType !=
                                                        "no discount" &&
                                                    (value == null ||
                                                        value.isEmpty)) {
                                                  return "Discount value required!";
                                                }
                                              },
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                //border: InputBorder.none,

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    96,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    22,
                                                                    27,
                                                                    137))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]);
                                  }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //comment from here
                                  //Row(children: [
                                  //Column(
                                  //crossAxisAlignment:
                                  // CrossAxisAlignment.start,
                                  //children: [
                                  //Text(
                                  //"Supplier Payment Status:",
                                  //style: TextStyle(
                                  // fontFamily: 'Proxima',
                                  //fontWeight: FontWeight.w400,
                                  //fontSize: 13,
                                  //),
                                  //),
                                  //SizedBox(
                                  //height: 10,
                                  //),
                                  //SizedBox(
                                  //width: 175,
                                  //child: DropdownButtonFormField(
                                  //decoration: InputDecoration(
                                  //isDense: true,
                                  // contentPadding:
                                  //EdgeInsets.symmetric(
                                  //    horizontal: 5,
                                  //    vertical: 10),
                                  //),
                                  //value: supplierPaymentStatus,
                                  //items: [
                                  //DropdownMenuItem(
                                  //value: 'not paid',
                                  //child: Text(
                                  //'Not Paid',
                                  //maxLines: 1,
                                  //overflow:
                                  //   TextOverflow.ellipsis,
                                  //style:
                                  // TextStyle(fontSize: 12),
                                  // ),
                                  //),
                                  //DropdownMenuItem(
                                  //value: 'paid',
                                  //child: Text(
                                  //'Paid',
                                  // maxLines: 1,
                                  //overflow:
                                  // TextOverflow.ellipsis,
                                  // style:
                                  //  TextStyle(fontSize: 12),
                                  //),
                                  //  ),
                                  // ],
                                  // onChanged: (value) {
                                  // supplierPaymentStatus =
                                  //    value!.toString();
                                  //  },
                                  //  ),
                                  // )
                                  //]),
                                  //Expanded(child: Container()),
                                  //]),
                                  //SizedBox(
                                  // height: 20,
                                  //),
                                  //to here
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                221, 255, 255, 255),
                                            backgroundColor: Color.fromARGB(
                                                255, 32, 147, 42),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                          ),
                                          onPressed: () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String productId = generateId();
                                              DateTime currentDateTime =
                                                  DateTime.now();
                                              String formattedDateTime =
                                                  DateFormat(
                                                          'dd/MM/yyyy HH:mm:ss')
                                                      .format(currentDateTime);
                                              if (prodCat == "not selected") {
                                                prodCat = "_";
                                              }
                                              if (prodSupp == "not selected") {
                                                prodSupp = "_";
                                              }
                                              String dateToExpire =
                                                  productExpires == "no"
                                                      ? "_"
                                                      : expiryDateController
                                                          .text;
                                              String discountValue =
                                                  discountType == "no discount"
                                                      ? "_"
                                                      : discountAmountController
                                                          .text
                                                          .trim();
                                              //print(dateToExpire);
                                              List<Map<String, dynamic>>
                                                  new_product_database =
                                                  productDetailsPreference
                                                          .getProductData() ??
                                                      [];
                                              new_product_database.add(
                                                  saveProductDetails(
                                                      productId,
                                                      productNameController.text
                                                          .trim(),
                                                      prodCat,
                                                      prodSupp,
                                                      stockPriceController.text
                                                          .trim(),
                                                      uomController,
                                                      quantityController.text
                                                          .trim(),
                                                      minimumController.text
                                                          .trim(),
                                                      retailPriceController.text
                                                          .trim(),
                                                      productExpires,
                                                      dateToExpire,
                                                      discountType,
                                                      discountValue,
                                                      //supplierPaymentStatus,
                                                      userId,
                                                      formattedDateTime,
                                                      formattedDateTime));
                                              await productDetailsPreference
                                                  .setProductData(
                                                      new_product_database);
                                              new_stock_inventory_database.add(
                                                  createStockPurchaseInventory(
                                                      productId,
                                                      quantityController.text
                                                          .trim(),
                                                      stockPriceController.text
                                                          .trim(),
                                                      formattedDateTime));
                                              await stockPurchaseInventoryPreference
                                                  .setStockPurchaseInventory(
                                                      new_stock_inventory_database);
                                              Navigator.push(
                                                myContext,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return adminViewProductList(
                                                      userId: userId,
                                                      activePage: "productList",
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Submit",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255))),
                                            ],
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                221, 255, 255, 255),
                                            backgroundColor:
                                                Color.fromARGB(255, 39, 41, 41),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              myContext,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return adminDashboard(
                                                    userId: userId,
                                                    activePage:
                                                        "overallDashboard",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Cancel",
                                                  style: TextStyle(
                                                      fontFamily: 'Oswald',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255))),
                                            ],
                                          ))
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    )),
  );
}

Widget createNewCategory(myContext, String userId) {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return Expanded(
      child: Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category Add",
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create New Category",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black),
                  )
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: .15, color: Colors.black),
                      color: Color.fromRGBO(242, 242, 242, .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Category Name:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: categoryNameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Category Name";
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText: 'Category Name',
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
                                    Expanded(child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Category Description (optional):",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 500,
                                          //height: 250,
                                          child: TextFormField(
                                            controller:
                                                categoryDescriptionController,
                                            maxLines: 4,
                                            validator: (value) {},
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText:
                                                  'Describe this category in a few words',
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
                                    Expanded(child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 32, 147, 42),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            DateTime currentDateTime =
                                                DateTime.now();
                                            String formattedDateTime =
                                                DateFormat(
                                                        'dd/MM/yyyy HH:mm:ss')
                                                    .format(currentDateTime);
                                            String categoryId = generateId();
                                            String catDesc =
                                                categoryDescriptionController
                                                        .text.isEmpty
                                                    ? "_"
                                                    : categoryDescriptionController
                                                        .text
                                                        .trim();
                                            List<Map<String, dynamic>>
                                                new_category_database =
                                                categoryDetailsPreference
                                                        .getCategoryData() ??
                                                    [];
                                            //print("hello there");
                                            //print(new_category_database);
                                            new_category_database.add(
                                                saveCategoryDetails(
                                                    categoryId,
                                                    categoryNameController.text
                                                        .trim(),
                                                    catDesc,
                                                    userId,
                                                    formattedDateTime,
                                                    formattedDateTime));
                                            await categoryDetailsPreference
                                                .setCategoryData(
                                                    new_category_database);
                                            Navigator.push(
                                              myContext,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return adminViewCategoryList(
                                                    userId: userId,
                                                    activePage: "categoryList",
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Submit",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 39, 41, 41),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            myContext,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return adminDashboard(
                                                  userId: userId,
                                                  activePage:
                                                      "overallDashboard",
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Cancel",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    ),
  ));
}

Widget createNewSupplier(myContext, String userId) {
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return Expanded(
      child: Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Supplier Management",
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Add or Update Supplier",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black),
                  )
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: .15, color: Colors.black),
                      color: Color.fromRGBO(242, 242, 242, .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Supplier Name:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: supplierNameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Supplier name cannot be Empty!";
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText: 'Supplier Name',
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
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone Number:",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: phoneNumberController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Supplier contact required!";
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText: 'Supplier Phone Number',
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
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email Address (Optional):",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: emailAddressController,
                                            validator: (value) {
                                              String patttern =
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                              RegExp regExp =
                                                  new RegExp(patttern);
                                              if (value!.isNotEmpty &&
                                                  !regExp.hasMatch(value)) {
                                                return 'Invalid email address!';
                                              }
                                            },
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText: 'Email address',
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
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description (Optional):",
                                          style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 175,
                                          child: TextFormField(
                                            controller: descriptionController,
                                            validator: (value) {},
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              //border: InputBorder.none,
                                              hintText:
                                                  'Add any extra information...',
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
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 32, 147, 42),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            DateTime currentDateTime =
                                                DateTime.now();
                                            String formattedDateTime =
                                                DateFormat(
                                                        'dd/MM/yyyy HH:mm:ss')
                                                    .format(currentDateTime);
                                            String supplierId = generateId();
                                            String sEmail =
                                                emailAddressController
                                                        .text.isEmpty
                                                    ? "_"
                                                    : emailAddressController
                                                        .text
                                                        .trim();
                                            String sDesc = descriptionController
                                                    .text.isEmpty
                                                ? "_"
                                                : descriptionController.text
                                                    .trim();
                                            List<Map<String, dynamic>>
                                                new_supplier_database =
                                                supplierDetailsPreference
                                                        .getSupplierData() ??
                                                    [];
                                            new_supplier_database.add(
                                                saveSupplierDetails(
                                                    supplierId,
                                                    supplierNameController.text
                                                        .trim(),
                                                    phoneNumberController.text
                                                        .trim(),
                                                    sEmail,
                                                    sDesc,
                                                    userId,
                                                    formattedDateTime,
                                                    formattedDateTime));
                                            await supplierDetailsPreference
                                                .setSupplierData(
                                                    new_supplier_database);
                                            Navigator.push(
                                              myContext,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return adminViewSupplierList(
                                                    userId: userId,
                                                    activePage: "supplierList",
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Submit",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              221, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 39, 41, 41),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            myContext,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return adminDashboard(
                                                  userId: userId,
                                                  activePage:
                                                      "overallDashboard",
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Cancel",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    ),
  ));
}

Widget overallDashboard(String userId) {
  List<Map<String, dynamic>> listExpiredProducts = expiredProducts();
  List<Map<String, dynamic>> listRecent = recentProducts();
  List<Map<String, dynamic>> outOfStock = outOfStockProducts();
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> new_sale_database =
      saleDetailsPreference.getSaleData() ?? [];
  var transactionItems = processTransactionList(
    new_product_database,
    new_sale_database,
    new_user_database,
    "all",
    "all",
    "all",
    "all",
  );
  List<Map<String, dynamic>> new_stock_inventory_database =
      stockPurchaseInventoryPreference.getStockPurchaseInventory() ?? [];
  List<Map<String, dynamic>> supplyReport = processSuppliesReportList(
      new_product_database,
      new_supplier_database,
      new_stock_inventory_database,
      "all",
      "all");
  double totalStockPurchase = 0.00;
  supplyReport.forEach((element) {
    totalStockPurchase += double.parse(element["valueOfSupplies"]);
  });
  return Expanded(
    child: Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                          child: Icon(
                        Icons.all_inclusive_outlined,
                        size: 48,
                        color: Colors.orange,
                      )),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$totalStockPurchase",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black)),
                            Text("Total Stock Purchase",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ]),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                          child: Icon(
                        Icons.analytics,
                        size: 48,
                        color: Color.fromARGB(255, 69, 18, 71),
                      )),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${calculateFilteredTotal(transactionItems, 'cash') + calculateFilteredTotal(transactionItems, 'mpesa') + calculateFilteredTotal(transactionItems, 'credit')}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black)),
                            Text("Total Sale Amount",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ]),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                          child: Icon(
                        Icons.check_circle,
                        size: 48,
                        color: Colors.green,
                      )),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${calculateFilteredTotal(transactionItems, 'cash') + calculateFilteredTotal(transactionItems, 'mpesa')}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black)),
                            Text("Total Sales Paid",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ]),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                          child: Icon(
                        Icons.credit_card,
                        size: 48,
                        color: Colors.black,
                      )),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${calculateFilteredTotal(transactionItems, 'credit')}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black)),
                            Text("Total Sales Due",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ]),
                      Expanded(child: Container()),
                    ]),
              )),
            ]),
            SizedBox(height: 20),
            Row(children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: myColor.AppColor.darkTheme,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${new_user_database.length}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white)),
                            Text("Users",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ]),
                      SizedBox(width: 10),
                      SizedBox(
                          child: Icon(Icons.person,
                              size: 48, color: Colors.white)),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${new_category_database.length}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white)),
                            Text("Product Categories",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ]),
                      SizedBox(width: 10),
                      SizedBox(
                          child: Icon(
                        Icons.category,
                        size: 48,
                        color: Colors.white,
                      )),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${new_product_database.length}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white)),
                            Text("Products",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ]),
                      SizedBox(width: 10),
                      SizedBox(
                          child: Icon(Icons.shopping_basket,
                              size: 48, color: Colors.white)),
                      Expanded(child: Container()),
                    ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromARGB(255, 69, 18, 71),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                    //mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${new_supplier_database.length}",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white)),
                            Text("Suppliers",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ]),
                      SizedBox(width: 10),
                      SizedBox(
                          child: Icon(
                        Icons.business_center,
                        size: 48,
                        color: Colors.white,
                      )),
                      Expanded(child: Container()),
                    ]),
              )),
            ]),
            SizedBox(height: 20),
            Row(children: [
              Expanded(
                  child: Container(
                height: 285,
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(children: [
                  Row(children: [
                    Text("Expired Products",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black)),
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    SizedBox(width: 5),
                    Expanded(
                        flex: 2,
                        child: Text("Product name",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 1,
                        child: Text("Quantity",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
                        child: Text("Date expired",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 5),
                  ]),
                  SizedBox(height: 5),
                  Expanded(
                    child: listExpiredProducts.length > 0
                        ? Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: listExpiredProducts.length,
                                itemBuilder: (context, index) {
                                  var expiredInstance =
                                      listExpiredProducts[index];
                                  return Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 2,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Map<String, dynamic>
                                                      prodInst = {};
                                                  for (var instanceOfProduct
                                                      in new_product_database) {
                                                    if (instanceOfProduct[
                                                            "productId"] ==
                                                        expiredInstance[
                                                            "productId"]) {
                                                      prodInst =
                                                          instanceOfProduct;
                                                    }
                                                  }
                                                  Navigator.of(context).push(
                                                      ViewHeroDialogRoute(
                                                          builder: (context) {
                                                            return editSingleProduct(
                                                              productInstance:
                                                                  prodInst,
                                                              userId: userId,
                                                            );
                                                          },
                                                          settings: RouteSettings(
                                                              arguments:
                                                                  "viewProduct")));
                                                },
                                                child: Text(
                                                    expiredInstance[
                                                        "productName"],
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme)),
                                              ),
                                            )),
                                        SizedBox(width: 2),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                expiredInstance["quantity"],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme))),
                                        SizedBox(width: 2),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                                expiredInstance["expiryDate"],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme))),
                                        SizedBox(width: 5),
                                      ]),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text("No expired products!",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ),
                  ),
                ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                height: 285,
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(children: [
                  Row(children: [
                    Text("Products Out of Stock",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black)),
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    SizedBox(width: 5),
                    Expanded(
                        flex: 2,
                        child: Text("Product name",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
                        child: Text("Supplier",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 5),
                  ]),
                  SizedBox(height: 5),
                  Expanded(
                    child: outOfStock.length > 0
                        ? Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: outOfStock.length,
                                itemBuilder: (context, index) {
                                  var stockInstance = outOfStock[index];
                                  return Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 2,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Map<String, dynamic>
                                                      prodInst = {};
                                                  for (var instanceOfProduct
                                                      in new_product_database) {
                                                    if (instanceOfProduct[
                                                            "productId"] ==
                                                        stockInstance[
                                                            "productId"]) {
                                                      prodInst =
                                                          instanceOfProduct;
                                                    }
                                                  }
                                                  Navigator.of(context).push(
                                                      ViewHeroDialogRoute(
                                                          builder: (context) {
                                                            return addStock(
                                                              productInstance:
                                                                  prodInst,
                                                              userId: userId,
                                                            );
                                                          },
                                                          settings: RouteSettings(
                                                              arguments:
                                                                  "viewProduct")));
                                                },
                                                child: Text(
                                                    stockInstance[
                                                        "productName"],
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme)),
                                              ),
                                            )),
                                        SizedBox(width: 2),
                                        Expanded(
                                            flex: 2,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Map<String, dynamic>
                                                      suppInst = {};
                                                  for (var instanceOfSupplier
                                                      in new_supplier_database) {
                                                    if (instanceOfSupplier[
                                                            "supplierId"] ==
                                                        stockInstance[
                                                            "supplierId"]) {
                                                      suppInst =
                                                          instanceOfSupplier;
                                                    }
                                                  }
                                                  Navigator.of(context).push(
                                                      ViewHeroDialogRoute(
                                                          builder: (context) {
                                                            return viewSingleSupplier(
                                                              supplierInstance:
                                                                  suppInst,
                                                              userRole:
                                                                  "administrator",
                                                            );
                                                          },
                                                          settings: RouteSettings(
                                                              arguments:
                                                                  "viewCategory")));
                                                },
                                                child: Text(
                                                    stockInstance[
                                                        "supplierName"],
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme)),
                                              ),
                                            )),
                                        SizedBox(width: 5),
                                      ]),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text("No products out of stock!",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ),
                  ),
                ]),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                height: 285,
                decoration: BoxDecoration(
                  border: Border.all(width: .15, color: Colors.black),
                  color: Color.fromRGBO(242, 242, 242, .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(children: [
                  Row(children: [
                    Text("Recently Added Products",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black)),
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    SizedBox(width: 5),
                    Expanded(
                        flex: 2,
                        child: Text("Product name",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 1,
                        child: Text("Unit price",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 2),
                    Expanded(
                        flex: 2,
                        child: Text("Date added",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 18, 18)))),
                    SizedBox(width: 5),
                  ]),
                  SizedBox(height: 5),
                  Expanded(
                    child: listRecent.length > 0
                        ? Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: listRecent.length,
                                itemBuilder: (context, index) {
                                  var recentInstance = listRecent[index];
                                  return Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 2,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Map<String, dynamic>
                                                      prodInst = {};
                                                  for (var instanceOfProduct
                                                      in new_product_database) {
                                                    if (instanceOfProduct[
                                                            "productId"] ==
                                                        recentInstance[
                                                            "productId"]) {
                                                      prodInst =
                                                          instanceOfProduct;
                                                    }
                                                  }
                                                  Navigator.of(context).push(
                                                      ViewHeroDialogRoute(
                                                          builder: (context) {
                                                            return viewSingleProduct(
                                                              productInstance:
                                                                  prodInst,
                                                              categoryName:
                                                                  recentInstance[
                                                                      "categoryName"],
                                                              supplierName:
                                                                  recentInstance[
                                                                      "supplierName"],
                                                              userRole:
                                                                  "administrator",
                                                            );
                                                          },
                                                          settings: RouteSettings(
                                                              arguments:
                                                                  "viewCategory")));
                                                },
                                                child: Text(
                                                    recentInstance[
                                                        "productName"],
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme)),
                                              ),
                                            )),
                                        SizedBox(width: 2),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                recentInstance["retailPrice"],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme))),
                                        SizedBox(width: 2),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                                recentInstance["createdOn"],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme))),
                                        SizedBox(width: 5),
                                      ]),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text("No products available!",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme)),
                          ),
                  ),
                ]),
              )),
            ]),
          ]),
    )),
  );
}

Widget adminNavColumn(myContext, String userId, String activePage) {
  return Container(
    // height: ,
    padding: EdgeInsets.only(right: 40.0),
    decoration: BoxDecoration(
        border: BorderDirectional(
            end: BorderSide(width: .15, color: Colors.black))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //first row for navigation
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Manage Users",
                        style: TextStyle(
                          fontFamily: 'Proxima',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
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
                              "View Users",
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: activePage == "viewUsers"
                                      ? Colors.orange
                                      : Colors.black),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminCreateNewUser(
                                      userId: userId,
                                      activePage: "createNewUser",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Add New User",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "createNewUser"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Manage Stock",
                        style: TextStyle(
                          fontFamily: 'Proxima',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminViewProductList(
                                      userId: userId,
                                      activePage: "productList",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("View Products",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "productList"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminCreateNewProduct(
                                      userId: userId,
                                      activePage: "createNewProduct",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Add Product",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "createNewProduct"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
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
                            child: Text("Category",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "categoryList"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Manage Suppliers",
                        style: TextStyle(
                          fontFamily: 'Proxima',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminViewSupplierList(
                                      userId: userId,
                                      activePage: "supplierList",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("View Supplier",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "supplierList"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminCreateNewSupplier(
                                      userId: userId,
                                      activePage: "createNewSupplier",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Add Supplier",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "createNewSupplier"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminViewSupplierReport(
                                      userId: userId,
                                      activePage: "viewSupplierReport",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Suppliers Report",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "viewSupplierReport"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sales",
                        style: TextStyle(
                          fontFamily: 'Proxima',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                myContext,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return adminViewSaleList(
                                      userId: userId,
                                      activePage: "saleList",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Sales Report",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: activePage == "saleList"
                                        ? Colors.orange
                                        : Colors.black))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Text("data"),
          ],
        ),
      ],
    ),
  );
}

Widget adminTopNavSection(
    context, user_data_base, String userId, String activePage) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (activePage != "overallDashboard") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return adminDashboard(
                        userId: userId,
                        activePage: "overallDashboard",
                      );
                    },
                  ),
                );
              }
            },
            child: Column(
              children: [
                Row(children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Text("Admin Dashboard",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.w600,
                          color: activePage == "overallDashboard"
                              ? Colors.orange
                              : Colors.black)),
                ]),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        IconButton(
          tooltip: "Go to POS",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return homeSalesPage(userId: userId, myCart: {});
                },
              ),
            );
          },
          icon: Icon(
            IconData(0xe4d8, fontFamily: 'MaterialIcons'),
          ),
          iconSize: 20,
          //hoverColor: const Color.fromARGB(255, 90, 81, 81),
          //highlightColor: Colors.red,
        ),
        SizedBox(
          width: 10,
        ),
        Badge(
          label: Text("${getUnreadNotifications()}"),
          offset: Offset(-1.5, 3.0),
          child: IconButton(
            tooltip: "Notifications",
            iconSize: 20.0,
            onPressed: () {
              Navigator.of(context).push(CheckoutHeroDialogRoute(
                  builder: (context) {
                    return readNotifications();
                  },
                  settings: RouteSettings(arguments: "viewNotificationData")));
            },
            icon: const Icon(Icons.notifications),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        PopupMenuButton(
          offset: Offset(0, 50.0),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          icon: Row(
            children: [
              Icon(
                const IconData(0xe043, fontFamily: 'MaterialIcons'),
                size: 35,
                color: Color.fromRGBO(94, 167, 203, 1),
              ),
              SizedBox(
                width: 5,
              ),
              getAdminNames(user_data_base, userId),
            ],
          ),
          onSelected: (value) {
            if (value == "logout") {
              //ScaffoldMessenger.of(context)
              //.showSnackBar(SnackBar(content: Text('Logging you out...')));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return logOutSplash();
                  },
                ),
              );
            }
            if (value == "Myprofile") {
              Map<String, dynamic> userInfo = {};
              for (var userInst in user_data_base) {
                if (userInst["userId"] == userId) {
                  userInfo = userInst;
                }
              }
              if (userInfo.isNotEmpty) {
                Navigator.of(context).push(ViewHeroDialogRoute(
                    builder: (context) {
                      return editMyProfile(
                          currentUserId: userId,
                          firstName: userInfo["userDetails"]["firstName"],
                          lastName: userInfo["userDetails"]["lastName"],
                          userId: userInfo["userId"],
                          phoneNumber: userInfo["userDetails"]["phoneNumber"],
                          encryptedPass: userInfo["userDetails"]["password"],
                          dateUpdated: userInfo["userDetails"]
                              ["last_updated_on"],
                          userRole: userInfo["userDetails"]["role"]);
                    },
                    settings: RouteSettings(arguments: "viewUser")));
              }
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  padding: EdgeInsets.only(right: 50, left: 20),
                  value: 'Myprofile',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'My profile',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: myColor.AppColor.darkTheme),
                          ),
                        ],
                      ),
                      Divider()
                    ],
                  )),
              PopupMenuItem(
                  padding: EdgeInsets.only(right: 50, left: 20),
                  value: 'logout',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign out',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                      Divider()
                    ],
                  )),
            ];
          },
        )
      ],
    ),
  );
}

Widget getAdminNames(user_data_base, String userId) {
  //List<Map<String, dynamic>> user_data_base =
  //userDetailsPreference.getUserData() ?? [];
  if (user_data_base.isNotEmpty) {
    for (int i = 0; i < user_data_base.length; i++) {
      if (user_data_base[i]["userId"] == userId) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${StringUtils.capitalize(user_data_base[i]["userDetails"]["firstName"])} ${StringUtils.capitalize(user_data_base[i]["userDetails"]["lastName"])}",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 5,
                ),
                FaIcon(
                  FontAwesomeIcons.caretDown,
                  size: 15,
                  color: Colors.grey,
                )
              ],
            ),
            Text(
                overflow: TextOverflow.ellipsis,
                "${StringUtils.capitalize("${roleFormatter(user_data_base[i]["userDetails"]["role"])}")}",
                style: TextStyle(fontSize: 11, color: Colors.blueGrey)),
          ],
        );
      }
    }
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("No Admin Available"),
    ],
  );
}

Widget getCashierNames(user_data_base, String userId) {
  //List<Map<String, dynamic>> user_data_base =
  //userDetailsPreference.getUserData() ?? [];
  if (user_data_base.isNotEmpty) {
    for (int i = 0; i < user_data_base.length; i++) {
      if (user_data_base[i]["userId"] == userId) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${StringUtils.capitalize(user_data_base[i]["userDetails"]["firstName"])} ${StringUtils.capitalize(user_data_base[i]["userDetails"]["lastName"])}",
                  style: TextStyle(fontSize: 10, color: Color(0xFF90EE90)),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 5,
                ),
                FaIcon(
                  FontAwesomeIcons.caretDown,
                  size: 15,
                  color: Color(0xFF90EE90),
                )
              ],
            ),
            Text(
                overflow: TextOverflow.ellipsis,
                "${StringUtils.capitalize("${roleFormatter(user_data_base[i]["userDetails"]["role"])}")}",
                style: TextStyle(fontSize: 9, color: Color(0xFF90EE90))),
          ],
        );
      }
    }
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("No Admin Available"),
    ],
  );
}

Widget paymentsTotal(myCart) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    height: 90,
    child: Row(
      children: [
        Expanded(
            child: Container(
          //padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "${getSubTotal(myCart)}",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "${getDiscount(myCart)}",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Tax Amount",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "0.00",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              )
            ],
          ),
        )),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Gross Amount",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "${getSubTotal(myCart)}",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Discount Order",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "${getDiscount(myCart)}",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${getTotal(myCart)}",
                        style: TextStyle(
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromARGB(255, 3, 139, 55)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              )
            ],
          ),
        )),
      ],
    ),
  );
}

Widget saleList(myContext, String userId) {
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_sale_database =
      saleDetailsPreference.getSaleData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<String> deletedElements = [];
  List<Map<String, dynamic>> prodDropItems =
      createProductItems("all", "All products", new_product_database);
  List<Map<String, dynamic>> userDropItems =
      createUserItems("all", "All users", new_user_database);
  String filterByProd = "all";
  String filterByPaymentType = "all";
  String filterBySettlementStatus = "all";
  String filterByDate = "all";
  //
  String filterTransByUser = "all";
  String filterTransByPaymentType = "all";
  String filterTransBySettlementStatus = "all";
  String filterTransByDate = "all";
  var prodSaleItems = processProductSaleList(
      new_product_database,
      new_sale_database,
      new_user_database,
      filterTransByUser,
      filterTransByPaymentType,
      filterTransBySettlementStatus,
      filterTransByDate);

  var transactionItems = processTransactionList(
      new_product_database,
      new_sale_database,
      new_user_database,
      filterByProd,
      filterByPaymentType,
      filterBySettlementStatus,
      filterByDate);
  return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return filterSaleItems();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return changeSalePageTabsColor();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return sale_updateCheckBox();
        }),
      ],
      child: Expanded(
        child: Consumer<changeSalePageTabsColor>(
            builder: (myContext, value, child) {
          String theActiveTab = value.activeSection;
          return Container(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sale Report",
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(height: 10),
                Row(children: [
                  TextButton(
                      onPressed: () {
                        myContext
                            .read<changeSalePageTabsColor>()
                            .changePage("overallReport");
                      },
                      child: Text(
                        "Overall report",
                        style: TextStyle(
                          fontSize: 10,
                          color: theActiveTab == "overallReport"
                              ? Colors.orange
                              : Colors.black,
                        ),
                      )),
                  SizedBox(width: 15),
                  TextButton(
                      onPressed: () {
                        myContext
                            .read<changeSalePageTabsColor>()
                            .changePage("reportPerProduct");
                      },
                      child: Text(
                        "Report per product",
                        style: TextStyle(
                          fontSize: 10,
                          color: theActiveTab == "reportPerProduct"
                              ? Colors.orange
                              : Colors.black,
                        ),
                      )),
                ]),
                SizedBox(height: 5),
                theActiveTab == "overallReport"
                    ? Column(mainAxisSize: MainAxisSize.min, children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Consumer<filterSaleItems>(
                              builder: (myContext, value, child) {
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .15, color: Colors.black),
                                  color: Color.fromRGBO(242, 242, 242, .5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Filter by",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(children: [
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "User",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme),
                                              ),
                                              SizedBox(height: 5),
                                              DropdownButtonFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                ),
                                                value: filterTransByUser,
                                                items: userDropItems.map((e) {
                                                  return DropdownMenuItem(
                                                    value: e["userId"],
                                                    child: Text(
                                                      e["userName"],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  filterTransByUser =
                                                      value.toString();
                                                  transactionItems =
                                                      processTransactionList(
                                                          new_product_database,
                                                          new_sale_database,
                                                          new_user_database,
                                                          filterTransByUser,
                                                          filterTransByPaymentType,
                                                          filterTransBySettlementStatus,
                                                          filterTransByDate);
                                                  myContext
                                                      .read<filterSaleItems>()
                                                      .hitRefresh();
                                                },
                                              )
                                            ])),
                                    SizedBox(width: 30),
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme),
                                              ),
                                              SizedBox(height: 5),
                                              DropdownButtonFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                ),
                                                value: filterTransByDate,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "all",
                                                    child: Text(
                                                      "All",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "today",
                                                    child: Text(
                                                      "Today",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "this week",
                                                    child: Text(
                                                      "This Week",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "last week",
                                                    child: Text(
                                                      "Last Week",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "this month",
                                                    child: Text(
                                                      "This Month",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "last month",
                                                    child: Text(
                                                      "Last Month",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                                onChanged: (value) {
                                                  filterTransByDate =
                                                      value.toString();
                                                  transactionItems =
                                                      processTransactionList(
                                                          new_product_database,
                                                          new_sale_database,
                                                          new_user_database,
                                                          filterTransByUser,
                                                          filterTransByPaymentType,
                                                          filterTransBySettlementStatus,
                                                          filterTransByDate);
                                                  myContext
                                                      .read<filterSaleItems>()
                                                      .hitRefresh();
                                                },
                                              )
                                            ])),
                                    SizedBox(width: 30),
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Payment type",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme),
                                              ),
                                              SizedBox(height: 5),
                                              DropdownButtonFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                ),
                                                value: filterTransByPaymentType,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "all",
                                                    child: Text(
                                                      "All",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "cash",
                                                    child: Text(
                                                      "Cash",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "mpesa",
                                                    child: Text(
                                                      "M-pesa",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "credit",
                                                    child: Text(
                                                      "Credit",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                                onChanged: (value) {
                                                  filterTransByPaymentType =
                                                      value.toString();
                                                  transactionItems =
                                                      processTransactionList(
                                                          new_product_database,
                                                          new_sale_database,
                                                          new_user_database,
                                                          filterTransByUser,
                                                          filterTransByPaymentType,
                                                          filterTransBySettlementStatus,
                                                          filterTransByDate);
                                                  myContext
                                                      .read<filterSaleItems>()
                                                      .hitRefresh();
                                                },
                                              )
                                            ])),
                                    SizedBox(width: 30),
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Payment status",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Proxima',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: myColor
                                                        .AppColor.darkTheme),
                                              ),
                                              SizedBox(height: 5),
                                              DropdownButtonFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                ),
                                                value:
                                                    filterTransBySettlementStatus,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "all",
                                                    child: Text(
                                                      "All",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "settled",
                                                    child: Text(
                                                      "Settled",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "not settled",
                                                    child: Text(
                                                      "Not Settled",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  filterTransBySettlementStatus =
                                                      value.toString();
                                                  transactionItems =
                                                      processTransactionList(
                                                          new_product_database,
                                                          new_sale_database,
                                                          new_user_database,
                                                          filterTransByUser,
                                                          filterTransByPaymentType,
                                                          filterTransBySettlementStatus,
                                                          filterTransByDate);
                                                  myContext
                                                      .read<filterSaleItems>()
                                                      .hitRefresh();
                                                },
                                              )
                                            ])),
                                    SizedBox(width: 10),
                                    Consumer<sale_updateCheckBox>(
                                        builder: (myContext, value, child) {
                                      if (deletedElements.isNotEmpty) {
                                        return TextButton(
                                            onPressed: () {
                                              Navigator.of(myContext).push(
                                                  ViewHeroDialogRoute(
                                                      builder: (context) {
                                                        return deleteTransactions(
                                                            listOfTransIds:
                                                                deletedElements,
                                                            userId: userId);
                                                      },
                                                      settings: RouteSettings(
                                                          arguments:
                                                              "deleteTransactionData")));
                                            },
                                            child: Text(
                                                "Delete Selected Item(s)",
                                                style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Colors.red)));
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    //added
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Consumer<sale_updateCheckBox>(
                                        builder: (myContext, value, child) {
                                      return deletedElements.length == 0
                                          ? Row(
                                              children: [
                                                IconButton(
                                                  tooltip: "pdf",
                                                  onPressed: () async{
                                                    List<Map<String, dynamic>>
                                                        itemsToPrint = transactionItems;
                                                    if (itemsToPrint.length >
                                                        0) {
                                                      final pdfFile =
                                                          await transactionPdfApi
                                                              .generate(
                                                                  itemsToPrint);
                                                      transactionPdfApi
                                                          .openFile(pdfFile);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.picture_as_pdf,
                                                    size: 20,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconButton(
                                                  tooltip: "excel",
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.insert_drive_file,
                                                    size: 20,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconButton(
                                                  tooltip: "print",
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.print,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container();
                                    })
                                  ]),
                                  SizedBox(height: 10),
                                  Row(children: [
                                    SizedBox(width: 15),
                                    SizedBox(
                                      width: 20,
                                      child: Consumer<sale_updateCheckBox>(
                                          builder: (myContext, value, child) {
                                        return Checkbox(
                                            value: myContext
                                                .watch<sale_updateCheckBox>()
                                                .checkBoxVal,
                                            onChanged: (value) {
                                              myContext
                                                  .read<sale_updateCheckBox>()
                                                  .changeVal(
                                                      value!,
                                                      "all",
                                                      "",
                                                      deletedElements,
                                                      new_sale_database);
                                            });
                                      }),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Transacted amount",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Payment type",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Served by",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Date",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Action",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 18, 18)),
                                        )),
                                    SizedBox(width: 5),
                                  ]),
                                  SizedBox(height: 10),
                                  //temp
                                  Container(
                                    height: 280,
                                    child: transactionItems.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: transactionItems.length,
                                            itemBuilder: (context, index) {
                                              var transInstance =
                                                  transactionItems[index];
                                              if (transactionItems.isNotEmpty) {
                                                //print("${prodSaleItems.length}");
                                                return Column(
                                                  children: [
                                                    Row(children: [
                                                      SizedBox(width: 15),
                                                      SizedBox(
                                                        width: 20,
                                                        child: Consumer<
                                                                sale_updateCheckBox>(
                                                            builder: (myContext,
                                                                value, child) {
                                                          return Checkbox(
                                                              value: deletedElements
                                                                  .contains(
                                                                      transInstance[
                                                                          "saleId"]),
                                                              onChanged:
                                                                  (value) {
                                                                myContext
                                                                    .read<
                                                                        sale_updateCheckBox>()
                                                                    .changeVal(
                                                                        value!,
                                                                        "one",
                                                                        transInstance[
                                                                            "saleId"],
                                                                        deletedElements,
                                                                        new_sale_database);
                                                              });
                                                        }),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "${transInstance["amountTotal"]}",
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "${transInstance["checkoutMethod"]}",
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "${transInstance["settlementStatus"]}",
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "${transInstance["servedBy"]}",
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "${transInstance["lastUpdatedOn"]}",
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontFamily:
                                                                    'Proxima',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                          flex: 1,
                                                          child: IconButton(
                                                            tooltip:
                                                                "view more details",
                                                            onPressed: () {
                                                              Navigator.of(context).push(
                                                                  ViewHeroDialogRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return viewSingleTransaction(
                                                                          transactionInstance:
                                                                              transInstance,
                                                                          productList:
                                                                              new_product_database,
                                                                          userList:
                                                                              new_user_database,
                                                                        );
                                                                      },
                                                                      settings: RouteSettings(
                                                                          arguments:
                                                                              "viewTransaction")));
                                                            },
                                                            icon: Icon(
                                                              Icons.visibility,
                                                              size: 20,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          )),
                                                      SizedBox(width: 5),
                                                    ]),
                                                    SizedBox(height: 5),
                                                  ],
                                                );
                                              }
                                            })
                                        : Container(
                                            child: Row(children: [
                                              Expanded(child: Container()),
                                              Text("No item to display!",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Colors.redAccent)),
                                              Expanded(child: Container()),
                                            ]),
                                          ),
                                  ),
                                  SizedBox(height: 5),

                                  //endtemp
                                ]));
                          }),
                        ),
                        //totals figures
                        Consumer<filterSaleItems>(
                            builder: (myContext, value, child) {
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(child: Container()),
                                Text(
                                  "Cash payments:",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                Text(
                                    "${calculateFilteredTotal(transactionItems, 'cash')}",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: myColor.AppColor.darkTheme)),
                                SizedBox(width: 30),
                                Text(
                                  "Mpesa payments:",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                Text(
                                    "${calculateFilteredTotal(transactionItems, 'mpesa')}",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: myColor.AppColor.darkTheme)),
                                SizedBox(width: 30),
                                Text(
                                  "Pending payments:",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                Text(
                                    "${calculateFilteredTotal(transactionItems, 'credit')}",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: myColor.AppColor.darkTheme)),
                                SizedBox(width: 65),
                              ]);
                        }),
                      ])
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              fit: FlexFit.loose,
                              child: Consumer<filterSaleItems>(
                                  builder: (myContext, value, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .15, color: Colors.black),
                                    color: Color.fromRGBO(242, 242, 242, .5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Filter by",
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(children: [
                                        SizedBox(
                                            width: 150,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Product",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme),
                                                  ),
                                                  SizedBox(height: 5),
                                                  DropdownButtonFormField(
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 1.0,
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                    ),
                                                    value: filterByProd,
                                                    items:
                                                        prodDropItems.map((e) {
                                                      return DropdownMenuItem(
                                                        value: e["productId"],
                                                        child: Text(
                                                          e["productName"],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      filterByProd =
                                                          value.toString();
                                                      prodSaleItems =
                                                          processProductSaleList(
                                                              new_product_database,
                                                              new_sale_database,
                                                              new_user_database,
                                                              filterByProd,
                                                              filterByPaymentType,
                                                              filterBySettlementStatus,
                                                              filterByDate);
                                                      myContext
                                                          .read<
                                                              filterSaleItems>()
                                                          .hitRefresh();
                                                    },
                                                  )
                                                ])),
                                        SizedBox(width: 30),
                                        SizedBox(
                                            width: 150,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme),
                                                  ),
                                                  SizedBox(height: 5),
                                                  DropdownButtonFormField(
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 1.0,
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                    ),
                                                    value: filterByDate,
                                                    items: [
                                                      DropdownMenuItem(
                                                        value: "all",
                                                        child: Text(
                                                          "All",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "today",
                                                        child: Text(
                                                          "Today",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "this week",
                                                        child: Text(
                                                          "This Week",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "last week",
                                                        child: Text(
                                                          "Last Week",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "this month",
                                                        child: Text(
                                                          "This Month",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "last month",
                                                        child: Text(
                                                          "Last Month",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                    onChanged: (value) {
                                                      filterByDate =
                                                          value.toString();
                                                      prodSaleItems =
                                                          processProductSaleList(
                                                              new_product_database,
                                                              new_sale_database,
                                                              new_user_database,
                                                              filterByProd,
                                                              filterByPaymentType,
                                                              filterBySettlementStatus,
                                                              filterByDate);
                                                      myContext
                                                          .read<
                                                              filterSaleItems>()
                                                          .hitRefresh();
                                                    },
                                                  )
                                                ])),
                                        SizedBox(width: 30),
                                        SizedBox(
                                            width: 150,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Payment type",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme),
                                                  ),
                                                  SizedBox(height: 5),
                                                  DropdownButtonFormField(
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 1.0,
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                    ),
                                                    value: filterByPaymentType,
                                                    items: [
                                                      DropdownMenuItem(
                                                        value: "all",
                                                        child: Text(
                                                          "All",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "cash",
                                                        child: Text(
                                                          "Cash",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "mpesa",
                                                        child: Text(
                                                          "M-pesa",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "credit",
                                                        child: Text(
                                                          "Credit",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                    onChanged: (value) {
                                                      filterByPaymentType =
                                                          value.toString();
                                                      prodSaleItems =
                                                          processProductSaleList(
                                                              new_product_database,
                                                              new_sale_database,
                                                              new_user_database,
                                                              filterByProd,
                                                              filterByPaymentType,
                                                              filterBySettlementStatus,
                                                              filterByDate);
                                                      myContext
                                                          .read<
                                                              filterSaleItems>()
                                                          .hitRefresh();
                                                    },
                                                  )
                                                ])),
                                        SizedBox(width: 30),
                                        SizedBox(
                                            width: 150,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Payment status",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme),
                                                  ),
                                                  SizedBox(height: 5),
                                                  DropdownButtonFormField(
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 1.0,
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                    ),
                                                    value:
                                                        filterBySettlementStatus,
                                                    items: [
                                                      DropdownMenuItem(
                                                        value: "all",
                                                        child: Text(
                                                          "All",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "settled",
                                                        child: Text(
                                                          "Settled",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "not settled",
                                                        child: Text(
                                                          "Not Settled",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      filterBySettlementStatus =
                                                          value.toString();
                                                      prodSaleItems =
                                                          processProductSaleList(
                                                              new_product_database,
                                                              new_sale_database,
                                                              new_user_database,
                                                              filterByProd,
                                                              filterByPaymentType,
                                                              filterBySettlementStatus,
                                                              filterByDate);
                                                      myContext
                                                          .read<
                                                              filterSaleItems>()
                                                          .hitRefresh();
                                                    },
                                                  )
                                                ])),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        SizedBox(width: 5),
                                        SizedBox(
                                          width: 10,
                                          child: Checkbox(
                                            value: false,
                                            onChanged: (value) {},
                                            visualDensity: VisualDensity
                                                .adaptivePlatformDensity,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Product name",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Unit",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Amount",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Payment type",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Status",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Served by",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Date",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 109, 18, 18)),
                                            )),
                                        SizedBox(width: 5),
                                      ]),
                                      SizedBox(height: 10),
                                      //Expanded(child: Container()),
                                      Container(
                                        height: 280,
                                        child: prodSaleItems.isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: prodSaleItems.length,
                                                itemBuilder: (context, index) {
                                                  var prodInstance =
                                                      prodSaleItems[index];
                                                  if (prodSaleItems
                                                      .isNotEmpty) {
                                                    //print("${prodSaleItems.length}");
                                                    return Column(
                                                      children: [
                                                        Row(children: [
                                                          SizedBox(width: 5),
                                                          SizedBox(
                                                            width: 10,
                                                            child: Checkbox(
                                                              value: false,
                                                              onChanged:
                                                                  (value) {},
                                                              visualDensity:
                                                                  VisualDensity
                                                                      .adaptivePlatformDensity,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                prodInstance[
                                                                    "productName"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                "${prodInstance["quantity"]}",
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                prodInstance[
                                                                    "unitOfMeasurement"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                "${prodInstance["productTotal"]}",
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                prodInstance[
                                                                    "checkoutMethod"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                prodInstance[
                                                                    "settlementStatus"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                prodInstance[
                                                                    "servedBy"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                prodInstance[
                                                                    "transactionDate"],
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'Proxima',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          SizedBox(width: 5),
                                                        ]),
                                                        SizedBox(height: 5),
                                                      ],
                                                    );
                                                  }
                                                })
                                            : Container(
                                                child: Row(children: [
                                                  Expanded(child: Container()),
                                                  Text("No item to display!",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Colors
                                                              .redAccent)),
                                                  Expanded(child: Container()),
                                                ]),
                                              ),
                                      )
                                    ],
                                  ),
                                );
                              })),
                          //total
                          Consumer<filterSaleItems>(
                              builder: (myContext, value, child) {
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    "Cash payments:",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      "${calculateFilteredProductTotal(prodSaleItems, 'cash')}",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: myColor.AppColor.darkTheme)),
                                  SizedBox(width: 30),
                                  Text(
                                    "Mpesa payments:",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      "${calculateFilteredProductTotal(prodSaleItems, 'mpesa')}",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: myColor.AppColor.darkTheme)),
                                  SizedBox(width: 30),
                                  Text(
                                    "Pending payments:",
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      "${calculateFilteredProductTotal(prodSaleItems, 'credit')}",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: myColor.AppColor.darkTheme)),
                                  SizedBox(width: 65),
                                ]);
                          }),
                        ],
                      ),
              ],
            ),
          ));
        }),
      ));
}

Widget customerNames(String customerId) {
  List<Map<String, dynamic>> customerDatabase =
      customerDetailsPreference.getCustomerData() ?? [];
  bool noCustomer = false;
  if (customerDatabase.isNotEmpty) {
    var rightInstance = {};
    for (var customerInstance in customerDatabase) {
      if (customerInstance["customerId"] == customerId && customerId != "_") {
        rightInstance = customerInstance;
        //print("hit 222!");
        break;
      }
    }
    if (customerId == "_") {
      noCustomer = true;
    }
    if (noCustomer == false) {
      //print("running!");
      return Container(
        child: Row(children: [
          Text("Customer name:",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Proxima',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromARGB(255, 109, 18, 18))),
          SizedBox(width: 5),
          Text("${rightInstance["firstName"]} ${rightInstance["lastName"]}",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Proxima',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromARGB(255, 109, 18, 18)))
        ]),
      );
    } else {
      //print("here!");
      return Container();
    }
  } else {
    //print("here 555!");
    return Container();
  }
}

Widget supplierReport(myContext, String userId) {
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> suppDropItems = createDropItems(
      "supplier", "all", "All Suppliers", new_supplier_database);
  List<Map<String, dynamic>> new_stock_inventory_database =
      stockPurchaseInventoryPreference.getStockPurchaseInventory() ?? [];
  String filterBySupplier = "all";
  String filterByDate = "all";
  List<Map<String, dynamic>> supplyReport = processSuppliesReportList(
      new_product_database,
      new_supplier_database,
      new_stock_inventory_database,
      filterBySupplier,
      filterByDate);
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return filterSaleItems();
      }),
    ],
    child: Expanded(
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Suppliers Report",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .15, color: Colors.black),
                                  color: Color.fromRGBO(242, 242, 242, .5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Consumer<filterSaleItems>(
                                    builder: (myContext, value, child) {
                                  return Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Filter by",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(children: [
                                      SizedBox(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Supplier",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: myColor
                                                          .AppColor.darkTheme),
                                                ),
                                                SizedBox(height: 5),
                                                DropdownButtonFormField(
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1.0,
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5),
                                                  ),
                                                  value: filterBySupplier,
                                                  items: suppDropItems.map((e) {
                                                    return DropdownMenuItem(
                                                      value: e["supplierId"],
                                                      child: Text(
                                                        e["supplierName"],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    filterBySupplier =
                                                        value.toString();
                                                    supplyReport =
                                                        processSuppliesReportList(
                                                            new_product_database,
                                                            new_supplier_database,
                                                            new_stock_inventory_database,
                                                            filterBySupplier,
                                                            filterByDate);
                                                    myContext
                                                        .read<filterSaleItems>()
                                                        .hitRefresh();
                                                  },
                                                )
                                              ])),
                                      SizedBox(width: 30),
                                      SizedBox(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: myColor
                                                          .AppColor.darkTheme),
                                                ),
                                                SizedBox(height: 5),
                                                DropdownButtonFormField(
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1.0,
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5),
                                                  ),
                                                  value: filterByDate,
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: "all",
                                                      child: Text(
                                                        "All",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "today",
                                                      child: Text(
                                                        "Today",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "this week",
                                                      child: Text(
                                                        "This Week",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "last week",
                                                      child: Text(
                                                        "Last Week",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "this month",
                                                      child: Text(
                                                        "This Month",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "last month",
                                                      child: Text(
                                                        "Last Month",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                  onChanged: (value) {
                                                    filterByDate =
                                                        value.toString();
                                                    supplyReport =
                                                        processSuppliesReportList(
                                                            new_product_database,
                                                            new_supplier_database,
                                                            new_stock_inventory_database,
                                                            filterBySupplier,
                                                            filterByDate);
                                                    myContext
                                                        .read<filterSaleItems>()
                                                        .hitRefresh();
                                                  },
                                                )
                                              ])),
                                      //added
                                      Expanded(
                                        child: Container(),
                                      ),
                                      IconButton(
                                        tooltip: "pdf",
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.picture_as_pdf,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                        tooltip: "excel",
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.insert_drive_file,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                        tooltip: "print",
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.print,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      )
                                    ]),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Supplier name",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 109, 18, 18)),
                                          ),
                                          //Expanded(child: Container()),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Product supplied",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 109, 18, 18)),
                                          ),
                                          //Expanded(child: Container()),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Supplied quantity",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 109, 18, 18)),
                                          ),
                                          //Expanded(child: Container()),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Total value of supplies",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 109, 18, 18)),
                                          ),
                                          //Expanded(child: Container()),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Last supply date",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 109, 18, 18)),
                                          ),
                                          //Expanded(child: Container()),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 335,
                                      child: supplyReport.length > 0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: supplyReport.length,
                                              itemBuilder: (context, index) {
                                                var supplyMap =
                                                    supplyReport[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Row(children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        supplyMap[
                                                            "supplierName"],
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: myColor
                                                                .AppColor
                                                                .darkTheme),
                                                      ),
                                                      //Expanded(child: Container()),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        supplyMap[
                                                            "productName"],
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: myColor
                                                                .AppColor
                                                                .darkTheme),
                                                      ),
                                                      //Expanded(child: Container()),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        supplyMap[
                                                            "suppliedQuantity"],
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: myColor
                                                                .AppColor
                                                                .darkTheme),
                                                      ),
                                                      //Expanded(child: Container()),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        supplyMap[
                                                            "valueOfSupplies"],
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: myColor
                                                                .AppColor
                                                                .darkTheme),
                                                      ),
                                                      //Expanded(child: Container()),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        supplyMap[
                                                            "lastSupplyDate"],
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: myColor
                                                                .AppColor
                                                                .darkTheme),
                                                      ),
                                                      //Expanded(child: Container()),
                                                    ),
                                                  ]),
                                                );
                                              })
                                          : Center(
                                              child: Text(
                                                  "No items to display!",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Colors.redAccent)),
                                            ),
                                    )
                                  ]);
                                }))),
                      ])
                    ])))),
  );
}

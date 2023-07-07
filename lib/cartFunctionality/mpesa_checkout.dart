import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midusa_pos/custom_rect_tween.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/home_page.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/workers/workers.dart';
import 'package:provider/provider.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/sale_utils.dart';

class mpesaCheckout extends StatelessWidget {
  mpesaCheckout({
    super.key,
    required this.activeUserId,
    required this.cartData,
    //required this.activeIndex
  });
  Map<String, dynamic> cartData;
  String activeUserId;
  //int activeIndex;
  //final TextEditingController customQuantityController =
  //TextEditingController();
  //final TextEditingController customAmountController = TextEditingController();
  double returnBalance = 0.00;
  bool buttonVisible = false;
  double cartTotal = 0.00;
  double amountReceived = 0.00;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 300.0, vertical: 32.0),
        child: Hero(
            tag: 'mpesa checkout',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (BuildContext context) {
                      return processCheckout();
                    }),
                    //ChangeNotifierProvider(create: (BuildContext context) {
                    // return numberOfBillers();
                    //}),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Consumer<processCheckout>(
                        builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mpesa Checkout",
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                cartData["cartId"],
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: myColor.AppColor.darkTheme),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          paymentsTotal(cartData),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Text("Enter Amount Received via Mpesa:",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: myColor.AppColor.darkTheme)),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 90,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      cartTotal = getTotal(cartData);
                                      RegExp regex = RegExp(
                                          r'^[+-]?(\d+|\d{1,3}(,\d{3})*)(\.\d+)?$');
                                      if (regex.hasMatch(value) == true) {
                                        if (value.length > 0 &&
                                            double.parse(value) >= cartTotal) {
                                          amountReceived = double.parse(value);
                                          returnBalance =
                                              double.parse(value) - cartTotal;
                                          buttonVisible = true;
                                          context
                                              .read<processCheckout>()
                                              .hitRefresh();
                                        }
                                        if (value.length >= 0 &&
                                            double.parse(value) < cartTotal) {
                                          returnBalance = 0.00;
                                          buttonVisible = false;
                                          context
                                              .read<processCheckout>()
                                              .hitRefresh();
                                        }
                                      }
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 3, 139, 55)),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      //border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Color.fromARGB(96, 0, 0, 0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  179, 22, 27, 137))),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Text("Return:",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: myColor.AppColor.darkTheme)),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 90,
                                child: buttonVisible == true
                                    ? Text("$returnBalance",
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 3, 139, 55)))
                                    : Container(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buttonVisible == true
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(221, 255, 255, 255),
                                    backgroundColor:
                                        Color.fromARGB(255, 32, 147, 42),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                  ),
                                  onPressed: () async {
                                    List<Map<String, dynamic>>
                                        new_product_database =
                                        productDetailsPreference
                                                .getProductData() ??
                                            [];
                                    updateProductQuantity(
                                        new_product_database, cartData);
                                    await productDetailsPreference
                                        .setProductData(new_product_database);
                                    DateTime currentDateTime = DateTime.now();
                                    String formattedDateTime =
                                        DateFormat('dd/MM/yyyy HH:mm:ss')
                                            .format(currentDateTime);
                                    List<Map<String, dynamic>>
                                        new_sale_database =
                                        saleDetailsPreference.getSaleData() ??
                                            [];
                                    new_sale_database.add(saveSaleDetails(
                                        cartData["cartId"],
                                        cartData["cartItems"],
                                        cartData["customerId"],
                                        cartTotal.toString(),
                                        formattedDateTime,
                                        formattedDateTime,
                                        activeUserId,
                                        amountReceived.toString(),
                                        returnBalance.toString(),
                                        "mpesa",
                                        "settled",
                                        "0.00"));
                                    await saleDetailsPreference
                                        .setSaleData(new_sale_database);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return homeSalesPage(
                                              userId: activeUserId, myCart: {});
                                        },
                                      ),
                                    );
                                  },
                                  child: Text("Done",
                                      style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))))
                              : Container(),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

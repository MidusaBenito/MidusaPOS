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
import 'package:midusa_pos/local_database/customer_utils.dart';

class creditCheckout extends StatelessWidget {
  creditCheckout({
    super.key,
    required this.activeUserId,
    required this.cartData,
    //required this.customerId,
  });
  Map<String, dynamic> cartData;
  String activeUserId;
  //String customerId;
  //final TextEditingController customQuantityController =
  //TextEditingController();
  //final TextEditingController customAmountController = TextEditingController();
  List<Map<String, dynamic>> new_customer_database =
      customerDetailsPreference.getCustomerData() ?? [];
  double returnBalance = 0.00;
  double cartTotal = 0.00;
  double amountReceived = 0.00;
  String custName = "";
  String custPhone = "";
  @override
  Widget build(BuildContext context) {
    for (var customerInstance in new_customer_database) {
      if (customerInstance["customerId"] == cartData["customerId"]) {
        custName =
            "${customerInstance["firstName"]} ${customerInstance["lastName"]}";
        custPhone = customerInstance["phoneNumber"];
        break;
      }
    }
    return Center(
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 300.0, vertical: 32.0),
          child: Hero(
            tag: 'credit checkout',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Checkout on Credit",
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
                      Container(
                        child: Column(children: [
                          Row(
                            children: [
                              Text("Customer details:",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 7, 223, 243)))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Name:",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 7, 223, 243))),
                              SizedBox(
                                width: 5,
                              ),
                              Text(custName,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Phone:",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 7, 223, 243))),
                              SizedBox(
                                width: 5,
                              ),
                              Text(custPhone,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Colors.black)),
                            ],
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      paymentsTotal(cartData),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(221, 255, 255, 255),
                            backgroundColor: Color.fromARGB(255, 32, 147, 42),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                          onPressed: () async {
                            cartTotal = getTotal(cartData);
                            List<Map<String, dynamic>> new_product_database =
                                productDetailsPreference.getProductData() ?? [];
                            updateProductQuantity(
                                new_product_database, cartData);
                            await productDetailsPreference
                                .setProductData(new_product_database);
                            DateTime currentDateTime = DateTime.now();
                            String formattedDateTime =
                                DateFormat('dd/MM/yyyy HH:mm:ss')
                                    .format(currentDateTime);
                            List<Map<String, dynamic>> new_sale_database =
                                saleDetailsPreference.getSaleData() ?? [];
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
                                "credit",
                                "not settled",
                                cartTotal.toString()));
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
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

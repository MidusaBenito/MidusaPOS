import 'package:flutter/material.dart';
import 'package:midusa_pos/admin_dashboard.dart';
import 'package:midusa_pos/admin_dashboard_pages/ViewSingleItem/view_hero_routes.dart';
import 'package:midusa_pos/admin_dashboard_pages/editSingleItem/edit_my_profile.dart';
import 'package:midusa_pos/cartFunctionality/account_sales.dart';
import 'package:midusa_pos/cartFunctionality/attach_customer.dart';
import 'package:midusa_pos/cartFunctionality/cart_hero_routes.dart';
import 'package:midusa_pos/cartFunctionality/cash_checkout.dart';
import 'package:midusa_pos/cartFunctionality/checkout_hero_routes.dart';
import 'package:midusa_pos/cartFunctionality/create_customer.dart';
import 'package:midusa_pos/cartFunctionality/credit_checkout.dart';
import 'package:midusa_pos/cartFunctionality/edit_quantity.dart';
import 'package:midusa_pos/cartFunctionality/mpesa_checkout.dart';
import 'package:midusa_pos/cartFunctionality/resume_paused_cart.dart';
import 'package:midusa_pos/cartFunctionality/view_today_sales.dart';
import 'package:midusa_pos/logout.dart';
import 'package:midusa_pos/midusa_providers/midusa_providers.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/category_utils.dart';
import 'package:midusa_pos/local_database/paused_cart_utils.dart';
//import 'package:midusa_pos/local_database/shopping_cart_utils.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/workers/workers.dart';
import 'package:provider/provider.dart';

class homeSalesPage extends StatelessWidget {
  homeSalesPage({super.key, required this.userId, required this.myCart});
  final String userId;
  Map<String, dynamic> myCart;
  List<Map<String, dynamic>> new_user_database =
      userDetailsPreference.getUserData() ?? [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> new_paused_cart_database =
      pausedCartDetailsPreference.getPausedCartData() ?? [];
  final TextEditingController searchEditingController = TextEditingController();
  List<Map<String, dynamic>> searchedResponse = [];
  //cart data
  //List<Map<String, dynamic>> new_shoppingCart =
  //shoppingCartDetailsPreference.getshoppingCartData() ?? [];
  List<Map<String, dynamic>> cartItems = [];
  String cartTransactionCode = "";
  bool customerAttached = false;
  Color activeCustomerColor = Color.fromARGB(255, 205, 173, 14);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> productToDisplay =
        productCategoryResponse(new_category_database, new_product_database);
    List<Map<String, dynamic>> catDropItems =
        posDropItems("all", "Filter by Category", productToDisplay);
    //removing all items with quantity as zero
    if (myCart.isNotEmpty) {
      int indexToRemove = 0;
      cartTransactionCode = myCart["cartId"];
      bool zeroFound = false;
      if (myCart["cartItems"].length > 0) {
        for (var activeCart in myCart["cartItems"]) {
          if (activeCart["quantity"] == 0) {
            //myCart["cartItems"].remove(activeCart)
            zeroFound = true;
            break;
          }
          indexToRemove += 1;
        }
      }
      if (zeroFound) {
        myCart["cartItems"].remove(myCart["cartItems"][indexToRemove]);
        if (myCart["cartItems"].length == 0) {
          myCart = {};
          cartTransactionCode = "";
        }
      }
      if (myCart["customerId"] != "_") {
        customerAttached = true;
      }
    }

    String userRole = getUserRole(new_user_database, userId);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return displayProducts();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return refreshCart();
        }),
      ],
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(5),
                          color: myColor.AppColor.serialActivationPageBg,
                          child: Row(
                            children: [
                              Consumer<refreshCart>(
                                  builder: (context, value, child) {
                                return Badge(
                                  label: Text(
                                      "${new_paused_cart_database.length}"),
                                  offset: Offset(1.5, 0.0),
                                  child: IconButton(
                                    tooltip: "Resume paused transactions",
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(top: 0),
                                    onPressed: () {
                                      if (new_paused_cart_database.length > 0) {
                                        Navigator.of(context).push(
                                            CartHeroDialogRoute(
                                                builder: (context) {
                                                  return resumePausedCart(
                                                    activeUserId: userId,
                                                    cartData: myCart,
                                                  );
                                                },
                                                settings: RouteSettings(
                                                    arguments:
                                                        "attachCustomer")));
                                      }
                                    },
                                    icon: Icon(Icons.pause_circle_filled),
                                    iconSize: 25,
                                  ),
                                );
                              }),
                              Expanded(child: Container()),
                              IconButton(
                                tooltip: "Create Customer",
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(top: 0),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      CheckoutHeroDialogRoute(
                                          builder: (context) {
                                            return createCustomer(
                                              activeUserId: userId,
                                              cartData: myCart,
                                            );
                                          },
                                          settings: RouteSettings(
                                              arguments: "createCustomer")));
                                },
                                icon: Icon(
                                  Icons.person_add,
                                  color: Color.fromARGB(255, 46, 200, 243),
                                ),
                                iconSize: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                tooltip: "Attach a Customer to Cart",
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(top: 0),
                                onPressed: () {
                                  if (myCart.isNotEmpty) {
                                    Navigator.of(context).push(
                                        CartHeroDialogRoute(
                                            builder: (context) {
                                              return attachCustomer(
                                                activeUserId: userId,
                                                cartData: myCart,
                                              );
                                            },
                                            settings: RouteSettings(
                                                arguments: "attachCustomer")));
                                  }
                                },
                                icon: Icon(
                                  Icons.link,
                                  color: Colors.redAccent,
                                ),
                                iconSize: 25,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    Consumer<refreshCart>(builder: (context, value, child) {
                      return Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        color: Color.fromRGBO(140, 157, 176, .4),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Transaction code:",
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text("#$cartTransactionCode",
                                        style: TextStyle(
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 3, 139, 55))),
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                customerAttached != true
                                    ? SizedBox(
                                        child: Icon(
                                            size: 20,
                                            IconData(0xee36,
                                                fontFamily: 'MaterialIcons')),
                                      )
                                    : SizedBox(
                                        child: Icon(
                                            color: activeCustomerColor,
                                            size: 20,
                                            IconData(0xf523,
                                                fontFamily: 'MaterialIcons')),
                                      ),
                                customerAttached != true
                                    ? Text(
                                        "No customer \nattached to cart",
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                          height: 0.8,
                                        ),
                                      )
                                    : Text(
                                        "Customer attached \nto cart",
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                          height: 0.8,
                                          color: myColor.AppColor.darkTheme,
                                        ),
                                      ),
                                SizedBox(width: 15)
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: .5,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Quantity",
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Price per unit",
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Discount",
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: myCart.isEmpty
                                            ? 0
                                            : myCart["cartItems"].length,
                                        itemBuilder: (context, index) {
                                          var cartInstance =
                                              myCart["cartItems"][index];
                                          double total = (cartInstance[
                                                      "pricePerUnit"] *
                                                  cartInstance["quantity"]) -
                                              cartInstance["discount"];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      cartInstance[
                                                          "productName"],
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${cartInstance["quantity"]}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Proxima',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              color: myColor
                                                                  .AppColor
                                                                  .darkTheme),
                                                        ),
                                                        IconButton(
                                                          tooltip:
                                                              "Edit Quantity",
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                CartHeroDialogRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return editProductQuantity(
                                                                        cartData:
                                                                            myCart,
                                                                        activeIndex:
                                                                            index,
                                                                        activeUserId:
                                                                            userId,
                                                                      );
                                                                    },
                                                                    settings: RouteSettings(
                                                                        arguments:
                                                                            "editquantity")));
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    14,
                                                                    178,
                                                                    85),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      "${cartInstance["pricePerUnit"]}",
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      cartInstance["discount"]
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      total.toStringAsFixed(2),
                                                      style: TextStyle(
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: myColor
                                                              .AppColor
                                                              .darkTheme),
                                                    )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.zero,
                                                      child: IconButton(
                                                        tooltip: "Remove Item",
                                                        onPressed: () {
                                                          myCart["cartItems"]
                                                              .remove(
                                                                  cartInstance);
                                                          if (myCart["cartItems"]
                                                                  .length ==
                                                              0) {
                                                            myCart = {};
                                                            cartTransactionCode =
                                                                "";
                                                            customerAttached =
                                                                false;
                                                          }

                                                          context
                                                              .read<
                                                                  refreshCart>()
                                                              .hitRefresh();
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 13,
                                                          color: Color.fromARGB(
                                                              255, 97, 26, 21),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          );
                                        }),
                                  )),
                                ],
                              ),
                            )),
                            Divider(),
                            paymentsTotal(myCart),
                          ],
                        ),
                      ));
                    }),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //the first row on the product side
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: myColor.AppColor.darkTheme,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                userRole == "administrator" ||
                                        userRole == "pseudo-administrator"
                                    ? IconButton(
                                        tooltip: "Go to Admin Dashboard",
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.only(top: 0),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
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
                                        icon: Icon(
                                          Icons.storage,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        iconSize: 28,
                                      )
                                    : Container(),
                                userRole == "administrator" ||
                                        userRole == "pseudo-administrator"
                                    ? SizedBox(
                                        width: 5,
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                                IconButton(
                                  tooltip: "View today's sales report",
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(top: 0),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CartHeroDialogRoute(
                                            builder: (context) {
                                              return viewTodaySales(
                                                activeUserId: userId,
                                                cartData: myCart,
                                              );
                                            },
                                            settings: RouteSettings(
                                                arguments: "viewTodaySales")));
                                  },
                                  icon: Icon(
                                    Icons.description,
                                    color: Colors.white,
                                  ),
                                  iconSize: 28,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  tooltip: "View account sales report",
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(top: 0),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CartHeroDialogRoute(
                                            builder: (context) {
                                              return viewAccountSales(
                                                activeUserId: userId,
                                                cartData: myCart,
                                              );
                                            },
                                            settings: RouteSettings(
                                                arguments:
                                                    "viewAccountSales")));
                                  },
                                  icon: Stack(children: [
                                    Positioned(
                                      top: 12,
                                      left: 14,
                                      child: Icon(
                                        color: Colors.white70,
                                        Icons.warning,
                                        size: 15,
                                      ),
                                    ),
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ]),
                                  iconSize: 28,
                                ),
                                Expanded(flex: 2, child: Container()),
                                SizedBox(
                                  width: 150,
                                  child: Consumer<displayProducts>(
                                      builder: (context, myvalue, child) {
                                    return TextFormField(
                                      controller: searchEditingController,
                                      onChanged: (value) {
                                        searchedResponse = searchedProducts(
                                            new_category_database,
                                            new_product_database,
                                            value);
                                        context
                                            .read<displayProducts>()
                                            .changeTypeOfDisplay("search");
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        //border: InputBorder.none,
                                        hintText: 'Search by name...',
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 11),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Consumer<displayProducts>(
                                      builder: (context, myvalue, child) {
                                    return DropdownButtonFormField(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                      ),
                                      value: "all",
                                      items: catDropItems.map((e) {
                                        return DropdownMenuItem(
                                          value: e["categoryId"],
                                          child: Text(
                                            e["categoryName"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        context
                                            .read<displayProducts>()
                                            .changeTypeOfDisplay(
                                                value.toString());
                                      },
                                    );
                                  }),
                                ),
                                Expanded(flex: 2, child: Container()),
                                PopupMenuButton(
                                  offset: Offset(0, 46.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  icon: Row(
                                    children: [
                                      Icon(
                                        const IconData(0xe043,
                                            fontFamily: 'MaterialIcons'),
                                        size: 25,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      getCashierNames(
                                          new_user_database, userId),
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
                                      for (var userInst in new_user_database) {
                                        if (userInst["userId"] == userId) {
                                          userInfo = userInst;
                                        }
                                      }
                                      if (userInfo.isNotEmpty) {
                                        Navigator.of(context).push(
                                            ViewHeroDialogRoute(
                                                builder: (context) {
                                                  return editMyProfile(
                                                      currentUserId: userId,
                                                      firstName: userInfo[
                                                              "userDetails"]
                                                          ["firstName"],
                                                      lastName: userInfo[
                                                              "userDetails"]
                                                          ["lastName"],
                                                      userId:
                                                          userInfo["userId"],
                                                      phoneNumber:
                                                          userInfo["userDetails"]
                                                              ["phoneNumber"],
                                                      encryptedPass:
                                                          userInfo["userDetails"]
                                                              ["password"],
                                                      dateUpdated: userInfo[
                                                              "userDetails"]
                                                          ["last_updated_on"],
                                                      userRole:
                                                          userInfo["userDetails"]
                                                              ["role"]);
                                                },
                                                settings: RouteSettings(
                                                    arguments: "viewUser")));
                                      }
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          padding: EdgeInsets.only(
                                              right: 50, left: 20),
                                          value: 'Myprofile',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: myColor.AppColor
                                                            .darkTheme),
                                                  ),
                                                ],
                                              ),
                                              Divider()
                                            ],
                                          )),
                                      PopupMenuItem(
                                          padding: EdgeInsets.only(
                                              right: 50, left: 20),
                                          value: 'logout',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'Proxima',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                ],
                                              ),
                                              Divider()
                                            ],
                                          )),
                                    ];
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    //End of the first row on the product side
                    Expanded(
                      //product contents go here
                      child: Consumer<displayProducts>(
                          builder: (context, value, child) {
                        //print(value.typeOfDisplay);
                        List<Map<String, dynamic>> processedProducts = [];
                        if (value.typeOfDisplay == "all") {
                          processedProducts = productToDisplay;
                        } else if (value.typeOfDisplay == "search") {
                          processedProducts = searchedResponse;
                        } else {
                          processedProducts = filteredCategory(
                              new_category_database,
                              new_product_database,
                              value.typeOfDisplay);
                        }
                        //value.typeOfDisplay == "all"
                        //? processedProducts = productToDisplay
                        // : processedProducts = filteredCategory(
                        //  new_category_database,
                        //  new_product_database,
                        // value.typeOfDisplay);
                        return Container(
                          //color: Colors.blue,
                          child: processedProducts.isEmpty != true
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: processedProducts.length,
                                  itemBuilder: (context, index) {
                                    var categoryProduct =
                                        processedProducts[index];
                                    var relevantProds =
                                        categoryProduct["categoryProducts"];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      //height: 300,
                                      //color: Colors.blue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            categoryProduct["categoryName"],
                                            style: TextStyle(
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: index % 2 == 0
                                                    ? Color.fromARGB(
                                                        255, 6, 107, 31)
                                                    : Color.fromARGB(
                                                        255, 5, 39, 150)),
                                          ),
                                          SizedBox(height: 10),
                                          GridView.count(
                                            padding: EdgeInsets.only(top: 10),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 6,
                                            //padding: EdgeInsets.all(10),
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            children: relevantProds
                                                .map<Widget>(
                                                  (productItem) => Column(
                                                    children: [
                                                      IconButton(
                                                        tooltip: productItem[
                                                            "productName"],
                                                        onPressed: () {
                                                          if (myCart.isEmpty) {
                                                            myCart["cartId"] =
                                                                "CS${generateId()}";
                                                            myCart["customerId"] =
                                                                "_";
                                                            myCart["cartItems"] =
                                                                cartItems;
                                                            Map<String, dynamic>
                                                                itemDetails =
                                                                {};
                                                            itemDetails[
                                                                    "productId"] =
                                                                productItem[
                                                                    "productId"];
                                                            itemDetails[
                                                                    "productName"] =
                                                                productItem[
                                                                    "productName"];
                                                            itemDetails[
                                                                    "quantity"] =
                                                                1.00;
                                                            itemDetails[
                                                                    "unitOfMeasurement"] =
                                                                productItem[
                                                                    "unitOfMeasurement"];
                                                            itemDetails[
                                                                    "pricePerUnit"] =
                                                                double.parse(
                                                                    productItem[
                                                                        "retailPrice"]);
                                                            if (productItem[
                                                                    "discountType"] ==
                                                                "percentage") {
                                                              double discAmnt = (double.parse(
                                                                          productItem[
                                                                              "recommendedDiscount"]) /
                                                                      100) *
                                                                  double.parse(
                                                                      productItem[
                                                                          "retailPrice"]);
                                                              itemDetails[
                                                                      "discount"] =
                                                                  discAmnt;
                                                            } else {
                                                              itemDetails[
                                                                      "discount"] =
                                                                  double.parse(
                                                                      productItem[
                                                                          "recommendedDiscount"]);
                                                            }

                                                            myCart["cartItems"]
                                                                .add(
                                                                    itemDetails);
                                                          } else {
                                                            bool
                                                                productAlreadyIn =
                                                                false;
                                                            int indexFound = 0;
                                                            for (var oneCart
                                                                in myCart[
                                                                    "cartItems"]) {
                                                              if (oneCart[
                                                                      "productId"] ==
                                                                  productItem[
                                                                      "productId"]) {
                                                                productAlreadyIn =
                                                                    true;
                                                                break;
                                                              }
                                                              indexFound += 1;
                                                            }
                                                            if (productAlreadyIn) {
                                                              myCart["cartItems"]
                                                                      [
                                                                      indexFound]
                                                                  [
                                                                  "quantity"] += 1.00;
                                                              //
                                                              if (productItem[
                                                                      "discountType"] ==
                                                                  "percentage") {
                                                                double discAmnt = (double.parse(productItem[
                                                                            "recommendedDiscount"]) /
                                                                        100) *
                                                                    double.parse(
                                                                        productItem[
                                                                            "retailPrice"]);
                                                                myCart["cartItems"]
                                                                            [
                                                                            indexFound]
                                                                        [
                                                                        "discount"] +=
                                                                    discAmnt;
                                                              } else {
                                                                myCart["cartItems"]
                                                                            [
                                                                            indexFound]
                                                                        [
                                                                        "discount"] +=
                                                                    double.parse(
                                                                        productItem[
                                                                            "recommendedDiscount"]);
                                                              }
                                                              //
                                                            } else {
                                                              Map<String,
                                                                      dynamic>
                                                                  itemDetails =
                                                                  {};
                                                              itemDetails[
                                                                      "productId"] =
                                                                  productItem[
                                                                      "productId"];
                                                              itemDetails[
                                                                      "productName"] =
                                                                  productItem[
                                                                      "productName"];
                                                              itemDetails[
                                                                      "quantity"] =
                                                                  1.00;
                                                              itemDetails[
                                                                      "unitOfMeasurement"] =
                                                                  productItem[
                                                                      "unitOfMeasurement"];
                                                              itemDetails[
                                                                      "pricePerUnit"] =
                                                                  double.parse(
                                                                      productItem[
                                                                          "retailPrice"]);
                                                              if (productItem[
                                                                      "discountType"] ==
                                                                  "percentage") {
                                                                double discAmnt = (double.parse(productItem[
                                                                            "recommendedDiscount"]) /
                                                                        100) *
                                                                    double.parse(
                                                                        productItem[
                                                                            "retailPrice"]);
                                                                itemDetails[
                                                                        "discount"] =
                                                                    discAmnt;
                                                              } else {
                                                                itemDetails[
                                                                        "discount"] =
                                                                    double.parse(
                                                                        productItem[
                                                                            "recommendedDiscount"]);
                                                              }
                                                              myCart["cartItems"]
                                                                  .add(
                                                                      itemDetails);
                                                            }
                                                          }
                                                          cartTransactionCode =
                                                              myCart["cartId"];
                                                          context
                                                              .read<
                                                                  refreshCart>()
                                                              .hitRefresh();
                                                          //print(myCart);
                                                        },
                                                        icon: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: index % 2 ==
                                                                    0
                                                                ? Color(
                                                                    0xFF203D7B)
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        6,
                                                                        107,
                                                                        31),
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .shopping_basket,
                                                            size: 35,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        productItem[
                                                            "productName"],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Proxima',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 9,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255, 0, 0, 0)),
                                                      )
                                                    ],
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Text(
                                          "No products avalaible!",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        );
                      }),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      height: 95,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  tooltip: "Cash Payments",
                                  onPressed: () {
                                    double cartTotalAmountDue =
                                        getTotal(myCart);
                                    if (cartTotalAmountDue > 0) {
                                      Navigator.of(context).push(
                                          CheckoutHeroDialogRoute(
                                              builder: (context) {
                                                return cashCheckout(
                                                  cartData: myCart,
                                                  //activeIndex: index,
                                                  activeUserId: userId,
                                                );
                                              },
                                              settings: RouteSettings(
                                                  arguments: "cashCheckout")));
                                    }
                                  },
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: myColor.AppColor.darkTheme,
                                    ),
                                    child: Icon(
                                      Icons.monetization_on,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Cash Checkout",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  tooltip: "Mpesa Payments",
                                  onPressed: () {
                                    double cartTotalAmountDue =
                                        getTotal(myCart);
                                    if (cartTotalAmountDue > 0) {
                                      Navigator.of(context).push(
                                          CheckoutHeroDialogRoute(
                                              builder: (context) {
                                                return mpesaCheckout(
                                                  cartData: myCart,
                                                  //activeIndex: index,
                                                  activeUserId: userId,
                                                );
                                              },
                                              settings: RouteSettings(
                                                  arguments: "mpesaCheckout")));
                                    }
                                  },
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: myColor.AppColor.darkTheme,
                                    ),
                                    child: Icon(
                                      Icons.phone_android,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Mpesa Checkout",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9,
                                      color: myColor.AppColor.darkTheme),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  tooltip: "Give goods on credit",
                                  onPressed: () {
                                    if (customerAttached) {
                                      Navigator.of(context).push(
                                          CheckoutHeroDialogRoute(
                                              builder: (context) {
                                                return creditCheckout(
                                                  cartData: myCart,
                                                  //activeIndex: index,
                                                  activeUserId: userId,
                                                );
                                              },
                                              settings: RouteSettings(
                                                  arguments:
                                                      "creditCheckout")));
                                    } else {
                                      if (myCart.isNotEmpty) {
                                        Navigator.of(context).push(
                                            CartHeroDialogRoute(
                                                builder: (context) {
                                                  return attachCustomer(
                                                    activeUserId: userId,
                                                    cartData: myCart,
                                                  );
                                                },
                                                settings: RouteSettings(
                                                    arguments:
                                                        "attachCustomer")));
                                      }
                                    }
                                  },
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: myColor.AppColor.darkTheme,
                                    ),
                                    child: Icon(
                                      Icons.hourglass_empty,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Checkout on Credit",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                )
                              ],
                            ),
                            Consumer<refreshCart>(
                                builder: (context, value, child) {
                              return Column(
                                children: [
                                  IconButton(
                                    tooltip: "Pause Transaction",
                                    onPressed: () async {
                                      if (myCart.isNotEmpty) {
                                        new_paused_cart_database.add(myCart);
                                        myCart = {};
                                        cartItems = [];
                                        cartTransactionCode = "";
                                        customerAttached = false;
                                        await pausedCartDetailsPreference
                                            .setPausedCartData(
                                                new_paused_cart_database);
                                        context
                                            .read<refreshCart>()
                                            .hitRefresh();
                                      }
                                    },
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: myColor.AppColor.darkTheme,
                                      ),
                                      child: Icon(
                                        Icons.pause,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Hold Order",
                                    style: TextStyle(
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 9,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                                  )
                                ],
                              );
                            }),
                            Column(
                              children: [
                                IconButton(
                                  tooltip: "Check Cash Count",
                                  onPressed: () {},
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: myColor.AppColor.darkTheme,
                                    ),
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Cash Count",
                                  style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                )
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:intl/intl.dart';
import 'package:midusa_pos/local_database/product_utils.dart';
import 'package:midusa_pos/local_database/supplier_utils.dart';
import 'package:midusa_pos/local_database/notifications_utils.dart';
import 'package:midusa_pos/local_database/category_utils.dart';

Map<String, dynamic> saveUserDetails(
    String userId,
    String firstName,
    String lastName,
    String phoneNumber,
    String userRole,
    String encryptedPasssword,
    String dateCreated,
    String dateUpdated) {
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> overalDetails = {};
  userDetails["firstName"] = firstName;
  userDetails["lastName"] = lastName;
  userDetails["phoneNumber"] = phoneNumber;
  userDetails["role"] = userRole;
  userDetails["password"] = encryptedPasssword;
  userDetails["created_on"] = dateCreated;
  userDetails["last_updated_on"] = dateUpdated;
  overalDetails["userId"] = userId;
  overalDetails["userDetails"] = userDetails;
  return overalDetails;
}

Future<void> saveNotificationDetails() async {
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_notification_database =
      notificationDetailsPreference.getNotificationData() ?? [];
  DateTime currentDate = DateTime.now();
  new_product_database.forEach((element) {
    bool expiryDateReached = false;
    bool notificationForToday = false;
    if (element["expiryStatus"] == "yes") {
      String dateOfExpiry = element["expiryDate"];
      DateTime storedDate = DateFormat('dd/MM/yyyy').parse(dateOfExpiry);
      expiryDateReached = currentDate.isAfter(storedDate) ||
          currentDate.isAtSameMomentAs(storedDate);
    }
    new_notification_database.forEach((notification) {
      if (notification["notificationId"] == element["productId"]) {
        DateTime notificationDate =
            DateFormat('dd/MM/yyyy').parse(notification["createdOn"]);
        if (notificationDate.day == currentDate.day &&
            notificationDate.month == currentDate.month &&
            notificationDate.year == currentDate.year) {
          notificationForToday = true;
        }
      }
    });
    if (expiryDateReached == true && notificationForToday == false) {
      Map<String, dynamic> notificationDetails = {};
      String formattedDateTime =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(currentDate);
      notificationDetails["notificationId"] = element["productId"];
      notificationDetails["createdOn"] = formattedDateTime;
      notificationDetails["body"] =
          "${element["productName"]} has expired. Please restock. Note that expired products will not be visible on the Point of Sale";
      notificationDetails["read"] = "no";
      new_notification_database.add(notificationDetails);
    } //end if expiryDateReached
    if (notificationForToday == false &&
        double.parse(element["quantity"]) <
            double.parse(element["minimumQuantity"])) {
      Map<String, dynamic> notificationDetails = {};
      String formattedDateTime =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(currentDate);
      notificationDetails["notificationId"] = element["productId"];
      notificationDetails["createdOn"] = formattedDateTime;
      notificationDetails["body"] =
          "${element["productName"]} is out of stock. Please restock. Note that products that are out of stock will not be visible on the Point of Sale";
      notificationDetails["read"] = "no";
      new_notification_database.add(notificationDetails);
    }
  });
  new_notification_database
      .sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
  if (new_notification_database.length > 50) {
    new_notification_database.removeRange(new_notification_database.length - 30,
        new_notification_database.length);
  }
  await notificationDetailsPreference
      .setNotificationData(new_notification_database);
}

Future<void> updateNotificationDetails() async {
  List<Map<String, dynamic>> new_notification_database =
      notificationDetailsPreference.getNotificationData() ?? [];
  new_notification_database.forEach((notification) {
    if (notification["read"] == "no") {
      notification["read"] = "yes";
    }
  });
  await notificationDetailsPreference
      .setNotificationData(new_notification_database);
}

//Future<void> saveMessageDetails(String messageBody, String itemId) async {
//List<Map<String, dynamic>> new_message_database =
// messageDetailsPreference.getMessageData() ?? [];
//Map<String, dynamic> messageDetails = {};
//DateTime currentDate = DateTime.now();
//String formattedDateTime =
//DateFormat('dd/MM/yyyy HH:mm:ss').format(currentDate);
// messageDetails["createdOn"] = formattedDateTime;
// messageDetails["body"] = messageBody;
// messageDetails["read"] = "no";
//new_message_database.add(messageDetails);
//new_message_database.sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
//if (new_message_database.length > 50) {
// new_message_database.removeRange(
// new_message_database.length - 30, new_message_database.length);
// await messageDetailsPreference.setMessageData(new_message_database);
//}
//}

Map<String, dynamic> createNewCustomer(
    String customerId,
    String firstName,
    String lastName,
    String phoneNumber,
    String createdBy,
    String dateCreated,
    String dateUpdated) {
  Map<String, dynamic> customerDetails = {};
  customerDetails["customerId"] = customerId;
  customerDetails["firstName"] = firstName;
  customerDetails["lastName"] = lastName;
  customerDetails["phoneNumber"] = phoneNumber;
  customerDetails["createdBy"] = createdBy;
  customerDetails["createdOn"] = dateCreated;
  customerDetails["lastUpdatedOn"] = dateUpdated;
  return customerDetails;
}

Map<String, dynamic> saveSaleDetails(
  String saleId,
  List<Map<String, dynamic>> cartItems,
  String customerId,
  String amountTotal,
  String transactionDate,
  String lastUpdatedDate, //new one
  String servedBy,
  String cashReceived,
  String cashReturned,
  String checkoutMethod,
  String settlementStatus, //new one
  String creditDue, //new one
) {
  Map<String, dynamic> saleDetails = {};
  saleDetails["saleId"] = saleId;
  saleDetails["cartDetails"] = cartItems;
  saleDetails["customerId"] = customerId;
  saleDetails["amountTotal"] = amountTotal;
  saleDetails["transactionDate"] = transactionDate;
  saleDetails["lastUpdatedOn"] = lastUpdatedDate;
  saleDetails["servedBy"] = servedBy;
  saleDetails["cashReceived"] = cashReceived;
  saleDetails["cashReturned"] = cashReturned;
  saleDetails["checkoutMethod"] = checkoutMethod;
  saleDetails["settlementStatus"] = settlementStatus;
  saleDetails["creditDue"] = creditDue;
  return saleDetails;
}

Map<String, dynamic> saveCategoryDetails(
    String categoryId,
    String categoryName,
    String categoryDescription,
    String createdBy,
    String createdOn,
    String lastUpdatedOn) {
  Map<String, dynamic> categoryDetails = {};
  categoryDetails["categoryId"] = categoryId;
  categoryDetails["categoryName"] = categoryName;
  categoryDetails["categoryDescription"] = categoryDescription;
  categoryDetails["createdBy"] = createdBy;
  categoryDetails["createdOn"] = createdOn;
  categoryDetails["lastUpdatedOn"] = lastUpdatedOn;
  return categoryDetails;
}

Map<String, dynamic> saveProductDetails(
    String productId,
    String productName,
    String categoryId,
    String supplierId,
    String stockPrice,
    String unitOfMeasurement,
    String quantity,
    String minimumQuantity,
    String retailPrice,
    String expiryStatus,
    String expiryDate,
    String discountType,
    String recommendedDiscount,
    // String supplierPaymentStatus,
    String createdBy,
    String createdOn,
    String lastUpdatedOn) {
  Map<String, dynamic> productDetails = {};
  productDetails["productId"] = productId;
  productDetails["productName"] = productName;
  productDetails["categoryId"] = categoryId;
  productDetails["supplierId"] = supplierId;
  productDetails["stockPrice"] = stockPrice;
  productDetails["unitOfMeasurement"] = unitOfMeasurement;
  productDetails["quantity"] = quantity;
  productDetails["minimumQuantity"] = minimumQuantity;
  productDetails["retailPrice"] = retailPrice;
  productDetails["expiryStatus"] = expiryStatus;
  productDetails["expiryDate"] = expiryDate;
  productDetails["discountType"] = discountType;
  productDetails["recommendedDiscount"] = recommendedDiscount;
  //productDetails["supplierPaymentStatus"] = supplierPaymentStatus;
  productDetails["createdBy"] = createdBy;
  productDetails["createdOn"] = createdOn;
  productDetails["lastUpdatedOn"] = lastUpdatedOn;
  return productDetails;
}

Map<String, dynamic> createStockPurchaseInventory(
  String productId,
  String quantity,
  String stockPrice,
  String lastUpdatedOn,

  //Map<String, dynamic> productDetails,
) {
  Map<String, dynamic> productInventory = {};
  productInventory["productId"] = productId;
  productInventory["lastUpdatedOn"] = lastUpdatedOn;
  productInventory["totalPurchasedQuantity"] = quantity;
  productInventory["totalPurchasedAmount"] = stockPrice;
  return productInventory;
}

Map<String, dynamic> saveSupplierDetails(
    String supplierId,
    String supplierName,
    String phoneNumber,
    String emailAddress,
    String description,
    String createdBy,
    String createdOn,
    String lastUpdatedOn) {
  Map<String, dynamic> supplierDetails = {};
  supplierDetails["supplierId"] = supplierName;
  supplierDetails["supplierName"] = supplierName;
  supplierDetails["phoneNumber"] = phoneNumber;
  supplierDetails["emailAddress"] = emailAddress;
  supplierDetails["description"] = description;
  supplierDetails["createdBy"] = createdBy;
  supplierDetails["createdOn"] = createdOn;
  supplierDetails["lastUpdatedOn"] = lastUpdatedOn;
  return supplierDetails;
}

String generateId() {
  return "${DateTime.now().year.toString()}${DateTime.now().day.toString()}${DateTime.now().second.toString()}${DateTime.now().millisecond.toString()}";
}

String generateEncryptionKey(String userId, String firstName, String phone) {
  return "${userId}${firstName.trim().toUpperCase()}${phone.trim()}${userId}${firstName.trim().toUpperCase()}${phone.trim()}";
}

String roleFormatter(String theRole) {
  if (theRole == "pseudo-administrator") {
    return ("Administrator");
  }
  if (theRole == "cashier") {
    return ("Cashier");
  }
  return ("Super Administrator");
}

void itemsToBeDeleted(String allOrOne, String itemId, bool itemSelected,
    deletedElements, List<Map<String, dynamic>> allItems) {
  String tempId;
  if (allOrOne == "all") {
    if (itemSelected) {
      for (int i = 0; i < allItems.length; i++) {
        tempId = allItems[i]["userId"];
        if (!deletedElements.contains(tempId)) {
          deletedElements.add(tempId);
        }
      }
    } else {
      deletedElements.clear();
    }
  } else {
    if (itemSelected) {
      if (deletedElements.isNotEmpty) {
        if (!deletedElements.contains(itemId)) {
          deletedElements.add(itemId);
        }
      } else {
        deletedElements.add(itemId);
      }
    } else {
      if (deletedElements.isNotEmpty) {
        if (deletedElements.contains(itemId)) {
          deletedElements.remove(itemId);
        }
      }
    }
  }

  // return deletedElements;
}

List<Map<String, dynamic>> createDropItems(
    String typeAct, String initialVal, String initialDisp, listToProcess) {
  Map<String, dynamic> finalVals = {};
  if (typeAct == "category") {
    finalVals["categoryId"] = initialVal;
    finalVals["categoryName"] = initialDisp;
    listToProcess.add(finalVals);
  }

  if (typeAct == "supplier") {
    finalVals["supplierId"] = initialVal;
    finalVals["supplierName"] = initialDisp;
    listToProcess.add(finalVals);
  }

  return listToProcess;
}

List<Map<String, dynamic>> createUserLoginDrop(userData) {
  List<Map<String, dynamic>> processedList = [];
  Map<String, dynamic> finalVals = {};
  finalVals["userId"] = "not selected";
  finalVals["userName"] = "Select account";
  processedList.add(finalVals);
  userData.forEach((element) {
    finalVals = {};
    finalVals["userId"] = element["userId"];
    finalVals["userName"] =
        "${element["userDetails"]["firstName"]} (${roleFormatter(element["userDetails"]["role"])})";
    processedList.add(finalVals);
  });
  return processedList;
}

List<Map<String, dynamic>> productCategoryResponse(
    categoryDatabase, productDatabase) {
  List<Map<String, dynamic>> sortedResponse = [];
  List<Map<String, dynamic>> listOfProds = [];
  //Map<String, dynamic> catSorted = {};
  Map<String, dynamic> prodSorted = {};
  productDatabase.forEach((element) {
    String productCount = element["quantity"];
    bool expiryDateReached = false;
    if (element["expiryStatus"] == "yes") {
      String dateOfExpiry = element["expiryDate"];
      DateTime storedDate = DateFormat('dd/MM/yyyy').parse(dateOfExpiry);
      DateTime currentDate = DateTime.now();
      expiryDateReached = currentDate.isAfter(storedDate) ||
          currentDate.isAtSameMomentAs(storedDate);
    }
    if (double.parse(productCount) > 0 && expiryDateReached == false) {
      prodSorted = {};
      listOfProds = [];
      String discProd = element["recommendedDiscount"];
      prodSorted["productId"] = element["productId"];
      prodSorted["productName"] = element["productName"];
      prodSorted["retailPrice"] = element["retailPrice"];
      prodSorted["unitOfMeasurement"] = element["unitOfMeasurement"];
      if (discProd != "_" && double.parse(discProd) >= 0) {
        prodSorted["recommendedDiscount"] = discProd;
      } else {
        prodSorted["recommendedDiscount"] = "0.00";
      }
      prodSorted["discountType"] = element["discountType"];
      //}
      //adding category data
      String catId = element["categoryId"];
      bool isItemFound = false;
      for (Map<String, dynamic> catSorted in sortedResponse) {
        if (catSorted.values.contains(catId)) {
          isItemFound = true;
          break;
        }
      }

      if (isItemFound) {
        int indexMonitor = 0;
        for (Map<String, dynamic> catSorted in sortedResponse) {
          if (catSorted["categoryId"] == catId) {
            sortedResponse[indexMonitor]["categoryProducts"].add(prodSorted);
            break;
          }
          indexMonitor++;
        }
      } else {
        Map<String, dynamic> catDataContainer = {};
        catDataContainer["categoryId"] = catId;
        String nameOfCat = "_";
        for (Map<String, dynamic> myCatItem in categoryDatabase) {
          if (myCatItem["categoryId"] == catId) {
            nameOfCat = myCatItem["categoryName"];
            break;
          }
        }
        catDataContainer["categoryName"] = nameOfCat;
        listOfProds.add(prodSorted);
        catDataContainer["categoryProducts"] = listOfProds;
        sortedResponse.add(catDataContainer);
      }
    }
  });
  //print(sortedResponse.length);
  //print(sortedResponse);
  return sortedResponse;
}

List<Map<String, dynamic>> filteredCategory(
    categoryDatabase, productDatabase, String catIdToFilter) {
  List<Map<String, dynamic>> sortedResponse = [];
  List<Map<String, dynamic>> listOfProds = [];
  //print(catIdToFilter);
  Map<String, dynamic> prodSorted = {};
  productDatabase.forEach((element) {
    String productCount = element["quantity"];
    bool expiryDateReached = false;
    if (element["expiryStatus"] == "yes") {
      String dateOfExpiry = element["expiryDate"];
      DateTime storedDate = DateFormat('dd/MM/yyyy').parse(dateOfExpiry);
      DateTime currentDate = DateTime.now();
      expiryDateReached = currentDate.isAfter(storedDate) ||
          currentDate.isAtSameMomentAs(storedDate);
    }
    //print("hey ${element["categoryId"]}");
    if (double.parse(productCount) > 0 &&
        expiryDateReached == false &&
        element["categoryId"] == catIdToFilter) {
      prodSorted = {};
      //listOfProds = [];
      String discProd = element["recommendedDiscount"];
      prodSorted["productId"] = element["productId"];
      prodSorted["productName"] = element["productName"];
      prodSorted["retailPrice"] = element["retailPrice"];
      prodSorted["unitOfMeasurement"] = element["unitOfMeasurement"];
      if (discProd != "_" && double.parse(discProd) >= 0) {
        prodSorted["recommendedDiscount"] = discProd;
      } else {
        prodSorted["recommendedDiscount"] = "0.00";
      }
      prodSorted["discountType"] = element["discountType"];
      listOfProds.add(prodSorted);
      //print(prodSorted);
    }
  });
  String nameOfCat = "_";
  if (catIdToFilter == "_") {
    Map<String, dynamic> catDataContainer = {};
    catDataContainer["categoryName"] = nameOfCat;
    catDataContainer["categoryProducts"] = listOfProds;
    sortedResponse.add(catDataContainer);
  } else {
    Map<String, dynamic> catDataContainer = {};
    catDataContainer["categoryId"] = catIdToFilter;
    for (Map<String, dynamic> myCatItem in categoryDatabase) {
      //print(catIdToFilter);
      //print(myCatItem["categoryId"]);
      //print("hey $catIdToFilter");
      if (myCatItem["categoryId"] == catIdToFilter) {
        //print("yess");
        nameOfCat = myCatItem["categoryName"];
        catDataContainer["categoryName"] = nameOfCat;
        catDataContainer["categoryProducts"] = listOfProds;
        sortedResponse.add(catDataContainer);
        break;
      }
    }
  }

  //print(sortedResponse);
  return sortedResponse;
}

List<Map<String, dynamic>> posDropItems(
    String initialVal, String initialDisp, listToProcess) {
  Map<String, dynamic> finalVals = {};
  List<Map<String, dynamic>> containerList = [];
  finalVals["categoryId"] = initialVal;
  finalVals["categoryName"] = initialDisp;
  containerList.add(finalVals);
  for (var catData in listToProcess) {
    finalVals = {};
    finalVals["categoryId"] = catData["categoryId"];
    finalVals["categoryName"] = catData["categoryName"];
    containerList.add(finalVals);
  }

  return containerList;
}

List<Map<String, dynamic>> searchedProducts(
    categoryDatabase, productDatabase, String phraseToSearch) {
  List<Map<String, dynamic>> sortedResponse = [];
  List<Map<String, dynamic>> listOfProds = [];
  //Map<String, dynamic> catSorted = {};
  Map<String, dynamic> prodSorted = {};
  productDatabase.forEach((element) {
    String productCount = element["quantity"];
    bool expiryDateReached = false;
    if (element["expiryStatus"] == "yes") {
      String dateOfExpiry = element["expiryDate"];
      DateTime storedDate = DateFormat('dd/MM/yyyy').parse(dateOfExpiry);
      DateTime currentDate = DateTime.now();
      expiryDateReached = currentDate.isAfter(storedDate) ||
          currentDate.isAtSameMomentAs(storedDate);
    }
    if (double.parse(productCount) > 0 &&
        expiryDateReached == false &&
        element["productName"]
            .toLowerCase()
            .contains(phraseToSearch.toLowerCase())) {
      prodSorted = {};
      listOfProds = [];
      String discProd = element["recommendedDiscount"];
      prodSorted["productId"] = element["productId"];
      prodSorted["productName"] = element["productName"];
      prodSorted["retailPrice"] = element["retailPrice"];
      prodSorted["unitOfMeasurement"] = element["unitOfMeasurement"];
      if (discProd != "_" && double.parse(discProd) >= 0) {
        prodSorted["recommendedDiscount"] = discProd;
      } else {
        prodSorted["recommendedDiscount"] = "0.00";
      }
      prodSorted["discountType"] = element["discountType"];
      //}
      //adding category data
      String catId = element["categoryId"];
      bool isItemFound = false;
      for (Map<String, dynamic> catSorted in sortedResponse) {
        if (catSorted.values.contains(catId)) {
          isItemFound = true;
          break;
        }
      }

      if (isItemFound) {
        int indexMonitor = 0;
        for (Map<String, dynamic> catSorted in sortedResponse) {
          if (catSorted["categoryId"] == catId) {
            sortedResponse[indexMonitor]["categoryProducts"].add(prodSorted);
            break;
          }
          indexMonitor++;
        }
      } else {
        Map<String, dynamic> catDataContainer = {};
        catDataContainer["categoryId"] = catId;
        String nameOfCat = "_";
        for (Map<String, dynamic> myCatItem in categoryDatabase) {
          if (myCatItem["categoryId"] == catId) {
            nameOfCat = myCatItem["categoryName"];
            break;
          }
        }
        catDataContainer["categoryName"] = nameOfCat;
        listOfProds.add(prodSorted);
        catDataContainer["categoryProducts"] = listOfProds;
        sortedResponse.add(catDataContainer);
      }
    }
  });
  //print(sortedResponse.length);
  //print(sortedResponse);
  return sortedResponse;
}

List<Map<String, dynamic>> searchedCustomer(
    customerDatabase, String numberToSearch) {
  List<Map<String, dynamic>> searchedResponse = [];
  customerDatabase.forEach((element) {
    String customerPhone = element["phoneNumber"];
    if (customerPhone.contains(numberToSearch)) {
      searchedResponse.add(element);
    }
  });
  return searchedResponse;
}

List<Map<String, dynamic>> searchedUser(userDatabase, String phraseToSearch) {
  List<Map<String, dynamic>> searchedResponse = [];
  userDatabase.forEach((element) {
    String userFullName =
        '${element["userDetails"]["firstName"].toLowerCase()} ${element["userDetails"]["lastName"].toLowerCase()}';
    if (userFullName.contains(phraseToSearch.toLowerCase())) {
      searchedResponse.add(element);
    }
  });
  return searchedResponse;
}

List<Map<String, dynamic>> searchedProduct(
    productDatabase, String phraseToSearch) {
  List<Map<String, dynamic>> searchedResponse = [];
  productDatabase.forEach((element) {
    String productName = element["productName"].toLowerCase();
    if (productName.contains(phraseToSearch.toLowerCase())) {
      searchedResponse.add(element);
    }
  });
  return searchedResponse;
}

List<Map<String, dynamic>> searchedCategory(
    categoryDatabase, String phraseToSearch) {
  List<Map<String, dynamic>> searchedResponse = [];
  categoryDatabase.forEach((element) {
    String categoryName = element["categoryName"].toLowerCase();
    if (categoryName.contains(phraseToSearch.toLowerCase())) {
      searchedResponse.add(element);
    }
  });
  return searchedResponse;
}

List<Map<String, dynamic>> searchedSupplier(
    supplierDatabase, String phraseToSearch) {
  List<Map<String, dynamic>> searchedResponse = [];
  supplierDatabase.forEach((element) {
    String supplierName = element["supplierName"].toLowerCase();
    if (supplierName.contains(phraseToSearch.toLowerCase())) {
      searchedResponse.add(element);
    }
  });
  return searchedResponse;
}

double getSubTotal(cartToProcess) {
  double sub_total = 0.00;
  if (cartToProcess.isNotEmpty) {
    var cartItems = cartToProcess["cartItems"];
    cartItems.forEach((element) {
      sub_total += element["quantity"] * element["pricePerUnit"];
    });
  }

  return double.parse(sub_total.toStringAsFixed(2));
}

double getDiscount(cartToProcess) {
  double discount_total = 0.00;
  if (cartToProcess.isNotEmpty) {
    var cartItems = cartToProcess["cartItems"];
    cartItems.forEach((element) {
      discount_total += element["discount"];
    });
  }

  return double.parse(discount_total.toStringAsFixed(2));
}

double getTotal(cartToProcess) {
  double total = getSubTotal(cartToProcess) - getDiscount(cartToProcess);
  return total.ceilToDouble();
}

String getUserRole(userDatabase, idToLook) {
  String role = "";
  for (var userData in userDatabase) {
    if (userData["userId"] == idToLook) {
      role = userData["userDetails"]["role"];
      break;
    }
  }
  return role;
}

void productsToBeDeleted(String allOrOne, String itemId, bool itemSelected,
    deletedElements, List<Map<String, dynamic>> allItems) {
  String tempId;
  if (allOrOne == "all") {
    if (itemSelected) {
      for (int i = 0; i < allItems.length; i++) {
        tempId = allItems[i]["productId"];
        if (!deletedElements.contains(tempId)) {
          deletedElements.add(tempId);
        }
      }
    } else {
      deletedElements.clear();
    }
  } else {
    if (itemSelected) {
      if (deletedElements.isNotEmpty) {
        if (!deletedElements.contains(itemId)) {
          deletedElements.add(itemId);
        }
      } else {
        deletedElements.add(itemId);
      }
    } else {
      if (deletedElements.isNotEmpty) {
        if (deletedElements.contains(itemId)) {
          deletedElements.remove(itemId);
        }
      }
    }
  }

  // return deletedElements;
}

void categoriesToBeDeleted(String allOrOne, String itemId, bool itemSelected,
    deletedElements, List<Map<String, dynamic>> allItems) {
  String tempId;
  if (allOrOne == "all") {
    if (itemSelected) {
      for (int i = 0; i < allItems.length; i++) {
        tempId = allItems[i]["categoryId"];
        if (!deletedElements.contains(tempId)) {
          deletedElements.add(tempId);
        }
      }
    } else {
      deletedElements.clear();
    }
  } else {
    if (itemSelected) {
      if (deletedElements.isNotEmpty) {
        if (!deletedElements.contains(itemId)) {
          deletedElements.add(itemId);
        }
      } else {
        deletedElements.add(itemId);
      }
    } else {
      if (deletedElements.isNotEmpty) {
        if (deletedElements.contains(itemId)) {
          deletedElements.remove(itemId);
        }
      }
    }
  }

  // return deletedElements;
}

void suppliersToBeDeleted(String allOrOne, String itemId, bool itemSelected,
    deletedElements, List<Map<String, dynamic>> allItems) {
  String tempId;
  if (allOrOne == "all") {
    if (itemSelected) {
      for (int i = 0; i < allItems.length; i++) {
        tempId = allItems[i]["supplierId"];
        if (!deletedElements.contains(tempId)) {
          deletedElements.add(tempId);
        }
      }
    } else {
      deletedElements.clear();
    }
  } else {
    if (itemSelected) {
      if (deletedElements.isNotEmpty) {
        if (!deletedElements.contains(itemId)) {
          deletedElements.add(itemId);
        }
      } else {
        deletedElements.add(itemId);
      }
    } else {
      if (deletedElements.isNotEmpty) {
        if (deletedElements.contains(itemId)) {
          deletedElements.remove(itemId);
        }
      }
    }
  }

  // return deletedElements;
}

void saleToBeDeleted(String allOrOne, String itemId, bool itemSelected,
    deletedElements, List<Map<String, dynamic>> allItems) {
  String tempId;
  if (allOrOne == "all") {
    if (itemSelected) {
      for (int i = 0; i < allItems.length; i++) {
        tempId = allItems[i]["saleId"];
        if (!deletedElements.contains(tempId)) {
          deletedElements.add(tempId);
        }
      }
    } else {
      deletedElements.clear();
    }
  } else {
    if (itemSelected) {
      if (deletedElements.isNotEmpty) {
        if (!deletedElements.contains(itemId)) {
          deletedElements.add(itemId);
        }
      } else {
        deletedElements.add(itemId);
      }
    } else {
      if (deletedElements.isNotEmpty) {
        if (deletedElements.contains(itemId)) {
          deletedElements.remove(itemId);
        }
      }
    }
  }

  // return deletedElements;
}

void updateProductQuantity(productDatabase, cartItems) {
  cartItems["cartItems"].forEach((oneItem) {
    for (int i = 0; i < productDatabase.length; i++) {
      if (oneItem["productId"] == productDatabase[i]["productId"]) {
        double newQuant = 0.00;
        String currentQuant = "";
        currentQuant = productDatabase[i]["quantity"];
        //print(currentQuant);
        newQuant = double.parse(currentQuant) - oneItem["quantity"];
        //print(newQuant);
        productDatabase[i]["quantity"] = newQuant.toString();
      }
    }
  });
}

List<Map<String, dynamic>> createProductItems(
    String initialVal, String initialDisp, listToProcess) {
  Map<String, dynamic> finalVals = {};

  finalVals["productId"] = initialVal;
  finalVals["productName"] = initialDisp;
  listToProcess.add(finalVals);
  return listToProcess;
}

List<Map<String, dynamic>> createUserItems(
    String initialVal, String initialDisp, listToProcess) {
  Map<String, dynamic> finalVals = {};
  List<Map<String, dynamic>> packagedList = [];
  finalVals["userId"] = initialVal;
  finalVals["userName"] = initialDisp;
  packagedList.add(finalVals);
  listToProcess.forEach((element) {
    finalVals = {};
    finalVals["userId"] = element["userId"];
    finalVals["userName"] = element["userDetails"]["firstName"];
    packagedList.add(finalVals);
  });

  return packagedList;
}

List<Map<String, dynamic>> processProductSaleList(
  productList,
  saleList,
  userList,
  String filterByProd,
  String filterByPaymentType,
  String filterBySettlementStatus,
  String filterByDate,
) {
  List<Map<String, dynamic>> processedList = [];

  saleList.forEach((saleInstance) {
    Map<String, dynamic> prodMap = {};
    var prodListInCart = saleInstance["cartDetails"];
    if (prodListInCart.length > 0) {
      for (var prodInCart in prodListInCart) {
        prodMap["productId"] = prodInCart["productId"];
        prodMap["productName"] = prodInCart["productName"];
        prodMap["quantity"] = prodInCart["quantity"];
        prodMap["pricePerUnit"] = prodInCart["pricePerUnit"];
        prodMap["discount"] = prodInCart["discount"];
        double total = (prodInCart["pricePerUnit"] * prodInCart["quantity"]) -
            prodInCart["discount"];
        prodMap["productTotal"] = total;
        prodMap["unitOfMeasurement"] = prodInCart["unitOfMeasurement"];
        prodMap["transactionDate"] = saleInstance["lastUpdatedOn"];
        prodMap["settlementStatus"] = saleInstance["settlementStatus"];
        //prodMap["settlementStatus"] = saleInstance["settlementStatus"];
        prodMap["checkoutMethod"] = saleInstance["checkoutMethod"];
        for (var userInst in userList) {
          if (userInst["userId"] == saleInstance["servedBy"]) {
            prodMap["servedBy"] =
                "${userInst["userDetails"]["firstName"]} ${userInst["userDetails"]["lastName"]}";
            break;
          }
        }
        processedList.add(prodMap);
        prodMap = {};
      }
    }
  });
  if (filterByProd != "all") {
    List<Map<String, dynamic>> filterByProdList = [];
    processedList.forEach((element) {
      if (element["productId"] == filterByProd) {
        filterByProdList.add(element);
      }
    });

    processedList = filterByProdList;
    //print(processedList);
  }
  if (filterByPaymentType != "all") {
    List<Map<String, dynamic>> filterByPaymentTypeList = [];
    processedList.forEach((element) {
      if (element["checkoutMethod"] == filterByPaymentType) {
        filterByPaymentTypeList.add(element);
      }
    });

    processedList = filterByPaymentTypeList;
    //print(processedList);
  }

  if (filterBySettlementStatus != "all") {
    List<Map<String, dynamic>> filterBySettlementStatusList = [];
    processedList.forEach((element) {
      if (element["settlementStatus"] == filterBySettlementStatus) {
        filterBySettlementStatusList.add(element);
      }
    });

    processedList = filterBySettlementStatusList;
    //print(processedList);
  }

  if (filterByDate != "all") {
    List<Map<String, dynamic>> filterByDateList = [];
    DateTime now = DateTime.now();
    int dayNumber = now.weekday;
    processedList.forEach((element) {
      if (filterByDate == "today") {
        DateTime transactionDate =
            DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
        DateTime presentTime = now;
        if (transactionDate.year == presentTime.year &&
            transactionDate.month == presentTime.month &&
            transactionDate.day == presentTime.day) {
          filterByDateList.add(element);
        }
      }
      if (filterByDate == "this week") {
        for (int i = dayNumber; i >= 1; i--) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = now.subtract(Duration(days: dayNumber - i));
          //String tempConv = DateFormat('yyyy-MM-dd').format(presentTime);
          //presentTime = DateFormat('dd/MM/yyyy').parse(tempConv);
          //print("${presentTime}: $transactionDate");
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }

      if (filterByDate == "last week") {
        int dayDelta = 0;
        if (dayNumber > 1) {
          dayDelta = dayNumber - 1;
        }
        DateTime mondayOfThisWeek = now.subtract(Duration(days: dayDelta));
        for (int i = 7; i >= 1; i--) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = mondayOfThisWeek.subtract(Duration(days: i));
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }

      if (filterByDate == "this month") {
        DateTime transactionDate =
            DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
        DateTime presentTime = now;
        if (transactionDate.year == presentTime.year &&
            transactionDate.month == presentTime.month) {
          filterByDateList.add(element);
        }
      }

      if (filterByDate == "last month") {
        DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
        DateTime firstDayOfLastMonth =
            DateTime(lastMonth.year, lastMonth.month, 1);
        DateTime lastDayOfLastMonth =
            DateTime(lastMonth.year, lastMonth.month + 1, 0);
        for (int i = 0; i < lastDayOfLastMonth.day; i++) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = firstDayOfLastMonth.add(Duration(days: i));
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }
    });

    processedList = filterByDateList;
  }
  //print(processedList);
  processedList
      .sort((a, b) => b["transactionDate"].compareTo(a["transactionDate"]));
  return processedList;
}

List<Map<String, dynamic>> processTransactionList(
  productList,
  saleList,
  userList,
  String filterByUser,
  String filterByPaymentType,
  String filterBySettlementStatus,
  String filterByDate,
) {
  List<Map<String, dynamic>> processedList = [];
  if (saleList.length > 0) {
    for (var saleInstance in saleList) {
      Map<String, dynamic> saleMap = {};
      saleMap["saleId"] = saleInstance["saleId"];
      saleMap["customerId"] = saleInstance["customerId"];
      saleMap["amountTotal"] = saleInstance["amountTotal"];
      saleMap["transactionDate"] = saleInstance["transactionDate"];
      saleMap["lastUpdatedOn"] = saleInstance["lastUpdatedOn"];
      saleMap["userId"] = saleInstance["servedBy"];
      for (var userInst in userList) {
        if (userInst["userId"] == saleInstance["servedBy"]) {
          saleMap["servedBy"] =
              "${userInst["userDetails"]["firstName"]} ${userInst["userDetails"]["lastName"]}";
          break;
        }
      }
      saleMap["cashReceived"] = saleInstance["cashReceived"];
      saleMap["cashReturned"] = saleInstance["cashReturned"];
      saleMap["checkoutMethod"] = saleInstance["checkoutMethod"];
      saleMap["settlementStatus"] = saleInstance["settlementStatus"];
      saleMap["creditDue"] = saleInstance["creditDue"];
      saleMap["cartDetails"] = saleInstance["cartDetails"];
      processedList.add(saleMap);
    }
  }
  //print(processedList);
  if (filterByUser != "all") {
    List<Map<String, dynamic>> filterByUserList = [];
    processedList.forEach((element) {
      if (element["userId"] == filterByUser) {
        filterByUserList.add(element);
      }
    });

    processedList = filterByUserList;
    //print(processedList);
  }

  if (filterByPaymentType != "all") {
    List<Map<String, dynamic>> filterByPaymentTypeList = [];
    processedList.forEach((element) {
      if (element["checkoutMethod"] == filterByPaymentType) {
        filterByPaymentTypeList.add(element);
      }
    });

    processedList = filterByPaymentTypeList;
    //print(processedList);
  }

  if (filterBySettlementStatus != "all") {
    List<Map<String, dynamic>> filterBySettlementStatusList = [];
    processedList.forEach((element) {
      if (element["settlementStatus"] == filterBySettlementStatus) {
        filterBySettlementStatusList.add(element);
      }
    });

    processedList = filterBySettlementStatusList;
    //print(processedList);
  }

  if (filterByDate != "all") {
    List<Map<String, dynamic>> filterByDateList = [];
    DateTime now = DateTime.now();
    int dayNumber = now.weekday;
    processedList.forEach((element) {
      if (filterByDate == "today") {
        DateTime transactionDate =
            DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
        DateTime presentTime = now;
        if (transactionDate.year == presentTime.year &&
            transactionDate.month == presentTime.month &&
            transactionDate.day == presentTime.day) {
          filterByDateList.add(element);
        }
      }
      if (filterByDate == "this week") {
        for (int i = dayNumber; i >= 1; i--) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = now.subtract(Duration(days: dayNumber - i));
          //String tempConv = DateFormat('yyyy-MM-dd').format(presentTime);
          //presentTime = DateFormat('dd/MM/yyyy').parse(tempConv);
          //print("${presentTime}: $transactionDate");
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }

      if (filterByDate == "last week") {
        int dayDelta = 0;
        if (dayNumber > 1) {
          dayDelta = dayNumber - 1;
        }
        DateTime mondayOfThisWeek = now.subtract(Duration(days: dayDelta));
        for (int i = 7; i >= 1; i--) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = mondayOfThisWeek.subtract(Duration(days: i));
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }

      if (filterByDate == "this month") {
        DateTime transactionDate =
            DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
        DateTime presentTime = now;
        if (transactionDate.year == presentTime.year &&
            transactionDate.month == presentTime.month) {
          filterByDateList.add(element);
        }
      }

      if (filterByDate == "last month") {
        DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
        DateTime firstDayOfLastMonth =
            DateTime(lastMonth.year, lastMonth.month, 1);
        DateTime lastDayOfLastMonth =
            DateTime(lastMonth.year, lastMonth.month + 1, 0);
        for (int i = 0; i < lastDayOfLastMonth.day; i++) {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["transactionDate"]);
          DateTime presentTime = firstDayOfLastMonth.add(Duration(days: i));
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            //print("yes");
            filterByDateList.add(element);
            break;
          }
        }
      }
    });

    processedList = filterByDateList;
  }
  processedList
      .sort((a, b) => b["lastUpdatedOn"].compareTo(a["lastUpdatedOn"]));
  return processedList;
}

List<Map<String, dynamic>> processSuppliesReportList(
  productList,
  supplierList,
  inventoryList,
  String filterBySupplier,
  String filterByDate,
) {
  List<Map<String, dynamic>> processedList = [];
  if (productList.length > 0 &&
      supplierList.length > 0 &&
      inventoryList.length > 0) {
    for (var prodInstance in productList) {
      Map<String, dynamic> supplyMap = {};
      supplyMap["productName"] = prodInstance["productName"];
      for (var suppInstance in supplierList) {
        if (prodInstance["supplierId"] == suppInstance["supplierId"]) {
          supplyMap["supplierId"] = suppInstance["supplierId"];
          supplyMap["supplierName"] = suppInstance["supplierName"];
          break;
        }
      }
      for (var inventoryInstance in inventoryList) {
        if (inventoryInstance["productId"] == prodInstance["productId"]) {
          supplyMap["suppliedQuantity"] =
              inventoryInstance["totalPurchasedQuantity"];
          supplyMap["valueOfSupplies"] =
              inventoryInstance["totalPurchasedAmount"];
          supplyMap["lastSupplyDate"] = inventoryInstance["lastUpdatedOn"];
          break;
        }
      }
      processedList.add(supplyMap);
    }
    if (filterBySupplier != "all") {
      List<Map<String, dynamic>> filterBySupplierList = [];
      processedList.forEach((element) {
        if (element["supplierId"] == filterBySupplier) {
          filterBySupplierList.add(element);
        }
      });

      processedList = filterBySupplierList;
      //print(processedList);
    }

    if (filterByDate != "all") {
      List<Map<String, dynamic>> filterByDateList = [];
      DateTime now = DateTime.now();
      int dayNumber = now.weekday;
      processedList.forEach((element) {
        if (filterByDate == "today") {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["lastSupplyDate"]);
          DateTime presentTime = now;
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month &&
              transactionDate.day == presentTime.day) {
            filterByDateList.add(element);
          }
        }
        if (filterByDate == "this week") {
          for (int i = dayNumber; i >= 1; i--) {
            DateTime transactionDate =
                DateFormat('dd/MM/yyyy').parse(element["lastSupplyDate"]);
            DateTime presentTime = now.subtract(Duration(days: dayNumber - i));
            //String tempConv = DateFormat('yyyy-MM-dd').format(presentTime);
            //presentTime = DateFormat('dd/MM/yyyy').parse(tempConv);
            //print("${presentTime}: $transactionDate");
            if (transactionDate.year == presentTime.year &&
                transactionDate.month == presentTime.month &&
                transactionDate.day == presentTime.day) {
              //print("yes");
              filterByDateList.add(element);
              break;
            }
          }
        }

        if (filterByDate == "last week") {
          int dayDelta = 0;
          if (dayNumber > 1) {
            dayDelta = dayNumber - 1;
          }
          DateTime mondayOfThisWeek = now.subtract(Duration(days: dayDelta));
          for (int i = 7; i >= 1; i--) {
            DateTime transactionDate =
                DateFormat('dd/MM/yyyy').parse(element["lastSupplyDate"]);
            DateTime presentTime = mondayOfThisWeek.subtract(Duration(days: i));
            if (transactionDate.year == presentTime.year &&
                transactionDate.month == presentTime.month &&
                transactionDate.day == presentTime.day) {
              //print("yes");
              filterByDateList.add(element);
              break;
            }
          }
        }

        if (filterByDate == "this month") {
          DateTime transactionDate =
              DateFormat('dd/MM/yyyy').parse(element["lastSupplyDate"]);
          DateTime presentTime = now;
          if (transactionDate.year == presentTime.year &&
              transactionDate.month == presentTime.month) {
            filterByDateList.add(element);
          }
        }

        if (filterByDate == "last month") {
          DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
          DateTime firstDayOfLastMonth =
              DateTime(lastMonth.year, lastMonth.month, 1);
          DateTime lastDayOfLastMonth =
              DateTime(lastMonth.year, lastMonth.month + 1, 0);
          for (int i = 0; i < lastDayOfLastMonth.day; i++) {
            DateTime transactionDate =
                DateFormat('dd/MM/yyyy').parse(element["lastSupplyDate"]);
            DateTime presentTime = firstDayOfLastMonth.add(Duration(days: i));
            if (transactionDate.year == presentTime.year &&
                transactionDate.month == presentTime.month &&
                transactionDate.day == presentTime.day) {
              //print("yes");
              filterByDateList.add(element);
              break;
            }
          }
        }
      });

      processedList = filterByDateList;
    }
  }
  processedList
      .sort((a, b) => b["lastSupplyDate"].compareTo(a["lastSupplyDate"]));
  return processedList;
}

double calculateFilteredTotal(processedList, String payType) {
  double totalAmount = 0.00;
  if (processedList.length > 0) {
    if (payType == "cash") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += double.parse(element["amountTotal"]);
        }
      });
    }
    if (payType == "mpesa") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += double.parse(element["amountTotal"]);
        }
      });
    }
    if (payType == "credit") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += double.parse(element["creditDue"]);
        }
      });
    }
  }
  return totalAmount;
}

double calculateFilteredProductTotal(processedList, String payType) {
  double totalAmount = 0.00;
  if (processedList.length > 0) {
    if (payType == "cash") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += element["productTotal"];
        }
      });
    }
    if (payType == "mpesa") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += element["productTotal"];
        }
      });
    }
    if (payType == "credit") {
      processedList.forEach((element) {
        if (element["checkoutMethod"] == payType) {
          totalAmount += element["productTotal"];
        }
      });
    }
  }
  return totalAmount;
}

int getProductsUnderCategory(productList, String catId) {
  int totalCount = 0;
  productList.forEach((element) {
    if (element["categoryId"] == catId) {
      totalCount += 1;
    }
  });
  return totalCount;
}

int getUnreadNotifications() {
  int unreadCount = 0;
  List<Map<String, dynamic>> new_notification_database =
      notificationDetailsPreference.getNotificationData() ?? [];
  new_notification_database.forEach((element) {
    if (element["read"] == "no") {
      unreadCount += 1;
    }
  });
  return unreadCount;
}

List<Map<String, dynamic>> expiredProducts() {
  List<Map<String, dynamic>> processedList = [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  DateTime currentDate = DateTime.now();
  new_product_database.forEach((element) {
    Map<String, dynamic> prodItem = {};
    bool expiryDateReached = false;
    if (element["expiryStatus"] == "yes") {
      String dateOfExpiry = element["expiryDate"];
      DateTime storedDate = DateFormat('dd/MM/yyyy').parse(dateOfExpiry);
      expiryDateReached = currentDate.isAfter(storedDate) ||
          currentDate.isAtSameMomentAs(storedDate);
      if (expiryDateReached == true) {
        prodItem["productId"] = element["productId"];
        prodItem["productName"] = element["productName"];
        prodItem["quantity"] = element["quantity"];
        prodItem["expiryDate"] = element["expiryDate"];
        processedList.add(prodItem);
      }
    }
  });
  processedList.sort((a, b) => b["expiryDate"].compareTo(a["expiryDate"]));
  return processedList;
}

List<Map<String, dynamic>> recentProducts() {
  List<Map<String, dynamic>> processedList = [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  if (new_product_database.length > 0) {
    new_product_database
        .sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
  }
  for (var product in new_product_database) {
    Map<String, dynamic> prodItem = {};
    prodItem["productId"] = product["productId"];
    prodItem["productName"] = product["productName"];
    prodItem["createdOn"] = product["createdOn"];
    prodItem["retailPrice"] = product["retailPrice"];
    //add category
    String categoryName = "";
    for (var catInstance in new_category_database) {
      if (product["categoryId"] == catInstance["categoryId"]) {
        categoryName = catInstance["categoryName"];
        break;
      }
    }
    prodItem["categoryName"] = categoryName;
    //add supplier
    String supplierName = "";
    for (var suppInstance in new_supplier_database) {
      if (product["supplierId"] == suppInstance["supplierId"]) {
        supplierName = suppInstance["supplierName"];
        break;
      }
    }
    prodItem["supplierName"] = supplierName;
    processedList.add(prodItem);
    if (processedList.length >= 10) {
      break;
    }
  }
  processedList.sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
  return processedList;
}

List<Map<String, dynamic>> outOfStockProducts() {
  List<Map<String, dynamic>> processedList = [];
  List<Map<String, dynamic>> new_product_database =
      productDetailsPreference.getProductData() ?? [];
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  if (new_product_database.length > 0) {
    new_product_database
        .sort((a, b) => b["createdOn"].compareTo(a["createdOn"]));
  }
  for (var product in new_product_database) {
    Map<String, dynamic> prodItem = {};
    if (double.parse(product["quantity"]) <
        double.parse(product["minimumQuantity"])) {
      prodItem["productId"] = product["productId"];
      prodItem["productName"] = product["productName"];
      prodItem["supplierId"] = product["supplierId"];
      String supplierName = "";
      for (var suppInstance in new_supplier_database) {
        if (product["supplierId"] == suppInstance["supplierId"]) {
          supplierName = suppInstance["supplierName"];
          break;
        }
      }
      prodItem["supplierName"] = supplierName;
      processedList.add(prodItem);
    }
  }
  return processedList;
}

List<Map<String, dynamic>> productsToPrint(
    List<Map<String, dynamic>> productList) {
  List<Map<String, dynamic>> new_supplier_database =
      supplierDetailsPreference.getSupplierData() ?? [];
  List<Map<String, dynamic>> new_category_database =
      categoryDetailsPreference.getCategoryData() ?? [];
  List<Map<String, dynamic>> printableProducts = [];
  if (productList.length > 0) {
    productList.sort((a, b) => a["productName"].compareTo(b["productName"]));
  }
  for (var product in productList) {
    Map<String, dynamic> prodItem = {};
    prodItem["productId"] = product["productId"];
    prodItem["productName"] = product["productName"];
    prodItem["createdOn"] = product["createdOn"];
    prodItem["unitOfMeasurement"] = product["unitOfMeasurement"];
    prodItem["stockPrice"] = product["stockPrice"];
    prodItem["retailPrice"] = product["retailPrice"];
    prodItem["discountType"] = product["discountType"];
    prodItem["recommendedDiscount"] = product["recommendedDiscount"];
    prodItem["quantity"] = product["quantity"];
    prodItem["expiryDate"] = product["expiryDate"];
    //add category
    String categoryName = "";
    for (var catInstance in new_category_database) {
      if (product["categoryId"] == catInstance["categoryId"]) {
        categoryName = catInstance["categoryName"];
        break;
      }
    }
    prodItem["categoryName"] = categoryName;
    //add supplier
    String supplierName = "";
    for (var suppInstance in new_supplier_database) {
      if (product["supplierId"] == suppInstance["supplierId"]) {
        supplierName = suppInstance["supplierName"];
        break;
      }
    }
    prodItem["supplierName"] = supplierName;
    printableProducts.add(prodItem);
  }
  //print(printableProducts);
  return printableProducts;
}

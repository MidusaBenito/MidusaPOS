import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

import 'package:midusa_pos/workers/workers.dart';

class changeDisplayedSection with ChangeNotifier {
  //this provider is redundant
  String _activeSection = "adminOverview";
  void changePage(String newPage) {
    _activeSection = newPage;
    notifyListeners();
  }

  String get activeSection => _activeSection;
}

class updateCheckBox with ChangeNotifier {
  bool _checkBoxVal = false;
  void changeVal(bool newVal, String allOrOne, String itemId, deletedElements,
      List<Map<String, dynamic>> allItems) {
    //_checkBoxVal = newVal;
    allOrOne == "all" ? _checkBoxVal = newVal : _checkBoxVal = false;
    itemsToBeDeleted(allOrOne, itemId, newVal, deletedElements, allItems);

    notifyListeners();
  }

  bool get checkBoxVal => _checkBoxVal;
}

class updateExpiryDate with ChangeNotifier {
  //String _activeSection = "adminOverview";
  void changeDate(dateTime, selectedDate, expiryDateController) {
    //print("object here there");
    selectedDate = dateTime;
    expiryDateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    //print(expiryDateController.text);
    notifyListeners();
  }

  void updateVisibility(String expiryStatus, productExpires) {
    productExpires = expiryStatus;
    notifyListeners();
  }

  void updateDiscount(String discountStatus, discountType) {
    discountType = discountStatus;
    notifyListeners();
  }
}

class displayProducts with ChangeNotifier {
  String _typeOfDisplay = "all";
  void changeTypeOfDisplay(String catId) {
    _typeOfDisplay = catId;
    notifyListeners();
  }

  String get typeOfDisplay => _typeOfDisplay;
}

class refreshCart with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class refreshQuantity with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class processCheckout with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class prod_updateCheckBox with ChangeNotifier {
  bool _checkBoxVal = false;
  void changeVal(bool newVal, String allOrOne, String itemId, deletedElements,
      List<Map<String, dynamic>> allItems) {
    //_checkBoxVal = newVal;
    allOrOne == "all" ? _checkBoxVal = newVal : _checkBoxVal = false;
    productsToBeDeleted(allOrOne, itemId, newVal, deletedElements, allItems);

    notifyListeners();
  }

  bool get checkBoxVal => _checkBoxVal;
}

class cat_updateCheckBox with ChangeNotifier {
  bool _checkBoxVal = false;
  void changeVal(bool newVal, String allOrOne, String itemId, deletedElements,
      List<Map<String, dynamic>> allItems) {
    //_checkBoxVal = newVal;
    allOrOne == "all" ? _checkBoxVal = newVal : _checkBoxVal = false;
    categoriesToBeDeleted(allOrOne, itemId, newVal, deletedElements, allItems);

    notifyListeners();
  }

  bool get checkBoxVal => _checkBoxVal;
}

class supp_updateCheckBox with ChangeNotifier {
  bool _checkBoxVal = false;
  void changeVal(bool newVal, String allOrOne, String itemId, deletedElements,
      List<Map<String, dynamic>> allItems) {
    //_checkBoxVal = newVal;
    allOrOne == "all" ? _checkBoxVal = newVal : _checkBoxVal = false;
    suppliersToBeDeleted(allOrOne, itemId, newVal, deletedElements, allItems);

    notifyListeners();
  }

  bool get checkBoxVal => _checkBoxVal;
}

class sale_updateCheckBox with ChangeNotifier {
  bool _checkBoxVal = false;
  void changeVal(bool newVal, String allOrOne, String itemId, deletedElements,
      List<Map<String, dynamic>> allItems) {
    //_checkBoxVal = newVal;
    allOrOne == "all" ? _checkBoxVal = newVal : _checkBoxVal = false;
    saleToBeDeleted(allOrOne, itemId, newVal, deletedElements, allItems);

    notifyListeners();
  }

  bool get checkBoxVal => _checkBoxVal;
}

class updateCustomer with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class updatePausedCarts with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class filterSaleItems with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

class changeSalePageTabsColor with ChangeNotifier {
  String _activeSection = "overallReport";
  void changePage(String newPage) {
    _activeSection = newPage;
    notifyListeners();
  }

  String get activeSection => _activeSection;
}

class displayCustomers with ChangeNotifier {
  String _typeOfDisplay = "all";
  void changeTypeOfDisplay(String catId) {
    _typeOfDisplay = catId;
    notifyListeners();
  }

  String get typeOfDisplay => _typeOfDisplay;
}
//class enabledDateField with ChangeNotifier {
//bool _activeDateField = false;
//void updateVisibility(String expiryStatus) {
// if (expiryStatus == "yes") {
// _activeDateField = true;
//}
//notifyListeners();
//}

// bool get activeDateField => _activeDateField;
//}
//ValueNotifier<bool> myValueNotifier = ValueNotifier<bool>(false);
class clearPendingPayments with ChangeNotifier {
  void hitRefresh() {
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midusa_pos/local_database/notifications_utils.dart';
import 'package:window_manager/window_manager.dart';
import 'local_database/overal_utils.dart';
import 'local_database/user_utils.dart';
import 'local_database/category_utils.dart';
import 'local_database/product_utils.dart';
import 'local_database/supplier_utils.dart';
import 'local_database/sale_utils.dart';
import 'local_database/customer_utils.dart';
import 'local_database/paused_cart_utils.dart';
import 'local_database/stock_inventory_utils.dart';
import 'splash_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle('Midusa');
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setSize(const Size(1180, 645));
    await windowManager.setMinimumSize(const Size(1180, 645));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //initializing preferences
  await userDetailsPreference.init();
  await overalDataPreference.init();
  await categoryDetailsPreference.init();
  await productDetailsPreference.init();
  await supplierDetailsPreference.init();
  await saleDetailsPreference.init();
  await customerDetailsPreference.init();
  await pausedCartDetailsPreference.init();
  await stockPurchaseInventoryPreference.init();
  await notificationDetailsPreference.init();
  //await messageDetailsPreference.init();
  //await stockPurchaseInventoryPreference.setStockPurchaseInventory([]);
  //await saleDetailsPreference.setSaleData([]);
  //print("is it?");
  //await overalDataPreference.setAdminCreatedStatus(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: myAnimatedPage(),
    );
  }
}

import 'package:basic_utils/basic_utils.dart' hide Consumer;
import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/workers/workers.dart';
//import 'package:provider/provider.dart';
//import 'package:midusa_pos/midusa_providers/midusa_providers.dart';

class adminCreateNewSupplier extends StatelessWidget {
  adminCreateNewSupplier(
      {super.key, required this.userId, required this.activePage});
  String userId;
  String activePage;
  List<Map<String, dynamic>> user_data_base =
      userDetailsPreference.getUserData() ?? [];

  @override
  Widget build(BuildContext context) {
    saveNotificationDetails();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            adminTopNavSection(context, user_data_base, userId, activePage),
            Divider(),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                //The main Row
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //This is the navigation column
                  adminNavColumn(context, userId, activePage),
                  //end of navigation column
                  //This is where i fit the dynamic content
                  createNewSupplier(context, userId),
                  //end of dynamic content
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

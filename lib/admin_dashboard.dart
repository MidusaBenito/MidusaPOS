import 'package:basic_utils/basic_utils.dart' hide Consumer;
import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;
import 'package:midusa_pos/local_database/user_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midusa_pos/my_widgets/my_widgets.dart';
import 'package:midusa_pos/workers/workers.dart';
//import 'package:provider/provider.dart';
//import 'package:midusa_pos/midusa_providers/midusa_providers.dart';

class adminDashboard extends StatelessWidget {
  adminDashboard({super.key, required this.userId, required this.activePage});
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
                  adminNavColumn(context, userId, "overallDashboard"),
                  //end of navigation column
                  //This is where i fit the dynamic content
                  overallDashboard(userId),
                  //end of dynamic content
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAdminNames() {
    List<Map<String, dynamic>> user_data_base =
        userDetailsPreference.getUserData() ?? [];
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
                  "${StringUtils.capitalize(user_data_base[i]["userDetails"]["role"])}",
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
}

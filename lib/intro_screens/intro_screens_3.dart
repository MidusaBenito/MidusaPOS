import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class introScreenThree extends StatelessWidget {
  const introScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor.AppColor.splashPageBackground3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Unlock the potential of your retail store",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "and maximize profitability",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Opacity(
                opacity: .8,
                child: Image.asset(
                  "assets/images/image2.png",
                  height: 350,
                  width: 350,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class introScreenTwo extends StatelessWidget {
  const introScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor.AppColor.splashPageBackground2,
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
                  "Experience seamless transactions and enhanced efficiency",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "with your trusted point of sale companion",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Opacity(
                opacity: .8,
                child: Image.asset(
                  "assets/images/image1.png",
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

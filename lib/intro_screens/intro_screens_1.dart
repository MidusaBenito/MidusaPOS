import 'package:flutter/material.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class introScreenOne extends StatelessWidget {
  const introScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor.AppColor.splashPageBackground,
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
                  "Simplify sales management with",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Midusa\u00AE",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "- the perfect POS software for small and large businesses alike",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Opacity(
                opacity: .8,
                child: Image.asset(
                  "assets/images/image3.png",
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

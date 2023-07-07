import 'dart:io';

import 'package:midusa_pos/workers/workers.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generate(userList) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      pageFormat: PdfPageFormat.a4,
      build: (context) => <Widget>[
        Header(
            child: Column(children: [
          Row(children: [
            Expanded(child: Container()),
            Text("Midusa Point of Sale"),
            Expanded(child: Container()),
          ]),
          Row(children: [
            Expanded(child: Container()),
            Text("Phone: +254791440121"),
            Expanded(child: Container()),
          ]),
          Row(children: [
            Expanded(child: Container()),
            Text("email: talk2us@midusatech.com"),
            Expanded(child: Container()),
          ]),
          Row(children: [
            Text("List of Authorized POS users"),
            Expanded(child: Container()),
            Text(
              "${DateTime.now()}",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              ),
            ),
          ])
        ])),
        Column(
          children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Text(
                  "User Id",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Role",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Date created",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Last updated on",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              )
            ]),
            SizedBox(height: 5),
            ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  var userInstance = userList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          userInstance["userId"],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${userInstance["userDetails"]["firstName"]} ${userInstance["userDetails"]["lastName"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          userInstance["userDetails"]["phoneNumber"],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${roleFormatter(userInstance["userDetails"]["role"])}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          userInstance["userDetails"]["created_on"],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          userInstance["userDetails"]["last_updated_on"],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                        ),
                      )
                    ]),
                  );
                }),
          ],
        ),
      ],
    ));
    return saveDocument(name: "pos_users.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

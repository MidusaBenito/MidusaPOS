import 'dart:io';

import 'package:midusa_pos/workers/workers.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class transactionPdfApi {
  static Future<File> generate(transactionItems) async {
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
            Text("List of Transactions"),
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
                flex: 2,
                child: Text(
                  "Transaction Id",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Amount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Cart items",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Payment type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Status",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Amnt received",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Amnt returned",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Credit due",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Served by",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 5),
            ListView.builder(
                itemCount: transactionItems.length,
                itemBuilder: (context, index) {
                  var transInstance = transactionItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${transInstance["saleId"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["amountTotal"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(children: [
                            Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "product name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 6,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "qty",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 6,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "unit price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 6,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "disc",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 6,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 6,
                                    ),
                                  ))
                            ]),
                            SizedBox(height: 1),
                            ListView.builder(
                                itemCount: transInstance["cartDetails"].length,
                                itemBuilder: (context, index) {
                                  var productInstance =
                                      transInstance["cartDetails"][index];
                                  double total =
                                      (productInstance["pricePerUnit"] *
                                              productInstance["quantity"]) -
                                          productInstance["discount"];
                                  return Row(children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          productInstance["productName"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 6,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${productInstance["quantity"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 6,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${productInstance["pricePerUnit"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 6,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${productInstance["discount"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 6,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "$total",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 6,
                                          ),
                                        ))
                                  ]);
                                }),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["checkoutMethod"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["settlementStatus"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["cashReceived"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["cashReturned"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${transInstance["creditDue"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${transInstance["servedBy"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${transInstance["lastUpdatedOn"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
          ],
        ),
      ],
    ));
    return saveDocument(name: "pos_transactions.pdf", pdf: pdf);
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

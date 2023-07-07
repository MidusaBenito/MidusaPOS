import 'dart:io';

import 'package:midusa_pos/workers/workers.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class productPdfApi {
  static Future<File> generate(productList) async {
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
            Text("List of All Products"),
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
                  "Product Id",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Supplier",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "UoM",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Qty",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Stock price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Rrp",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Disc Type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Disc",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Created",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Expiry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 5),
            ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  var productInstance = productList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["productId"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            productInstance["productName"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["categoryName"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["supplierName"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["unitOfMeasurement"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["quantity"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["stockPrice"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["retailPrice"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["discountType"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["recommendedDiscount"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["createdOn"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            productInstance["expiryDate"],
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
    return saveDocument(name: "pos_products.pdf", pdf: pdf);
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

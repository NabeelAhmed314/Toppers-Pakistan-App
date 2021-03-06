import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:toppers_pakistan/models/category_model.dart';
import 'package:toppers_pakistan/models/product_model.dart';
import 'package:toppers_pakistan/pages/model.dart';
import 'package:toppers_pakistan/pages/order_confirm.dart';

class Order extends StatefulWidget {
  final CategoryModel categoryModel;

  Order({this.categoryModel});

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: widget.categoryModel.fetchProduct(widget.categoryModel.id),
          builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("No Connection");
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmOrder(
                                product: snapshot.data[i],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "http://nabeel-pc:8000/images/products/" +
                                          snapshot.data[i].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[i].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Price: " +
                                              snapshot.data[i].unitPrice +
                                              " Rs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "serving(s) " +
                                              snapshot.data[i].serving +
                                              " person",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

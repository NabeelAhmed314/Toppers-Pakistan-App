import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:toppers_pakistan/cart/cart.dart';
import 'package:toppers_pakistan/cart_list.dart';
import 'package:toppers_pakistan/drawer/about_us.dart';
import 'package:toppers_pakistan/drawer/account.dart';
import 'package:toppers_pakistan/models/carosel_model.dart';
import 'package:toppers_pakistan/models/local-data.dart';
import 'package:toppers_pakistan/pages/carosalpage.dart';
import 'package:toppers_pakistan/pages/custom-drawer-guest.dart';
import 'package:toppers_pakistan/pages/custom-drawer.dart';
import 'package:toppers_pakistan/services/carosel_service.dart';
import 'package:toppers_pakistan/services/category_service.dart';
import 'package:toppers_pakistan/models/category_model.dart';

import 'package:toppers_pakistan/drawer/notification.dart';
import 'package:toppers_pakistan/pages/model.dart';
import 'package:toppers_pakistan/pages/order.dart';

import '../simple-future-builder.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final _service = CategoryService();

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: new Text(
              "Warning",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: Text(
              "Your Cart is Empty!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Do you want to exit this application?'),
            content: new Text('We hate to see you leave...'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        //  backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Colors.black,
          title: Text(
            "MENU",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                print(CartList.orderItems.length);
                if (CartList.orderItems.length == 0) {
                  _showErrorDialog();
                } else {
                  if (LocalData.currentCustomer == null) {
                    _showErrorDialog();
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  }
                }
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.add_shopping_cart),
            ),
            Positioned(
              right: 7,
              top: 7,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  CartList.orderItems == null
                      ? "0"
                      : CartList.orderItems.length.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        drawer: LocalData.currentCustomer == null
            ? CustomDrawerGuest()
            : CustomDrawer(),
        body: Container(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Carosal(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 18,
                  color: Color(0xffCE862A),
                  child: Center(
                      child: Text(
                    "CATEGORIES",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _service.fetchAll(),
                    builder:
                        (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
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
                            return GridView.builder(
                                itemCount: snapshot.data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1 / 1.05,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 5),
                                itemBuilder: (context, i) {
                                  return Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Order(
                                              categoryModel: snapshot.data[i]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              "http://nabeel-pc:8000/images/category/" +
                                                  snapshot.data[i].image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 140,
                                          width: 140,
                                        ),
                                        SizedBox(height: 9),
                                        Text(snapshot.data[i].name)
                                      ],
                                    ),
                                  ));
                                });
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

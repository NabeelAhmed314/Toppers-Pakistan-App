import 'package:flutter/material.dart';
import 'package:toppers_pakistan/cart/cart.dart';
import 'package:toppers_pakistan/drawer/about_us.dart';
import 'package:toppers_pakistan/drawer/account.dart';
import 'package:toppers_pakistan/drawer/notification.dart';
import 'package:toppers_pakistan/models/local-data.dart';
import 'package:toppers_pakistan/pages/signin.dart';
import 'package:toppers_pakistan/pages/signup.dart';

import '../cart_list.dart';

class CustomDrawerGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height / 15,
            child: Center(
              child: Text(
                "MENU",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.fastfood,
              color: Colors.black,
            ),
            title: Text(
              "MENU",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUS()));
            },
            leading: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            title: Text(
              "ABOUT US",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              LocalData.currentCustomer = null;
              CartList.orderItems = new List();
              CartList.instruction = null;
              CartList.address = null;
              CartList.totalPrice = null;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Signin()));
            },
            leading: Icon(
              Icons.devices_other,
              color: Colors.black,
            ),
            title: Text(
              "SIGN IN",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              LocalData.currentCustomer = null;
              CartList.orderItems = new List();
              CartList.instruction = null;
              CartList.address = null;
              CartList.totalPrice = null;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            leading: Icon(
              Icons.devices_other,
              color: Colors.black,
            ),
            title: Text(
              "SIGN UP",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:toppers_pakistan/drawer/account/address.dart';
import 'package:toppers_pakistan/drawer/account/change-password.dart';
import 'package:toppers_pakistan/drawer/account/order_history.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SETTINGS"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45)),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderHistory()));
                },
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                leading: Icon(
                  Icons.timer,
                  color: Colors.black,
                ),
                title: Text("Orders History"),
                trailing: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 70,
                  color: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45)),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Address()));
                },
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                leading: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                title: Text("Address"),
                trailing: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 70,
                  color: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45)),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: Text("Change Password"),
                trailing: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 70,
                  color: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
